package service

import (
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"net/http"
	"server/model"
	"server/response"
)

// Verify_user 验证用户
func Verify_user(user_id string, DB *gorm.DB, ctx *gin.Context) (model.User, bool) {
	var user_verify = model.User{}
	DB.Where("user_id = ?", user_id).First(&user_verify)
	if user_verify.User_id == 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 400, nil, "用户不存在")
		return user_verify, false
	} else {
		return user_verify, true
	}
}

// Verify_article 验证文章
func Verify_article(text_id string, DB *gorm.DB, ctx *gin.Context) (model.Article, bool) {
	var arc_verify = model.Article{}
	DB.Where("text_id = ?", text_id).First(&arc_verify)
	if arc_verify.Text_id == 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 400, nil, "文章不存在")
		return arc_verify, false
	} else {
		return arc_verify, true
	}
}

// Verify_comment 验证评论
func Verify_comment(comment_id string, DB *gorm.DB, ctx *gin.Context) (model.Comment, bool) {
	var comment_verify = model.Comment{}
	DB.Where("comment_id = ?", comment_id).First(&comment_verify)
	if comment_verify.Comment_id == 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 400, nil, "评论不存在")
		return comment_verify, false
	} else {
		return comment_verify, true
	}
}

// Verify_paper 验证论文
func Verify_paper(paper_id string, DB *gorm.DB, ctx *gin.Context) (model.Paper_list, bool) {
	var paper_verify = model.Paper_list{}
	DB.Where("paper_id = ?", paper_id).First(&paper_verify)
	if paper_verify.Paper_id == 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 400, nil, "评论不存在")
		return paper_verify, false
	} else {
		return paper_verify, true
	}
}
