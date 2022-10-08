package middleware

import (
	"fmt"
	"net/http"
	"server/common"
	"server/model"
	"strings"

	"github.com/gin-gonic/gin"
)

func AuthMiddleware() gin.HandlerFunc {
	return func(ctx *gin.Context) {
		// 获取 authorization header
		tokenString := ctx.GetHeader("Authorization")

		fmt.Print("请求token", tokenString)

		//validate token formate
		if tokenString == "" || !strings.HasPrefix(tokenString, "Bearer ") {
			ctx.JSON(http.StatusUnauthorized, gin.H{
				"code": 401,
				"msg":  "权限不足",
			})
			ctx.Abort()
			return
		}

		tokenString = tokenString[7:] //截取字符

		token, claims, err := common.ParseToken(tokenString)

		if err != nil || !token.Valid {
			ctx.JSON(http.StatusUnauthorized, gin.H{
				"code": 401,
				"msg":  "权限不足",
			})
			ctx.Abort()
			return
		}

		//token通过验证, 获取claims中的UserID
		userId := claims.UserId
		fmt.Println("adadad")
		fmt.Println(userId)
		DB := common.GetDB()
		var user model.User
		DB.Where("user_id = ?", userId).First(&user)
		fmt.Println(user.User_id)
		fmt.Println(user.Password_login)
		// 验证用户是否存
		//在
		if user.User_id == 0 {
			ctx.JSON(http.StatusUnauthorized, gin.H{
				"code": 401,
				"msg":  "权限不足",
			})
			ctx.Abort()
			return
		}

		//用户存在 将user信息写入上下文
		ctx.Set("user", user)

		ctx.Next()
	}
}
