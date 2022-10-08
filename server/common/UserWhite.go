package common

import (
	"math"
	"server/model"
	"server/util"
	"sort"
)

// toDO : 白名单状态更新 ： 当论文的评分变动 查询用户的准确率map看谁评价过该论文，将评论过改论文的人的准确率更新

type UserWhiteData struct {
	User_id  int     `gorm:"user_id int primary key"`
	Accuracy float64 `gorm:"accuracy double"`
}
type UserAcc struct {
	accuracy  float64
	paperList map[int]bool
}

func (myself *UserAcc) SetAccStatus(pList map[int]bool, acc float64) {
	myself.accuracy = acc
	myself.paperList = make(map[int]bool)
	for k, v := range pList {
		myself.paperList[k] = v
	}
}

func (myself *UserAcc) UpdateAccStatus(paperID int, userID int) {
	DB := GetDB()

	// 获取论文评分与该用户的评分
	var requestArticle = model.Article{}
	var requestPaper = model.Paper_list{}
	DB.Where("paper_id=?", paperID).First(&requestPaper)
	DB.Where("text_id=? and author=?", requestPaper.Paper_id, userID).First(&requestArticle)
	if requestArticle.Text_id == 0 {
		return
	}

	// 更新该用户对此论文的评论准确状态
	if math.Abs(requestPaper.Score-float64(requestArticle.Rate)) > 1 {
		myself.paperList[paperID] = false
	} else {
		myself.paperList[paperID] = true
	}
	// 更新 accuracy
	var ac float64 = 0
	for _, v := range myself.paperList {
		if !v {
			ac++
		}
	}
	myself.accuracy = ac / float64(len(myself.paperList))
}

func (myself UserAcc) GetAcc() float64 {
	return myself.accuracy
}

/****************************************************************************************************************/

// UserAccuracy 白名单计算准确率 外露接口
var UserAccuracy map[int]UserAcc

// UpdateAll 更新准确率状态
func UpdateAll(paperID int) {
	for key, iData := range UserAccuracy {
		iData.UpdateAccStatus(paperID, key)
	}
}

// GetWhiteAll 计算准确率状态
func GetWhiteAll() {
	DB := GetDB()
	var userList []model.User

	// 获取作者列表
	DB.Find(&userList, "verify <> 0")

	for _, iUser := range userList {
		var artList []model.Article
		var iR float64 = 0
		var iMap map[int]bool
		iMap = make(map[int]bool)
		DB.Find(&artList, "author = ?", iUser.User_id)
		for _, iArt := range artList {
			var iPaper = model.Paper_list{}

			DB.Find(&iPaper, "paper_id=?", iArt.Paper_id)
			if math.Abs(iPaper.Score-float64(iArt.Rate)) <= 1.0 {
				iR++
				iMap[iUser.User_id] = true
			} else {
				iMap[iUser.User_id] = false
			}
		}
		var acc float64 = iR / float64(len(artList))
		var iUserAcc = UserAcc{}
		iUserAcc.SetAccStatus(iMap, acc)
		UserAccuracy[iUser.User_id] = iUserAcc
	}
}

// SortWhite 返回白名单，一个key的降序排序切片
func SortWhite() []int {
	// 对value排序
	var sortSlice = make(util.PairList, 0)
	for key, itx := range UserAccuracy {
		if key == 0 {
			continue
		}
		sortSlice = append(sortSlice, util.Pair{Key: key, Value1: itx.accuracy, Value2: len(itx.paperList)})
	}
	sort.Sort(sort.Reverse(sortSlice))

	// return一个slice
	var reSlice []int
	for _, iPair := range sortSlice {
		reSlice = append(reSlice, iPair.Key)
	}
	return reSlice
}

// GetUserAcc 获取该用户的准确度
func GetUserAcc(userID int) float64 {
	return UserAccuracy[userID].accuracy
}
