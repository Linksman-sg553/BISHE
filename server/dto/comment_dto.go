package dto

import (
	"server/common"
	"server/model"
)

type CommentDto struct {
	Comment_id      int
	Content         string
	Publisher       UserDto
	Publish_article int
	Likes           int
	create_time     string
	Rate            int
	IsLiked         bool
}

// 完成类型转换, 判断用户点赞记录
func ToCommentDto(comment model.Comment, user_id int) CommentDto {
	DB := common.GetDB()
	var user = model.User{}
	DB.Where("user_id = ?", comment.Publish_user).First(&user)
	userDto := ToUserDto(user)
	// 判断点赞
	var com_like = model.Comment_like{}
	DB.Where("user_id = ? and comment_id = ?", user_id, comment.Comment_id).First(&com_like)
	var liked bool = false
	if com_like.Like_id != 0 {
		liked = true
	} else {
		liked = false
	}
	return CommentDto{
		Comment_id:      comment.Comment_id,
		Content:         comment.Content,
		Publisher:       userDto,
		Publish_article: comment.Publish_article,
		Likes:           comment.Likes,
		create_time:     comment.Create_time.Format("2006-1-2 15:04:05"),
		Rate:            comment.Rate,
		IsLiked:         liked,
	}
}
