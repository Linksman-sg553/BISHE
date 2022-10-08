package model

type Gift struct {
	Gift_id       string `gorm:"VARCHAR(30) primary key"`
	Gift_name     string `gorm:"VARCHAR(30)"`
	Gift_value    int    `gorm:"int"`
	Gift_quantity int    `gorm:"int"`
}
