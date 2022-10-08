package main

import (
	"encoding/json"
	"fmt"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/spf13/viper"
	"os"
	"server/common"
	"server/model"
)

type MainSec struct {
	PartSec   string `json:"PartSec"`
	PartSecID string `json:"PartSecID"`
}

type MainCate struct {
	PartMain string    `json:"PartMain"`
	PartID   string    `json:"PartID"`
	List     []MainSec `json:"list"`
}

type Categorie struct {
	Categories []MainCate `json:"Categories"`
}

func Config() {
	workDir, _ := os.Getwd()
	viper.SetConfigName("application")
	viper.SetConfigType("yml")
	viper.AddConfigPath(workDir + "/config")
	err := viper.ReadInConfig()
	if err != nil {
		panic("")
	}
}

func main_1() {
	Config()
	db := common.InitDB()
	defer db.Close()
	DB := common.GetDB()
	filePtr, err := os.Open("categories.json")
	if err != nil {
		fmt.Println("文件创建失败", err.Error())
		return
	}
	defer filePtr.Close()
	// 创建Json编码器
	encoder := json.NewDecoder(filePtr)
	var Cate = Categorie{}
	err = encoder.Decode(&Cate)
	fmt.Println("开始插入 看一下第一个")
	fmt.Println(Cate.Categories[0].PartID)
	for _, cateMain := range Cate.Categories {
		// 插入主分区
		fmt.Println(cateMain.PartID, cateMain.PartMain)
		var mainP = model.Part_main{Part_id: cateMain.PartID, Part_name: cateMain.PartMain}
		DB.Create(&mainP)
		for _, cateSec := range cateMain.List {
			fmt.Println(cateSec.PartSecID)
			var mainSec = model.Part_sec{Part_sec_id: cateSec.PartSecID, Part_sec_name: cateSec.PartSec, Parent_part: cateMain.PartID}
			DB.Create(&mainSec)
		}
	}
}
