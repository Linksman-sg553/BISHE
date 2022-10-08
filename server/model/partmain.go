package model

type Part_main struct {
	Part_id   string `gorm:"VARCHAR(30) primary key"`
	Part_name string `gorm:"VARCHAR(30) not null"`
}
