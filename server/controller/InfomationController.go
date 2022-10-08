package controller

import (
	"fmt"
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

// GetInfoUncheck 获取信息总数
func GetInfoUncheck(ctx *gin.Context) {
	DB := common.GetDB()
	// 查询这个用户的合法状态
	requserUser, err1 := service.Verify_user(ctx.Query("user_id"), DB, ctx)
	if !err1 {
		fmt.Println("user unknown")
		return
	}
	// 获取信息未查询总数
	var infor_num int
	DB.Model(&model.Informations{}).Where("user_id = ? and checked = 0", requserUser.User_id).Count(&infor_num)
	// 返回这个切片
	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"info_num": infor_num},
	})
}

// GetReplyInfo 获取用户回复信息
func GetReplyInfo(ctx *gin.Context) {
	DB := common.GetDB()
	// 查询这个用户的合法状态
	var index int
	requserUser, err1 := service.Verify_user(ctx.Query("user_id"), DB, ctx)
	if !err1 {
		fmt.Println("user unknown")
		return
	}
	index, _ = strconv.Atoi(ctx.Query("index"))
	// 获取信息未查询总数
	var info_list []model.Informations
	var total int
	// 查询列表 带有分页 10 info in one page
	DB.Limit(10).Offset((index-1)*10).Order("checked").Find(&info_list, "user_id = ? and from_user <> 1", requserUser.User_id)
	// 查询总数
	DB.Model(&model.Informations{}).Where("user_id = ? and from_user <> 1", requserUser.User_id).Count(&total)
	// 返回这个切片
	var informationDTO []dto.Information_dto
	for _, info := range info_list {
		informationDTO = append(informationDTO, dto.ToInformationDto(info))
	}
	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"info_num": informationDTO},
		"total": total,
	})
}

// GetSysInfo 获取系统信息
func GetSysInfo(ctx *gin.Context) {
	DB := common.GetDB()
	var index int
	requserUser, err1 := service.Verify_user(ctx.Query("user_id"), DB, ctx)
	if !err1 {
		fmt.Println("user unknown")
		return
	}
	index, _ = strconv.Atoi(ctx.Query("index"))
	// 获取信息未查询总数
	var info_list []model.Informations
	var total int
	// 查询列表 带有分页 10 info in one page
	DB.Limit(10).Offset((index-1)*10).Order("checked").Find(&info_list, "user_id = ? and from_user = 1", requserUser.User_id)
	// 查询总数
	DB.Model(&model.Informations{}).Where("user_id = ? and from_user = 1", requserUser.User_id).Count(&total)
	// 返回这个切片
	var informationDTO []dto.Information_dto
	for _, info := range info_list {
		informationDTO = append(informationDTO, dto.ToInformationDto(info))
	}
	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"info_num": informationDTO},
		"total": total,
	})
}

// ChangeInfoStatus 更改信息已读状态
func ChangeInfoStatus(ctx *gin.Context) {
	DB := common.GetDB()
	// 获取请求信息号
	info_id := ctx.PostForm("info_id")
	fmt.Println("info_id " + info_id)
	// 获取信息对象
	var requestInfo = model.Informations{}
	DB.Where("info_id = ?", info_id).First(&requestInfo)
	if requestInfo.Info_id == 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "查询无此信息")
	}
	// 改变状态
	requestInfo.Checked = true
	// 保存
	DB.Model(&model.Informations{}).Where("info_id = ?", requestInfo.Info_id).Update("checked", true)
	// 出错报错
	// 没事200
	response.Success(ctx, gin.H{"ChangeStatus": "success"}, "成功")
}

// PostSysInfo 发送系统信息
func PostSysInfo(info string, toWhom int) {
	DB := common.GetDB()
	var information = model.Informations{
		Info_id:      0,
		User_id:      toWhom,
		Info_content: info,
		Creat_time:   time.Now(),
		Checked:      false,
		From_user:    1,
	}
	DB.Create(&information)
}

// PostReplyInfo 发送回复信息
func PostReplyInfo(comment model.Comment, fromWho int, toWhom int) {
	DB := common.GetDB()
	var information = model.Informations{
		Info_id:      0,
		User_id:      toWhom,
		Info_content: comment.Content,
		Creat_time:   time.Now(),
		Checked:      false,
		From_user:    fromWho,
	}
	DB.Create(&information)
}
