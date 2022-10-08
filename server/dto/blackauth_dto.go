package dto

import "server/model"

type BlackAuthDto struct {
	BlackAuth_id   int    `json:"BlackAuth_id"`
	BlackAuth_name string `json:"BlackAuth_name"`
}

func ToBlackAuthDto(blackauth model.Black_auth) BlackAuthDto {
	return BlackAuthDto{
		BlackAuth_id:   blackauth.Black_auth_id,
		BlackAuth_name: blackauth.Black_auth_name,
	}
}
