package model

type Black_auth struct {
	Black_auth_id   int    `gorm:"int primary key NOT NULL Auto_Increment"`
	Black_auth_name string `gorm:"VARCHAR(100)"`
}
