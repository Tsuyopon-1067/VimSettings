package main

import (
    "fmt"
    "sort"
)

func main() {
    a := make([]Point, 3)
    sort.Slice(a, func(i, j int) bool {
        return compareToPoint(a[i], a[j]) > 0
    })
    fmt.Println("hello")
}
func lower_bound(a []int, x int) int {
    ng := -1
    ok := len(a)
    for {
        m := (ok + ng) / 2
        if a[m] >= x {
            ok = m
        } else {
            ng = m
        }
        sa := ok - ng
        if sa < 0 {
            sa = -sa
        }
        if sa <= 1 {
            res := -1
            if 0 <= ok && ok < len(a) {
                if a[ok] >= x {
                    res = ok
                }
            }
            return res
        }
    }
}
func upper_bound(a []int, x int) int {
    ng := -1
    ok := len(a)
    for {
        m := (ok + ng) / 2
        if a[m] > x {
            ok = m
        } else {
            ng = m
        }
        sa := ok - ng
        if sa < 0 {
            sa = -sa
        }
        if sa <= 1 {
            res := -1
            if 0 <= ok && ok < len(a) {
                if a[ok] > x {
                    res = ok
                }
            }
            return res
        }
    }
}
func distance2 (p, q Point) int {
    dx := p.x - q.x
    dy := p.y - q.y
    return dx*dx + dy*dy
}

type Point struct {x,y int}
func compareToPoint(l, r Point)(res int){res = 0;if l.x<r.x{res=1}else if l.x>r.x{res=-1}else{if l.y<r.y{res=1}else if l.y>r.y{res=-1}};return res}
func lower_boundPoint(a []Point, x Point)int{ng:=-1;ok:=len(a);for{m:=(ok+ng)/2;if compareToPoint(a[m],x)<=0 {ok=m}else{ng=m};sa:=ok-ng;if sa<0 {sa=-sa};if sa<=1{res:=-1;if 0<= ok&&ok<len(a){if compareToPoint(a[ok],x)<=0 {res=ok}};return res}}}
