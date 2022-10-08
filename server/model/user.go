package model

// User 数据库模型
type User struct {
	User_id         int    `gorm:"int primary key Auto_Increment"`
	Nick_name       string `gorm:"VARCHAR(20) not null"`
	Password_login  string `gorm:"VARCHAR(20) not null"`
	True_name       string `gorm:"VARCHAR(30) not null"`
	Verify          int    `gorm:"int not null DEFAULT 0"`
	School          string `gorm:"VARCHAR(30)"`
	Major           string `gorm:"VARCHAR(30)"`
	Email           string `gorm:"VARCHAR(30) not null"`
	Phone           string `gorm:"VARCHAR(20) not null"`
	Integral        int    `gorm:"int"`
	Obtain_like     int    `gorm:"int default 0"`
	Article_num     int    `gorm:"int default 0"`
	Credit          int    `gorm:"int default 50"`
	Identity_number string `gorm:"VARCHAR(30)"`
	Exp             int    `gorm:"int"`
}
