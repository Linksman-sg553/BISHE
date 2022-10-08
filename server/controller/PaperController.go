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
)

// GetPaperListByHot 按热度获取论文的文章列表
func GetPaperListByHot(ctx *gin.Context) {
	DB := common.GetDB()
	// 获取论文的ID 并验证
	paper_id := ctx.Query("paper_id")
	index, _ := strconv.Atoi(ctx.Query("index"))
	requestPaper, errorPaper := service.Verify_paper(paper_id, DB, ctx)
	if errorPaper == false {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "论文不存在")
		return
	}
	// 获取这个论文的文章列表
	var arcList []model.Article
	// 万能浏览量
	DB.Order("pageviews").Limit(10).Offset((index-1)*10).Find(&arcList, "paper_id=?", requestPaper.Paper_id)
	var total int
	DB.Model(&model.Article{}).Where("paper_id=?", requestPaper.Paper_id).Count(&total)
	var arclistDto []dto.ArclistDto
	// 转换传输对象
	for _, iList := range arcList {
		arclistDto = append(arclistDto, dto.ToArclistDto(iList))
	}
	// 返回
	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"arcList": arclistDto},
		"total": total,
	})
}

func GetPaperListByTime(ctx *gin.Context) {
	DB := common.GetDB()
	// 获取论文的ID 并验证
	paper_id := ctx.Query("paper_id")
	index, _ := strconv.Atoi(ctx.Query("index"))
	requestPaper, errorPaper := service.Verify_paper(paper_id, DB, ctx)
	if errorPaper == false {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "论文不存在")
		return
	}
	// 获取这个论文的文章列表
	var arcList []model.Article
	// 万能浏览量
	DB.Order("create_time desc").Limit(10).Offset((index-1)*10).Find(&arcList, "paper_id=?", requestPaper.Paper_id)
	var total int
	DB.Model(&model.Article{}).Where("paper_id=?", requestPaper.Paper_id).Count(&total)
	var arclistDto []dto.ArclistDto
	// 转换传输对象
	for _, iList := range arcList {
		arclistDto = append(arclistDto, dto.ToArclistDto(iList))
	}
	// 返回
	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"arcList": arclistDto},
		"total": total,
	})
}

func ReMakeScore(paperID int, userID int, Rate int) {
	DB := common.GetDB()
	var auth = model.User{}
	var paper = model.Paper_list{}

	DB.Where("user_id = ?", userID).First(&auth)
	DB.Where("paper_id=?", paperID).First(&paper)

	paper.Score = (paper.Score - float64(Rate*auth.Verify)) / float64(paper.Weights-auth.Verify)
	paper.Weights -= auth.Verify

	common.PaperBlackStatus(&paper)
	DB.Save(&paper)
}
