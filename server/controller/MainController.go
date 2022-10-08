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

func Search(ctx *gin.Context) {
	DB := common.GetDB()
	queryKey := ctx.Query("keys")

	var arcList []model.Article
	var arcDtoList []dto.ArclistDto
	fmt.Println(queryKey)
	DB.Raw("select * from articles where title like '%" + queryKey + "%'").Scan(&arcList)

	for _, itx := range arcList {
		arcDtoList = append(arcDtoList, dto.ToArclistDto(itx))
	}
	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"arcDtoList": arcDtoList},
	})
}

// GetHot 主页获取热门列表
func GetHotArticle(ctx *gin.Context) {
	DB := common.GetDB()
	var arcHotList []model.Article
	//根据降序获取前6点赞文章
	DB.Limit(6).Order("likes desc").Find(&arcHotList)
	// 返回文章列表
	var arclistDto []dto.ArclistDto
	for _, arc := range arcHotList {
		arclistDto = append(arclistDto, dto.ToArclistDto(arc))
	}

	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"arclistDto": arclistDto},
	})
}

// GetHotPaper 主页获取热门列表
func GetHotPaper(ctx *gin.Context) {
	DB := common.GetDB()
	var paperHotList []model.Paper_list
	//根据降序获取前6点赞文章
	DB.Limit(6).Find(&paperHotList)
	// 返回文章列表
	var paperDto []dto.Paper_DTO
	for _, iPaper := range paperHotList {
		paperDto = append(paperDto, dto.ToPaperDto(iPaper))
	}
	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"paperDto": paperDto},
	})
}

// GetHotAuthor 主页拉取热门作者
// todo: 算法变了，改白名单
func GetHotAuthor(ctx *gin.Context) {
	// 获取数据库连接
	DB := common.GetDB()
	// 拉取热门前6
	var hotUserList []model.User
	var hotUserDtoList []dto.UserDto
	var hotSlice []int
	hotSlice = common.SortWhite()

	itx := 0
	for _, iV := range hotSlice {
		if itx == 6 {
			break
		}
		var iUser = model.User{}
		DB.Where("user_id = ?", iV).First(&iUser)
		if iUser.Verify == 0 {
			continue
		}
		hotUserList = append(hotUserList, iUser)
		itx++
	}

	// 判断下查询结果有无错误
	if len(hotUserList) < 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "查询出错")
		return
	}
	// 转换DTO
	for _, iUser := range hotUserList {
		if iUser.Verify != 0 {
			hotUserDtoList = append(hotUserDtoList, dto.ToUserDto(iUser))
		}
	}
	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"hotUserList": hotUserDtoList},
	})
}

// GetBlack_auth 主页获取黑名单作者列表
func GetBlack_auth(ctx *gin.Context) {
	// 获取数据库连接
	DB := common.GetDB()
	// 拉取黑名单表前十名
	var blackauthList []model.Black_auth
	DB.Limit(10).Find(&blackauthList)
	// 判断下查询结果有无错误
	if len(blackauthList) < 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "查询出错")
		return
	}
	// 序列化
	// 发送
	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"blackauthList": blackauthList},
	})
}

// GetBlack_user 主页获取黑名单用户列表
func GetBlack_user(ctx *gin.Context) {
	// 获取数据库连接
	DB := common.GetDB()
	currentIndex, _ := strconv.Atoi(ctx.Query("index"))
	var total int

	// 拉取黑名单表前十名
	var blackuserList []model.Black_user
	DB.Limit(6).Offset((currentIndex - 1) * 6).Find(&blackuserList)
	DB.Model(&model.Black_user{}).Count(&total)
	// 判断下查询结果有无错误
	if len(blackuserList) < 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "查询出错")
		return
	}
	// 转换模型
	var userDtolist []dto.UserDto
	for _, iBuser := range blackuserList {
		var iUser = model.User{}
		DB.Where("user_id = ?", iBuser.Black_user_id).First(&iUser)
		userDtolist = append(userDtolist, dto.ToUserDto(iUser))
	}
	// 发送
	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"blackUserList": userDtolist},
		"total": total,
	})
}

