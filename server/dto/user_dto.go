package dto

import (
	"server/common"
	"server/model"
)

type UserDto struct {
	User_id  int     `json:"user_id"`
	Name     string  `json:"name"`
	Email    string  `json:"email"`
	Verify   int     `json:"verify"`
	School   string  `json:"school"`
	Major    string  `json:"major"`
	Phone    string  `json:"phone"`
	Integral int     `json:"integral"`
	Truename string  `json:"truename"`
	IsBlack  bool    `json:"isBlack"`
	Accuracy float64 `json:"accuracy"`
}

func ToUserDto(user model.User) UserDto {
	DB := common.GetDB()
	var check bool = false
	var buser = model.Black_user{}
	DB.Find(&buser, "black_user_id=?", user.User_id)
	if buser.Black_user_id != 0 {
		check = true
	} else {
		check = false
	}
	return UserDto{
		User_id:  user.User_id,
		Name:     user.Nick_name,
		Email:    user.Email,
		Verify:   user.Verify,
		School:   user.School,
		Major:    user.Major,
		Phone:    user.Phone,
		Integral: user.Integral,
		Truename: user.True_name,
		IsBlack:  check,
		Accuracy: common.UserAccuracy[user.User_id].GetAcc(),
	}
}
