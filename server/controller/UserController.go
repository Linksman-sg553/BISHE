package controller

import (
	"fmt"
	"log"
	"net/http"
	"server/common"
	"server/dto"
	"server/model"
	"server/response"
	"server/service"
	"server/util"
	"strconv"

	"github.com/gin-gonic/gin"
)

// Login 登录
func Login(ctx *gin.Context) {
	DB := common.GetDB()
	//获取数据
	//使用map获取请求参数
	var requestUser = model.User{}
	fmt.Println(ctx)
	email := ctx.PostForm("login_email")
	password := ctx.PostForm("login_password")
	requestUser.Email = email
	requestUser.Password_login = password
	fmt.Println("email context:" + email)
	fmt.Println("email context:" + password)
	//数据验证
	fmt.Println(email, "手机号码长度", len(email))

	if len(password) < 6 {
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "密码不能少于6位")
		return
	}

	//判断号是否存在
	var user model.User
	DB.Where("email = ?", email).First(&user)
	if user.User_id == 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 400, nil, "用户不存在")
		return
	}

	//判断密码是否正确
	if password != user.Password_login {
		response.Response(ctx, http.StatusBadRequest, 400, nil, "密码错误")
		return
	}
	//发放token
	token, err := common.ReleaseToken(user)
	if err != nil {
		response.Response(ctx, http.StatusUnprocessableEntity, 500, nil, "系统异常")
		log.Printf("token generate error: %v", err)
		return
	}

	//返回结果
	response.Success(ctx, gin.H{"token": token}, "登录成功")
}

// Register 注册用户
func Register(ctx *gin.Context) {
	DB := common.GetDB()
	//使用map获取请求参数

	//获取参数
	name := ctx.PostForm("nick_name")
	truename := ctx.PostForm("true_name")
	password := ctx.PostForm("password_login")
	telephone := ctx.PostForm("phone")
	email := ctx.PostForm("email")
	idCard := ctx.PostForm("identity_number")
	//数据验证
	fmt.Println(telephone, "手机号码长度", len(telephone))
	if len(telephone) != 11 {
		fmt.Println("电话号不合格")
		fmt.Println(telephone)
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "手机号必须为11位")
		return
	}
	fmt.Println(telephone)
	if len(password) < 6 {
		fmt.Println("密码不合格")
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "密码不能少于6位")
		return
	}
	fmt.Println(password)
	if len(name) == 0 {
		fmt.Println("名称不合格")
		fmt.Println(name)
		name = util.RandString(10)
	}
	fmt.Println(name)
	// 判断用户名存在判断
	if isNicknameExists(name) {
		fmt.Println("用户名存在")
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "用户名已经存在")
		return
	}
	// 判断手机号码是否存在
	if isTelephoneExists(telephone) {
		fmt.Println("手机号码存在")
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "手机号码已经存在")
		return
	}
	// 判断邮箱是否存在
	if isEmailExists(email) {
		fmt.Println("邮箱存在")
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "邮箱已经存在")
		return
	}
	// 判断身份证是否存在
	if isIDCardExists(idCard) {
		fmt.Println("身份证存在")
		response.Response(ctx, http.StatusUnprocessableEntity, 422, nil, "身份证已经存在")
		return
	}

	// 创建用户

	newUser := model.User{
		Nick_name:       name,
		True_name:       truename,
		Phone:           telephone,
		Email:           email,
		Identity_number: idCard,
		Integral:        50,
		School:          "",
		Major:           "",
		Verify:          0,
		Password_login:  password,
		Exp:             0,
		Credit:          100,
	}
	DB.Create(&newUser)
	//返回结果
	response.Success(ctx, gin.H{"Register_State": "success"}, "注册成功")
}

// Info 返回用户信息
func Info(ctx *gin.Context) {
	user, _ := ctx.Get("user")
	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"user": dto.ToUserDto(user.(model.User))},
	})
}

// Verify 用户的评论身份验证申请
func Verify(ctx *gin.Context) {
	//获取数据库句柄
	DB := common.GetDB()
	fmt.Println(ctx)
	//根据ctx获取用户信息
	user_id, err := strconv.Atoi(ctx.PostForm("user_id"))
	user_ID := ctx.PostForm("user_id")
	if err != nil {
		fmt.Println(user_ID)
		fmt.Println("用户id类型转换错误")
	}
	fmt.Println(user_id)
	fmt.Println("user_id| verify: %d", user_id)
	//认证改用户是否存在
	var user model.User
	DB.Where("user_id = ?", user_id).First(&user)
	if user.User_id == 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 400, nil, "用户不存在")
		return
	}
	//根据ctx获取用户提交的验证信息
	idCard := ctx.PostForm("idCard")
	college := ctx.PostForm("college")
	school := ctx.PostForm("school")
	sNumber := ctx.PostForm("s_number")
	major := ctx.PostForm("major")
	fmt.Println(idCard, college, school, sNumber, major)
	//验证验证信息的有效性
	if idCard != user.Identity_number {
		response.Response(ctx, http.StatusUnprocessableEntity, 400, nil, "验证信息不正确")
		return
	}
	//将认证信息写入用户表，设置verify字段为1
	user.School = college
	user.Major = major
	user.Verify = 1
	DB.Save(&user)
	//成功
	response.Success(ctx, gin.H{"check": "ok"}, "登录成功")
}

