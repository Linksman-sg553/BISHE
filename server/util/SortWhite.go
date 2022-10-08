package util

// Pair Map排序Value
type Pair struct {
	Key    int
	Value1 float64
	Value2 int
}

type PairList []Pair

func (p PairList) Swap(i, j int) { p[i], p[j] = p[j], p[i] }
func (p PairList) Len() int      { return len(p) }
func (p PairList) Less(i, j int) bool {
	if p[i].Value1 == p[j].Value1 {
		return p[i].Value2 < p[j].Value2
	}
	return p[i].Value1 < p[j].Value1
}
