package controller

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"net/http"
	"server/common"
	"server/dto"
	"server/model"
	"server/response"
	"server/service"
	"strconv"
	"time"
)

// Context get正文
func Context(ctx *gin.Context) {
	// 获取文章id
	DB := common.GetDB()
	arcId := ctx.Query("id")
	userId, _ := strconv.Atoi(ctx.Query("user_id"))

	// 查询文章的标题、简介、时间、作者、点赞数、正文
	requestArticle, errArc := service.Verify_article(arcId, DB, ctx)
	if !errArc {
		fmt.Println("查询不到文章")
		return
	}

	arcDto := dto.ToArticleDto(requestArticle, userId)
	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"article_dto": arcDto},
	})

	// 浏览量++
	views := requestArticle.Pageviews + 1
	DB.Model(&model.Article{}).Where("text_id = ?", requestArticle.Text_id).Update("pageviews", views)
}

// GetComment get评论列表
func GetComment(ctx *gin.Context) {
	DB := common.GetDB()
	arcId := ctx.Query("text_id")
	indexId := ctx.Query("index")
	userID, _ := strconv.Atoi(ctx.Query("user_id"))
	index, _ := strconv.Atoi(indexId)

	// 验证文章有效性
	requestArticle, errArc := service.Verify_article(arcId, DB, ctx)
	if !errArc {
		return
	}

	var commentList []model.Comment
	DB.Limit(10).Offset((index-1)*10).Find(&commentList, "publish_article = ?", requestArticle.Text_id)
	var total int
	DB.Model(&model.Comment{}).Where("publish_article = ?", arcId).Count(&total)

	var commentListDto []dto.CommentDto
	for _, comment := range commentList {
		commentListDto = append(commentListDto, dto.ToCommentDto(comment, userID))
	}

	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"commentList": commentListDto},
		"total": total,
	})
}

// PostComment 发表评论
func PostComment(ctx *gin.Context) {
	DB := common.GetDB()

	// 验证
	userId := ctx.PostForm("publish_user")
	articleId := ctx.PostForm("publish_article")
	userVerify, err1 := service.Verify_user(userId, DB, ctx)
	if err1 == false {
		return
	}
	arcVerify, err2 := service.Verify_article(articleId, DB, ctx)
	if err2 == false {
		return
	}

	// 创建评论
	Comment := makeComment(ctx, userVerify.User_id, arcVerify.Text_id, DB)

	// 更新文章评分
	var count_article int
	DB.Model(&model.Article{}).Where("text_id = ?", Comment.Publish_article).Count(&count_article)
	arcVerify.Score = (arcVerify.Score + float64(Comment.Rate)) / float64(count_article)
	DB.Model(&model.Article{}).Where("text_id = ?", Comment.Publish_article).Update("score", arcVerify.Score)

	PostReplyInfo(Comment, Comment.Publish_user, arcVerify.Author)

	// 二审验证
	check := common.CheckDoubleStatus(arcVerify, DB)
	if check {
		fmt.Println("该文章需要二次审查 TEXT_ID = " + strconv.Itoa(arcVerify.Text_id))
		response.Response(ctx, http.StatusOK, 200, nil, "触发二次评审")
		PostSysInfo("你的文章 "+arcVerify.Title+" 因争议已进入二次评审", arcVerify.Author)
	}

	AwardedMarks(Comment.Publish_user, 10, 10, 0)
}

func GetSameHot(ctx *gin.Context) {
	DB := common.GetDB()

	article_id := ctx.Query("id")
	var art_mod model.Article
	var art_list []model.Article

	DB.Where("text_id=?", article_id).First(&art_mod)
	DB.Limit(4).Find(&art_list, "part_of_main=?", art_mod.Part_of_main).Order("pageviews, desc")

	var art_dto []dto.ArclistDto
	for _, iArt := range art_list {
		art_dto = append(art_dto, dto.ToArclistDto(iArt))
	}

	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"ArclistDto": art_dto},
	})
}

// PostArticleLike 处理点赞请求
func PostArticleLike(ctx *gin.Context) {
	DB := common.GetDB()

	// 验证请求有效性
	userId := ctx.PostForm("user_id")
	textId := ctx.PostForm("text_id")
	userVerify, errUser := service.Verify_user(userId, DB, ctx)
	if !errUser {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "none user")
		return
	}
	arcVerify, errArc := service.Verify_article(textId, DB, ctx)
	if !errArc {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "none arc")
		return
	}

	// 验证点赞记录
	var LikeVer = model.Article_like{}
	DB.Where("user_id=? and text_id=?").First(&LikeVer)
	if LikeVer.Like_id != 0 {
		response.Response(ctx, http.StatusConflict, 409, nil, "already here")
		return
	}

	// 验证通过 新增这条记录
	var articleLikeRec = model.Article_like{
		User_id: userVerify.User_id, Text_id: arcVerify.Text_id,
	}
	DB.Create(&articleLikeRec)
	// 对相应文章进行 like++
	arcVerify.Likes++
	DB.Model(&model.Article{}).Where("text_id = ?", arcVerify.Text_id).Update("likes", arcVerify.Likes)

	// 增加用户的点赞量
	addUserLikes(arcVerify.Author, ctx)
}

// PostCommentLike 处理点赞请求
func PostCommentLike(ctx *gin.Context) {
	DB := common.GetDB()
	// 验证请求有效性
	userId := ctx.PostForm("user_id")
	commentId := ctx.PostForm("comment_id")
	userVerify, errUser := service.Verify_user(userId, DB, ctx)
	if !errUser {
		return
	}
	commentVerify, errArc := service.Verify_comment(commentId, DB, ctx)
	if !errArc {
		return
	}
	// 验证通过 新增这条记录
	var commentLikeRec = model.Comment_like{
		User_id: userVerify.User_id, Comment_id: commentVerify.Comment_id,
	}
	DB.Create(&commentLikeRec)
	// 对相应文章进行 like++
	commentVerify.Likes++
	DB.Model(&model.Comment{}).Where("comment_id=?", commentVerify.Comment_id).Update("likes", commentVerify.Likes)
	response.Response(ctx, http.StatusOK, 200, nil, "点赞完成")
}

// makeComment 创建评论
func makeComment(ctx *gin.Context, userID int, textID int, DB *gorm.DB) model.Comment {
	content := ctx.PostForm("content")
	timeNow := time.Now()
	var rate_comment int
	rate_comment, _ = strconv.Atoi(ctx.PostForm("rate"))
	// 创建评论对象并存储数据库
	var Comment = model.Comment{
		Comment_id:      0,
		Content:         content,
		Publish_user:    userID,
		Publish_article: textID,
		Likes:           0,
		Create_time:     timeNow,
		Rate:            rate_comment,
	}
	DB.Create(Comment)
	return Comment
}
