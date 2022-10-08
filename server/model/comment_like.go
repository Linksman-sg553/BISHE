package model

type Comment_like struct {
	Like_id    int `gorm:"int primary key Auto_Increment"`
	User_id    int `gorm:"int"`
	Comment_id int `gorm:"int"`
}
