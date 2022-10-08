package model

import "time"

type Paper_list struct {
	Paper_id     int       `gorm:"int primary key Auto_Increment"`
	Paper_title  string    `gorm:"VARCHAR(100)"`
	Foreign_url  string    `gorm:"VARCHAR(100)"`
	Paper_author string    `gorm:"VARCHAR(50)"`
	Summary      string    `gorm:"VARCHAR(1000)"`
	Score        float64   `gorm:"double"`
	Key_word     string    `gorm:"varchar(255)"`
	Categories   string    `gorm:"varchar(30)"`
	Part_sec     string    `gorm:"varchar(30)"`
	Part_main    string    `gorm:"varchar(30)"`
	Weights      int       `gorm:"int"`
	Create_time  time.Time `gorm:"datetime"`
}
