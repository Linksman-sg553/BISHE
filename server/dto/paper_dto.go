package dto

import (
	"server/common"
	"server/model"
	"strings"
)

type Cate struct {
	Cate_sec model.Part_sec `json:"cate_sec"`
	Cate_Num string         `json:"cate_num"`
}

type Paper_DTO struct {
	Paper_id     int      `json:"Paper_id"`
	Paper_title  string   `json:"Paper_title"`
	Foreign_url  string   `json:"Foreign_url"`
	Paper_author []string `json:"Paper_author"`
	Summary      string   `json:"Summary"`
	Score        float64  `json:"Score"`
	Key_words    []string `json:"Key_words"`
	Categories   Cate     `json:"Categories"`
	IsDouble     bool     `json:"isDouble"`
	ISBlack      bool     `json:"isBlack"`
}

func ToPaperDto(Paper model.Paper_list) Paper_DTO {
	DB := common.GetDB()
	// 拆分评价字符串
	keywords := strings.Split(Paper.Key_word, ",")

	// 拆分Tag字符串
	authors := strings.Split(Paper.Paper_author, ",")

	var Cate_this Cate
	DB.Model(&model.Part_sec{}).Where("part_sec_id=?", Paper.Part_sec).First(&Cate_this.Cate_sec)
	Cate_this.Cate_Num = Paper.Categories

	var doubleCheck bool
	_, doubleCheck = common.DoubleList[Paper.Paper_id]

	blackCheck := false
	var Bcheck model.Black_paper
	DB.Where("black_paper_id=?", Paper.Paper_id).First(&Bcheck)
	if Bcheck.Black_paper_id != 0 {
		blackCheck = true
	}
	return Paper_DTO{
		Paper_id:     Paper.Paper_id,
		Paper_title:  Paper.Paper_title,
		Foreign_url:  Paper.Foreign_url,
		Paper_author: authors,
		Summary:      Paper.Summary,
		Score:        Paper.Score,
		Key_words:    keywords,
		Categories:   Cate_this,
		IsDouble:     doubleCheck,
		ISBlack:      blackCheck,
	}
}
