package main

import (
)

func main() {
    n := 0

    for bit := 0; bit < (1 << uint(n)); bit++ {
        for j := 0; j < n; j++ {
            if ((bit >> uint(j)) & 1 ) == 1 {
            }
        }
    }
}
type Point struct {
    x, y int
}

func compareToPoint(l, r Point) (res int) {
    res = 0
    if l.x < r.x {
        res = 1
    } else if l.x > r.x {
        res = -1
    } else {
        if l.y < r.y {
            res = 1
        } else if l.y > r.y {
            res = -1
        }
    }
    return res
}

func lower_bound(a []int, x int) int {
    ng := -1; ok := len(a);
    for {
        m := (ok+ng)/2;
        if a[m] >= x {
            ok = m
        } else {
            ng = m
        }
        sa := ok - ng;
        if sa < 0 { sa = -sa };
        if sa <= 1 {
            res := -1;
            if 0 <= ok && ok < len(a){
                if a[ok] >= x {res = ok}
            }
            return res
        }
    }
}

