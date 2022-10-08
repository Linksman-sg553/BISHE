package model

type Part_sec struct {
	Part_sec_id   string `gorm:"VARCHAR(30) primary key"`
	Part_sec_name string `gorm:"VARCHAR(30) not null"`
	Parent_part   string `gorm:"VARCHAR(30)"`
}
