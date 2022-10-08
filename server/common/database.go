package common

import (
	"fmt"
	"github.com/jinzhu/gorm"
	"github.com/spf13/viper"
	"net/url"
	"server/model"
)

var DB *gorm.DB

func InitDB() *gorm.DB {
	driverName := viper.GetString("datasource.driverName")
	host := viper.GetString("datasource.host")
	port := viper.GetString("datasource.port")
	database := viper.GetString("datasource.database")
	username := viper.GetString("datasource.username")
	password := viper.GetString("datasource.password")
	charset := viper.GetString("datasource.charset")
	loc := viper.GetString("datasource.loc")

	args := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=%s&parseTime=true&loc=%s",
		username,
		password,
		host,
		port,
		database,
		charset,
		url.QueryEscape(loc))
	fmt.Printf(args)
	db, err := gorm.Open(driverName, args)
	if err != nil {
		panic("fail to connect database, err: " + err.Error())
	}
	db.AutoMigrate(&model.User{})
	db.AutoMigrate(&model.Article{})
	db.AutoMigrate(&model.Part_main{})
	db.AutoMigrate(&model.Part_sec{})
	db.AutoMigrate(&model.Comment{})
	db.AutoMigrate(&model.Gift{})
	db.AutoMigrate(&model.Paper_list{})
	db.AutoMigrate(&model.Black_auth{})
	db.AutoMigrate(&model.Article_like{})
	db.AutoMigrate(&model.Comment_like{})
	db.AutoMigrate(&model.Informations{})
	db.AutoMigrate(&Double_store{})
	DB = db
	return db
}

func GetDB() *gorm.DB {
	return DB
}
