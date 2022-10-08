package common

import "fmt"

func InitPool() {
	DoubleList = make(map[int]DoublePost)
	UserAccuracy = make(map[int]UserAcc)
	fmt.Println("作者列表数")
	GetDoubleAll()
	GetWhiteAll()
}
