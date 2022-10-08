package main

import (
	"github.com/gin-gonic/gin"
	"server/controller"
	"server/middleware"
)

func CollectRoute(r *gin.Engine) *gin.Engine {
	// 跨域请求中间件
	r.Use(middleware.CORSMiddleware(), middleware.RecoveryMiddleware())
	//用户api请求
	r.POST("/api/auth/login", controller.Login)
	r.GET("/api/auth/info", middleware.AuthMiddleware(), controller.Info)
	r.POST("/api/auth/verify", controller.Verify)
	r.GET("/api/auth/arclist", controller.Arclist)
	r.POST("api/auth/register", controller.Register)
	r.POST("api/auth/charge", controller.ChargeIntegral)
	r.GET("api/auth/userinfo", controller.GetUserInfo)
	//主页api请求
	r.GET("api/main/hotarticle", controller.GetHotArticle)
	r.GET("api/main/hotpaper", controller.GetHotPaper)
	r.GET("api/main/hotauthor", controller.GetHotAuthor)
	r.GET("api/main/search", controller.Search)
	//r.GET("api/main/blackout", controller.GetBlack_auth)
	r.GET("api/main/blackuser", controller.GetBlack_user)
	r.GET("api/main/blackpaper", controller.GetBlack_paper)
	r.GET("api/main/blackarticle", controller.GetBlack_article)
	r.GET("api/main/double", controller.GetDoubleList)
	r.GET("api/main/newList", controller.GetNewPostList)
	//分区api请求
	r.GET("api/area/getarticle", controller.GetArticle)
	r.GET("api/area/getpaper", controller.GetPaperList)
	//文章api请求
	r.GET("api/article/context", controller.Context)
	r.GET("api/article/comments", controller.GetComment)
	r.GET("api/article/samehot", controller.GetSameHot)
	r.POST("api/article/leavecomment", controller.PostComment)
	r.POST("api/article/likearticle", controller.PostArticleLike)
	r.POST("api/article/likecomment", controller.PostCommentLike)
	//发布api
	r.POST("api/paperpost/paperinfo", controller.PaperInfo)
	r.POST("api/paperpost/contextpost", controller.ContextPost)
	r.GET("api/paperpost/getpaper", controller.GetPaper)
	//消息系统api
	r.GET("api/info/infouncheck", controller.GetInfoUncheck)
	r.GET("api/info/reply", controller.GetReplyInfo)
	r.GET("api/info/sys", controller.GetSysInfo)
	r.POST("api/info/changestatus", controller.ChangeInfoStatus)
	// paper api
	r.GET("api/paper/getlisthot", controller.GetPaperListByHot)
	r.GET("api/paper/getlisttime", controller.GetPaperListByTime)
	return r
}
