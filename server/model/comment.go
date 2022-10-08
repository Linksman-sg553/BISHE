package model

import "time"

type Comment struct {
	Comment_id      int       `gorm:"int primary key Auto_Increment"`
	Content         string    `gorm:"longtext"`
	Publish_user    int       `gorm:"int"`
	Publish_article int       `gorm:"int"`
	Likes           int       `gorm:"int"`
	Create_time     time.Time `gorm:"datetime"`
	Rate            int       `gorm:"int"`
}
