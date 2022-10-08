package main

import (
	"fmt"
	"sort"

	"server/util"
)

type bt struct {
	ib int
}

func (m *bt) set() {
	m.ib = 5
}

func (m *bt) change() {
	m.ib = 1
}

var at map[int]bt

func change() {
}

func main1() {
	at = make(map[int]bt)

	tb := at[1]
	tb.set()
	fmt.Println("change before ", tb.ib)
	fmt.Println("change before ", at[1].ib)
	tb.change()
	fmt.Println("change after ", tb.ib)
	at[1] = tb
	fmt.Println("change after ", at[1].ib)

}

type ccc struct {
	value1 float64
	value2 int
}

func main() {
	var clist []ccc
	clist = append(clist, ccc{0.7, 4})
	clist = append(clist, ccc{0.8, 4})
	clist = append(clist, ccc{0.9, 5})
	clist = append(clist, ccc{0.6, 3})
	clist = append(clist, ccc{0.6, 1})
	clist = append(clist, ccc{0.6, 2})
	clist = append(clist, ccc{0.6, 2})
	clist = append(clist, ccc{0.6, 4})
	clist = append(clist, ccc{0.6, 15})

	var sortSlice = make(util.PairList, 0)

	for key, itx := range clist {
		if key == 0 {
			continue
		}
		sortSlice = append(sortSlice, util.Pair{Key: key, Value1: itx.value1, Value2: itx.value2})
	}
	sort.Sort(sort.Reverse(sortSlice))
	for _, itx := range clist {
		fmt.Println(itx.value1, itx.value2)
	}
}
