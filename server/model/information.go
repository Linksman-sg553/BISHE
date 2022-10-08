package model

import "time"

type Informations struct {
	Info_id      int       `gorm:"INT PRIMARY KEY Auto_Increment"`
	User_id      int       `gorm:"INT"`
	Info_content string    `gorm:"longtext"`
	Creat_time   time.Time `gorm:"datetime"`
	Checked      bool      `gorm:"bool"`
	From_user    int       `gorm:"int"`
}