// GetBlack_article 主页获取黑名单文章列表
func GetBlack_article(ctx *gin.Context) {
	// 获取数据库连接
	DB := common.GetDB()
	currentIndex, _ := strconv.Atoi(ctx.Query("index"))
	var total int

	// 拉取黑名单表前十名
	var BlackArticleList []model.Black_article
	DB.Limit(6).Offset((currentIndex - 1) * 6).Find(&BlackArticleList)
	DB.Model(&model.Black_article{}).Count(&total)
	// 判断下查询结果有无错误
	if len(BlackArticleList) < 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "查询出错")
		return
	}

	// 转换模型
	var arcDtolist []dto.Article_Dto
	for _, iBArc := range BlackArticleList {
		var iArc = model.Article{}
		DB.Where("text_id = ?", iBArc.Black_article_id).First(&iArc)
		arcDtolist = append(arcDtolist, dto.ToArticleDto(iArc, iArc.Author))
	}

	// 发送
	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"blackArticleList": arcDtolist},
		"total": total,
	})
}

// GetBlack_paper 主页获取黑名单论文列表
func GetBlack_paper(ctx *gin.Context) {
	// 获取数据库连接
	DB := common.GetDB()
	currentIndex, _ := strconv.Atoi(ctx.Query("index"))
	var total int

	// 拉取黑名单
	var Black_paper_List []model.Black_paper
	DB.Limit(6).Offset((currentIndex - 1) * 6).Find(&Black_paper_List)
	DB.Model(&model.Black_paper{}).Count(&total)
	// 判断下查询结果有无错误
	if len(Black_paper_List) < 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "查询出错")
		return
	}

	// 转换模型
	var paperDtolist []dto.Paper_DTO
	for _, iBPaper := range Black_paper_List {
		var iPaper = model.Paper_list{}
		DB.Where("paper_id = ?", iBPaper.Black_paper_id).First(&iPaper)
		paperDtolist = append(paperDtolist, dto.ToPaperDto(iPaper))
	}

	// 发送
	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"blackPaperList": paperDtolist},
		"total": total,
	})
}

// GetDoubleList 获取主页二次评审
func GetDoubleList(ctx *gin.Context) {
	currentIndex, _ := strconv.Atoi(ctx.Query("index"))
	var total int
	var storeSlice []int
	var dtoList []dto.Paper_DTO
	DB := common.GetDB()

	for k, _ := range common.DoubleList {
		storeSlice = append(storeSlice, k)
	}
	total = len(storeSlice)
	for itx := (currentIndex - 1) * 6; itx < currentIndex*6; itx++ {
		// 防越界
		if itx == total {
			break
		} else if itx > total {
			response.Fail(ctx, "请求越界", nil)
			return
		}
		var dtoPaper model.Paper_list
		DB.Where("paper_id=?", storeSlice[itx]).First(&dtoPaper)
		dtoList = append(dtoList, dto.ToPaperDto(dtoPaper))
	}

	ctx.JSON(http.StatusOK, gin.H{"dtoList": dtoList, "total": total})
}

// GetNewPostList 获取最新申请
func GetNewPostList(ctx *gin.Context) {
	currentIndex, _ := strconv.Atoi(ctx.Query("index"))
	var total int = 12
	var dtoList []dto.Paper_DTO
	var paperList []model.Paper_list
	DB := common.GetDB()

	// 获取六条
	DB.Limit(6).Offset((currentIndex - 1) * 6).Find(&paperList).Order("create_time desc")
	for _, iValue := range paperList {
		dtoList = append(dtoList, dto.ToPaperDto(iValue))
	}

	ctx.JSON(http.StatusOK, gin.H{"dtoList": dtoList, "total": total})
}
