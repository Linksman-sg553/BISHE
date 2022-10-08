package dto

import (
	"fmt"
	"server/common"
	"server/model"
	"time"
)

type Information_dto struct {
	Info_id      int       `json:"Info_id"`
	User_id      int       `json:"User_id"`
	Info_content string    `json:"Info_content"`
	Creat_time   time.Time `json:"Creat_time"`
	Checked      bool      `json:"Checked"`
	From_user    UserDto   `json:"From_user"`
}

func ToInformationDto(information model.Informations) Information_dto {
	DB := common.GetDB()
	var resUser = model.User{}

	if information.From_user > 1 {
		DB.Where("user_id = ?", information.From_user).First(&resUser)
		return Information_dto{
			Info_id:      information.Info_id,
			User_id:      information.User_id,
			Info_content: information.Info_content,
			Creat_time:   information.Creat_time,
			Checked:      information.Checked,
			From_user:    ToUserDto(resUser),
		}
	} else if information.From_user == 1 {
		userSys_dto := UserDto{
			User_id:  1,
			Name:     "系统通知",
			Email:    "",
			Verify:   6,
			School:   "",
			Major:    "",
			Phone:    "",
			Integral: 0,
			Truename: "",
		}
		return Information_dto{
			Info_id:      information.Info_id,
			User_id:      information.User_id,
			Info_content: information.Info_content,
			Creat_time:   information.Creat_time,
			Checked:      information.Checked,
			From_user:    userSys_dto,
		}
	} else {
		fmt.Println("user from wrong")
	}
	return Information_dto{
		User_id: 0,
	}
}
