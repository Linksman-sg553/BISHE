package controller

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
	"server/common"
	"server/dto"
	"server/model"
	"server/response"
	"strconv"
)

// getByTime 获取分区列表 时间排列
func GetArticle(ctx *gin.Context) {
	DB := common.GetDB()
	// 获取当前主分区分类号
	partMain := ctx.Query("part_of_main")
	// 获取当前子分区分类号 可能是0 指代全部
	partSec := ctx.Query("part_of_sec")
	index, _ := strconv.Atoi(ctx.Query("index"))
	fmt.Println(partMain, partSec)
	// 获取当前分区的文章列表
	// 计数文章总数
	var total int
	var arclist []model.Article
	if partSec == "0" {
		DB.Limit(10).Offset((index-1)*10).Find(&arclist, "part_of_main = ?", partMain)
		DB.Model(&model.Article{}).Where("part_of_main = ?", partMain).Count(&total)
	} else {
		DB.Limit(10).Offset((index-1)*10).Find(&arclist, "part_of_sec = ?", partSec)
		DB.Model(&model.Article{}).Where("part_of_sec = ?", partSec).Count(&total)
	}
	if len(arclist) == 0 {
		response.Success(ctx, gin.H{"arclen": 0}, " 拉取成功")
		return
	}
	// 返回文章列表
	var arclistDto []dto.ArclistDto
	for _, arc := range arclist {
		arclistDto = append(arclistDto, dto.ToArclistDto(arc))
	}
	//序列化这个文章列表
	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"arclistDto": arclistDto},
		"total": total,
	})
}

// GetPaperList 获取分区列表 时间排列
func GetPaperList(ctx *gin.Context) {
	DB := common.GetDB()
	// 获取当前主分区分类号
	partMain := ctx.Query("part_of_main")
	// 获取当前子分区分类号 可能是0 指代全部
	partSec := ctx.Query("part_of_sec")
	index_id, _ := strconv.Atoi(ctx.Query("index"))
	fmt.Println(partMain, partSec)
	// 获取当前分区的文章列表
	var papers []model.Paper_list
	// 计数文章总数
	var total int
	// 计数
	if partSec == "0" {
		DB.Limit(10).Offset((index_id-1)*10).Find(&papers, "part_main = ?", partMain)
		DB.Model(&model.Paper_list{}).Where("part_main = ?", partMain).Count(&total)
		// 计数
	} else {
		DB.Limit(10).Offset((index_id-1)*10).Find(&papers, "part_sec = ?", partSec)
		DB.Model(&model.Paper_list{}).Where("part_sec = ?", partSec).Count(&total)
		// 计数
	}
	if len(papers) == 0 {
		response.Success(ctx, gin.H{"paperLen": 0}, " 拉取为空")
		return
	}
	// 返回文章列表
	var paperDtos []dto.Paper_DTO
	for _, iPaper := range papers {
		paperDtos = append(paperDtos, dto.ToPaperDto(iPaper))
	}

	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"paperDtos": paperDtos},
		"total": total,
	})
}
