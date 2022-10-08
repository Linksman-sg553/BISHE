package common

import (
	"server/model"
)

// PaperBlackStatus 论文的黑名单状态
// @brief: 若超过十篇评论且这个论文评分低于2，进入黑名单
// toDo: 论文一旦进入黑名单无法平反，无法继续对其发表评价
func PaperBlackStatus(paper *model.Paper_list) (isBlack bool) {
	// 获取数据库句柄
	DB := GetDB()
	// 统计评论次数
	var countArticles int32
	DB.Model(&model.Article{}).Where("paper_id=?", paper.Paper_id).Count(&countArticles)

	// 判断评分
	if countArticles > 10 {
		var blackCheck = model.Black_paper{}
		DB.Find(&blackCheck, "black_paper_id=?", paper.Paper_id)
		if blackCheck.Black_paper_id == 0 {
			if paper.Score < 2 {
				// 第一次进名单
				var blackPaper = model.Black_paper{Black_paper_id: paper.Paper_id}
				DB.Create(&blackPaper)
				return true
			} else {
				return false
			}

		} else {
			if paper.Score >= 2 {
				DB.Delete(&blackCheck)
				return false
			} else {
				return true
			}
		}
	}
	return false
}

func UserBlackStatus(user *model.User) (isBlack bool) {
	DB := GetDB()

	// 看看是否已经在黑名单了
	var BlackUser = model.Black_user{}
	DB.Find(&BlackUser, "black_user_id=?", user.User_id)
	if BlackUser.Black_user_id != 0 {
		// 在黑名单
		if user.Credit < 60 {
			// 屡教不改
			return true
		} else {
			// 信用好了，从黑名单移除
			DB.Delete(&model.Black_user{}, user.User_id)
			// controller.PostSysInfo("您由于信用改善，已从黑名单移除", user.User_id)
			return false
		}
	} else {
		if user.Credit < 60 {
			// 第一次进来，创建记录
			var iBlack = model.Black_user{Black_user_id: user.User_id}
			DB.Create(&iBlack)
			// controller.PostSysInfo("您由于信用不佳，已进入黑名单", user.User_id)
			return true
		}
	}
	return false
}

// ArticleBlackStatus 文章黑名单
// 此函数应该有该包下的二审方法调用，不应让控制器调用 设私有
func articleBlackStatus(article *model.Article) {
	// 获取数据库句柄
	DB := GetDB()
	DB.Model(model.Article{}).Where("text_id=?", article.Text_id).Update("article_status", 3)
	var blackArticle = model.Black_article{Black_article_id: article.Text_id}
	DB.Create(&blackArticle)
}