// Arclist 用户文章拉取
func Arclist(ctx *gin.Context) {
	// 获取数据库句柄
	DB := common.GetDB()
	fmt.Println(ctx)
	// 获取用户编号参数
	user_id := ctx.Query("user_id")
	index, _ := strconv.Atoi(ctx.Query("index"))
	//验证用户有效性
	var user model.User
	fmt.Println(user_id)
	DB.Where("user_id = ?", user_id).First(&user)
	if user.User_id == 0 {
		response.Response(ctx, http.StatusUnprocessableEntity, 400, nil, "用户不存在")
		return
	}
	// 从数据库文章表拉取文章信息
	var arclist []model.Article
	var total int
	DB.Limit(10).Offset((index-1)*10).Find(&arclist, "author = "+
		"?", user_id)
	DB.Model(&model.Article{}).Where("author = "+
		"?", user_id).Count(&total)
	// 返回文章表
	if len(arclist) == 0 {
		response.Success(ctx, gin.H{"arclen": 0}, " 拉取成功")
		return
	}
	var arclistDto []dto.ArclistDto
	for _, arc := range arclist {
		arclistDto = append(arclistDto, dto.ToArclistDto(arc))
	}
	ctx.JSON(http.StatusOK, gin.H{
		"code":  200,
		"data":  gin.H{"arclistDto": arclistDto},
		"total": total,
	})
}

// ChargeIntegral 充值积分
func ChargeIntegral(ctx *gin.Context) {
	DB := common.GetDB()

	userID := ctx.PostForm("user_id")
	chargeNum, _ := strconv.Atoi(ctx.PostForm("charge_num"))

	requestUser, errUser := service.Verify_user(userID, DB, ctx)
	if !errUser {
		return
	}
	requestUser.Integral += chargeNum
	DB.Model(&model.User{}).Where("user_id=?", userID).Update("integral", requestUser.Integral)
}

func GetUserInfo(ctx *gin.Context) {
	DB := common.GetDB()
	u_id := ctx.Query("user_id")

	var iUser = model.User{}
	DB.Where("user_id=?", u_id).First(&iUser)

	ctx.JSON(http.StatusOK, gin.H{
		"code": 200,
		"data": gin.H{"user": dto.ToUserDto(iUser)},
	})
}

// addUserLikes 增加用户点赞数
func addUserLikes(userID int, ctx *gin.Context) {
	DB := common.GetDB()
	var author = model.User{}
	DB.Where("user_id = ?", userID).First(&author)
	if author.User_id == 0 {
		fmt.Println("作者查找出错")
		return
	}
	author.Obtain_like++
	DB.Model(&model.User{}).Where("user_id = ?", author.User_id).Update("obtain_like", author.Obtain_like)
	response.Response(ctx, http.StatusOK, 200, nil, "点赞完成")
}

// Deduction 对用户扣分
func Deduction(userID int, credit int, integral int) {
	DB := common.GetDB()

	var auth = model.User{}
	DB.Find(&auth, "user_id=?", userID)
	auth.Credit -= credit
	auth.Integral -= integral
	// toDO 这俩放user控制器
	DB.Model(&model.User{}).Where("user_id=?", auth.User_id).Update("credit", auth.Credit-credit)
	DB.Model(&model.User{}).Where("user_id=?", auth.User_id).Update("integral", auth.Integral-integral)

	// 评估用户信用状态，是否会进入黑名单
	if common.UserBlackStatus(&auth) {
		PostSysInfo("您由于信用不佳，已进入黑名单", auth.User_id)
	} else {
		PostSysInfo("您由于信用改善，已从黑名单移除", auth.User_id)
	}
}

// AwardedMarks 对用户加分
func AwardedMarks(userID int, credit int, integral int, exp int) {
	DB := common.GetDB()

	var auth = model.User{}
	DB.Find(&auth, "user_id=?", userID)
	auth.Credit += credit
	auth.Integral += integral
	auth.Exp += exp
	// toDO 这俩放user控制器
	DB.Model(&model.User{}).Where("user_id=?", auth.User_id).Update("credit", auth.Credit)
	DB.Model(&model.User{}).Where("user_id=?", auth.User_id).Update("integral", auth.Integral)
	DB.Model(&model.User{}).Where("user_id=?", auth.User_id).Update("exp", auth.Exp)

	// 评估用户信用状态，是否会进入黑名单
	common.UserBlackStatus(&auth)
}

func isNicknameExists(nickname string) bool {
	DB := common.GetDB()
	var user model.User
	DB.Where("nick_name = ?", nickname).First(&user)
	if user.User_id != 0 {
		return true
	}
	return false
}

func isTelephoneExists(telephone string) bool {
	DB := common.GetDB()
	var user model.User
	DB.Where("phone = ?", telephone).First(&user)
	if user.User_id != 0 {
		return true
	}
	return false
}

func isEmailExists(email string) bool {
	DB := common.GetDB()
	var user model.User
	DB.Where("email = ?", email).First(&user)
	if user.User_id != 0 {
		return true
	}
	return false
}

func isIDCardExists(idcard string) bool {
	DB := common.GetDB()
	var user model.User
	DB.Where("identity_number = ?", idcard).First(&user)
	if user.User_id != 0 {
		return true
	}
	return false
}
