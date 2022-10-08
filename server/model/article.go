package model

import "time"

type Article struct {
	Text_id         int       `gorm:"int primary key Auto_Increment"`
	Title           string    `gorm:"VARCHAR(100)"`
	Main_text       string    `gorm:"longtext"`
	Create_time     time.Time `gorm:"date"`
	Author          int       `gorm:"int"`
	Part_of_main    string    `gorm:"VARCHAR(30)"`
	Part_of_sec     string    `gorm:"VARCHAR(30)"`
	Tag_collection  string    `gorm:"VARCHAR(100)"`
	Anti_collection string    `gorm:"VARCHAR(100)"`
	Rate            int       `gorm:"int"`
	Likes           int       `gorm:"int"`
	Paper_id        int       `gorm:"int"`
	Article_status  int       `gorm:"int"`
	Summary         string    `gorm:"longtext"`
	Pageviews       int       `gorm:"int"`
	Score           float64   `gorm:"double"`
}
