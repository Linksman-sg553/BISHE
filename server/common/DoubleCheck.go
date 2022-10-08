package common

import (
	"fmt"
	"github.com/jinzhu/gorm"
	"math"
	"server/model"
	"strconv"
	"strings"
)

type Double_store struct {
	Paper_id  int    `gorm:"int"`
	Text_id   int    `gorm:"int"`
	Post_list string `gorm:"varchar(255)"`
}

// DoublePost 二审列表
type DoublePost struct {
	ArticleOrigin model.Article
	PostList      []int
}

// AddPost
// map不是太能直接操纵value
func (myself *DoublePost) AddPost(arcID int) {
	myself.PostList = append(myself.PostList, arcID)
}
func (myself *DoublePost) SetData(text_id int, pList []int) {
	myself.ArticleOrigin = model.Article{}
	DB.Where("text_id = ?", text_id).First(&myself.ArticleOrigin)
	if myself.ArticleOrigin.Text_id == 0 {
		fmt.Println("文章没找到")
	}
	for _, itx := range pList {
		myself.PostList = append(myself.PostList, itx)
	}
}

/**********************************************************************************/

// DoubleList 记录二审对象 map[paper_id]DoubleList
var DoubleList map[int]DoublePost

func GetDoubleAll() {
	DB := GetDB()

	var DoubleL []Double_store
	DB.Model(&Double_store{}).Find(&DoubleL)

	for _, iValue := range DoubleL {
		if len(iValue.Post_list) != 0 {
			newListStr := strings.Split(iValue.Post_list, ",")
			var newListInt []int
			for _, iData := range newListStr {
				if iData != "" {
					i, _ := strconv.Atoi(iData)
					newListInt = append(newListInt, i)
				}
			}
			iDouble := DoubleList[iValue.Paper_id]
			iDouble.SetData(iValue.Text_id, newListInt)
			DoubleList[iValue.Paper_id] = iDouble
			fmt.Println(DoubleList[iValue.Paper_id].ArticleOrigin.Text_id)
		} else {
			a := make([]int, 0)
			iDouble := DoubleList[iValue.Paper_id]
			iDouble.SetData(iValue.Text_id, a)
			DoubleList[iValue.Paper_id] = iDouble
			fmt.Println(DoubleList[iValue.Paper_id].ArticleOrigin.Text_id)
		}
	}
}

// CheckDoubleStatus 该函数判断文章的评论状态
func CheckDoubleStatus(article model.Article, DB *gorm.DB) (isDouble bool) {
	// 查询评论数
	var countComment int32
	DB.Model(&model.Comment{}).Where("publish_article=?", article.Text_id).Count(&countComment)

	// 大于10了查看分数
	if countComment >= 10 {
		// 分数小于4触发二次审查
		if article.Score < 4 {
			article.Article_status = 2
			DB.Model(&model.Article{}).Where("text_id=?", article.Text_id).Update("article_status", 2)
			var listP = make([]int, 0)
			DoubleList[article.Paper_id] = DoublePost{ArticleOrigin: article, PostList: listP}
			return true
		}
		return false
	}
	return false
}

// PostDouble 接收二审论文的评论 满四次做最终审判
// toDO: 这块的代码非常的不好，将服务与模型控制与数据库耦在一块了，应该将模型操作交给控制器
func PostDouble(article model.Article, DB *gorm.DB) int {
	// 增加评审次数 与断案列表
	iPostList := DoubleList[article.Paper_id]
	ok := Find(iPostList.PostList, article.Text_id)
	if ok {
		return 0
	}

	iDouble := DoubleList[article.Paper_id]
	iDouble.AddPost(article.Text_id)
	DoubleList[article.Paper_id] = iDouble
	var iDs = Double_store{}
	DB.Where("paper_id=?", article.Paper_id).First(&iDs)
	newSore := iDs.Post_list
	newSore += ","
	newSore += strconv.Itoa(article.Text_id)
	DB.Model(&Double_store{}).Where("paper_id=?", article.Paper_id).Update("post_list", newSore)

	// 检查判案条件是否满足
	if len(iDouble.PostList) == 4 {
		// 计算这四文章的平均分与被二审的文章的出入
		if judgeDouble(article.Paper_id) == false {
			// toDO: 定罪后应对论文、作者、来访者全都重新评估
			iDouble.ArticleOrigin.Article_status = 3 //Black
			articleBlackStatus(&iDouble.ArticleOrigin)
			// 内存回置
			//DoubleList[article.Paper_id] = iDouble
			// 二审结束，将此论文剔除
			delete(DoubleList, article.Paper_id)
			DB.Exec("DELETE from double_stores where paper_id=? and text_id=?", iDouble.ArticleOrigin.Paper_id, iDouble.ArticleOrigin.Text_id)
			return 1
		} else {
			article.Article_status = 1 //White
			DB.Model(&article).Where("text_id=?", iDouble.ArticleOrigin.Text_id).Update("article_status", 1)
			// 内存回置
			//DoubleList[article.Paper_id] = iDouble
			delete(DoubleList, article.Paper_id)
			//DB.Where("paper_id=?", iDouble.ArticleOrigin.Paper_id).Delete(&Double_store{})
			DB.Exec("DELETE from double_stores where paper_id=? and text_id=?", iDouble.ArticleOrigin.Paper_id, iDouble.ArticleOrigin.Text_id)
			return 2
		}

	}
	DoubleList[article.Paper_id] = iDouble
	return 0
}

// judgeDouble 私有函数 判断这个二审文章是不是无辜的
func judgeDouble(paperID int) (isInnocent bool) {
	DB := GetDB()

	// 记录均分 同时注意加权平均
	var averageScore float64 = 0
	var weights float64 = 0
	for _, iArcID := range DoubleList[paperID].PostList {
		var arc = model.Article{}
		var auth = model.User{}
		DB.Find(&arc, "text_id=?", iArcID)
		DB.Find(&auth, "user_id=?", arc.Author)
		weights += float64(auth.Verify)
		averageScore = (averageScore + float64(arc.Rate*auth.Verify)) / weights
	}

	// 上下超过两分就判有罪
	if math.Abs(averageScore-float64(DoubleList[paperID].ArticleOrigin.Rate)) > 2 {
		return false
	}

	return true
}

func Find(slice []int, ele int) bool {
	for _, iData := range slice {
		if iData == ele {
			return true
		}
	}
	return false
}
