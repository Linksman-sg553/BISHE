package model

type Article_like struct {
	Like_id int `gorm:"int primary key Auto_Increment"`
	User_id int `gorm:"int"`
	Text_id int `gorm:"int"`
}
