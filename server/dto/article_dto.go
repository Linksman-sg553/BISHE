package dto

import (
	"fmt"
	"server/common"
	"strings"

	"server/model"
	"time"
)

type Article_Dto struct {
	Text_id         int       `json:"Text_id"`
	Title           string    `json:"Title"`
	MainText        string    `json:"MainText"`
	Create_time     time.Time `json:"Create_time"`
	Author          UserDto   `json:"Author"`
	PartOfMain      string    `json:"PartOfMain"`
	PartOfSec       string    `json:"PartOfSec"`
	Tag_collection  []string  `json:"Tag_collection"`
	Anti_collection []string  `json:"Anti_collection"`
	Rate            int       `json:"Rate"`
	Likes           int       `json:"Likes"`
	Paper           Paper_DTO `json:"Paper"`
	Summary         string    `json:"summary"`
	IsLiked         bool      `json:"IsLiked"`
	Article_status  int       `json:"Article_status"`
}

func ToArticleDto(article model.Article, user_id int) Article_Dto {
	// 获取作者信息
	var resUser = model.User{}
	DB := common.GetDB()
	DB.Find(&resUser, "user_id = ?", article.Author)
	resUserDto := ToUserDto(resUser)
	// 获取论文信息
	var resPaper = model.Paper_list{}
	DB.Find(&resPaper, "paper_id = ?", article.Paper_id)
	// 拆分评价字符串
	collection_anti := strings.Split(article.Anti_collection, ",")
	// 拆分Tag字符串
	collection_tags := strings.Split(article.Tag_collection, ",")
	// 判断点赞
	var arc_like = model.Article_like{}
	DB.Where("user_id = ? and text_id = ?", user_id, article.Text_id).First(&arc_like)
	fmt.Println("点赞id")
	fmt.Println(user_id)
	var liked bool = false
	if arc_like.Like_id != 0 {
		liked = true
	} else {
		liked = false
	}
	return Article_Dto{
		Text_id:         article.Text_id,
		Title:           article.Title,
		MainText:        article.Main_text,
		Create_time:     article.Create_time,
		Author:          resUserDto,
		PartOfMain:      article.Part_of_main,
		PartOfSec:       article.Part_of_sec,
		Tag_collection:  collection_tags,
		Anti_collection: collection_anti,
		Rate:            article.Rate,
		Likes:           article.Likes,
		Paper:           ToPaperDto(resPaper),
		Summary:         article.Summary,
		IsLiked:         liked,
		Article_status:  article.Article_status,
	}
}
