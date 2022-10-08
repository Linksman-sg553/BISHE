package controller

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"server/common"
	"server/dto"
	"server/model"
	"server/response"
	"server/service"
	"strconv"
	"time"
)

// PaperInfo 论文的录入
func PaperInfo(ctx *gin.Context) {
	DB := common.GetDB()
	// 创建论文对象
	var paper = model.Paper_list{}
	// 获取论文的信息
	makePaper(&paper, ctx)
	// 插入数据库
	DB.Create(&paper)
	var Paper_ins = model.Paper_list{}
	DB.Where("paper_title=?", paper.Paper_title).First(&Paper_ins)
	if Paper_ins.Paper_id != 0 {
		response.Response(ctx, http.StatusOK, 200, nil, "论文插入成功")
	}
}

// ContextPost 正文信息接收
func ContextPost(ctx *gin.Context) {
	DB := common.GetDB()
	// 建立文章记录
	var article = model.Article{}
	makeArticle(&article, ctx)
	DB.Create(&article)

	// 更新论文的分数
	var requestPaper = model.Paper_list{}
	DB.Find(&requestPaper, "paper_id = ?", article.Paper_id)
	var PostAuthor = model.User{}
	DB.Where("user_id=?", article.Author).First(&PostAuthor)
	requestPaper.Score = (requestPaper.Score + float64(article.Rate*PostAuthor.Verify)) / float64(requestPaper.Weights+PostAuthor.Verify)
	DB.Model(&model.Paper_list{}).Where("paper_id=?", requestPaper.Paper_id).Update("score", requestPaper.Score)
	requestPaper.Weights += PostAuthor.Verify
	DB.Model(&model.Paper_list{}).Where("paper_id=?", requestPaper.Paper_id).Update("weights", requestPaper.Weights)

	// 对用户加分
	AwardedMarks(article.Author, 100, 100, 100)

	var afterArticle = model.Article{}
	DB.Where("title=? and author=? and paper_id=?", article.Title, article.Author, article.Paper_id).First(&afterArticle)
	// 查询该论文是否在二审状态
	if _, ok := common.DoubleList[requestPaper.Paper_id]; ok {
		ok := common.PostDouble(afterArticle, DB)
		if ok == 1 {
			handleGuilt(afterArticle)
		} else if ok == 2 {
			handleInnocent(afterArticle)
		}
	}

	// 检查论文的黑名单状态
	if common.PaperBlackStatus(&requestPaper) {
		response.Response(ctx, http.StatusOK, 200, nil, "文章插入成功 论文评分低，已加入黑名单")
		return
	}
	response.Response(ctx, http.StatusOK, 200, nil, "文章插入成功")
}

// makePaper 建立论文模型
func makePaper(paper *model.Paper_list, ctx *gin.Context) {
	paper.Paper_id = 0
	paper.Paper_author = ctx.PostForm("paper_author")
	paper.Paper_title = ctx.PostForm("paper_title")
	paper.Foreign_url = ctx.PostForm("paper_url")
	paper.Summary = ctx.PostForm("paper_summary")
	paper.Key_word = ctx.PostForm("paper_keywords")
	paper.Categories = ctx.PostForm("paper_cateID")
	paper.Part_main = ctx.PostForm("paper_partmain")
	paper.Part_sec = ctx.PostForm("paper_partsec")
}

// makeArticle 建立文章模型
func makeArticle(arc *model.Article, ctx *gin.Context) {
	arc.Text_id = 0
	arc.Title = ctx.PostForm("arc_title")
	arc.Main_text = ctx.PostForm("arc_content")
	arc.Create_time = time.Now()
	arc.Author, _ = strconv.Atoi(ctx.PostForm("arc_author"))
	arc.Tag_collection = ctx.PostForm("arc_tag")
	arc.Anti_collection = ctx.PostForm("arc_anti")
	arc.Rate, _ = strconv.Atoi(ctx.PostForm("arc_rate"))
	arc.Likes = 0
	arc.Paper_id, _ = strconv.Atoi(ctx.PostForm("arc_paper"))
	arc.Part_of_sec = ctx.PostForm("arc_partsec")
	arc.Part_of_main = ctx.PostForm("arc_partmain")
	arc.Summary = ctx.PostForm("arc_summary")
	arc.Article_status = 1
}

// GetPaper 获取同名论文信息返回给前端
// 弃用
func GetPaper(ctx *gin.Context) {
	// 获取数据句柄
	DB := common.GetDB()
	// 获取FormData中Paper_ID
	paper_id := ctx.Query("paper_id")
	requestPaper, errPaper := service.Verify_paper(paper_id, DB, ctx)
	if errPaper == false {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "没有改论文")
		return
	}
	// 返回论文的Model
	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"paper": dto.ToPaperDto(requestPaper)},
	})
}

// handleGuilt 处理有罪
func handleGuilt(article model.Article) {
	DB := common.GetDB()

	// 扣除改作者改文章信用分积分
	Deduction(article.Author, 100, 100)
	PostSysInfo("您的文章"+article.Title+"二审结果为 所述不实", article.Author)

	// 消除此文章对论文的评分影响
	ReMakeScore(article.Paper_id, article.Author, article.Rate)

	// 惩罚奖励来访者
	var commentList []model.Comment
	DB.Find(&commentList, "publish_article=?", article.Text_id)
	for _, iComment := range commentList {
		// 对好评来访者惩罚信用分-10
		if iComment.Rate >= 6 {
			Deduction(iComment.Publish_user, 10, 10)
		} else {
			// 对差评来访者+10 +10
			AwardedMarks(iComment.Publish_user, 10, 10, 0)
		}

	}

}

// handleInnocent 处理无罪
func handleInnocent(article model.Article) {
	DB := common.GetDB()

	PostSysInfo("您的文章 "+article.Title+" 二审结果为 符合事实", article.Author)

	// 对差评来访者-10
	var commentList []model.Comment
	DB.Find(&commentList, "publish_article=?", article.Text_id)
	for _, iComment := range commentList {
		// 对好评来访者惩罚信用分-10
		if iComment.Rate < 6 {
			Deduction(iComment.Publish_user, 10, 0)
		}
	}
}
