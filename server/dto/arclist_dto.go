package dto

import (
	"server/common"
	"server/model"
	"time"
)

type ArclistDto struct {
	Text_id     int              `json:"text_id"`
	Title       string           `json:"title"`
	Create_time time.Time        `json:"create_time"`
	Author      UserDto          `json:"author"`
	Likes       int              `json:"likes"`
	Paper       model.Paper_list `json:"paper"`
	Rate        int              `json:"rate"`
	Summary     string           `json:"summary"`
}

func ToArclistDto(article model.Article) ArclistDto {
	var resUser = model.User{}
	DB := common.GetDB()
	DB.Find(&resUser, "user_id = ?", article.Author)
	resUserDto := ToUserDto(resUser)
	// 获取论文信息
	var resPaper = model.Paper_list{}
	DB.Find(&resPaper, "paper_id = ?", article.Paper_id)
	return ArclistDto{
		Text_id:     article.Text_id,
		Title:       article.Title,
		Create_time: article.Create_time,
		Author:      resUserDto,
		Likes:       article.Likes,
		Paper:       resPaper,
		Rate:        article.Rate,
		Summary:     article.Summary,
	}
}
