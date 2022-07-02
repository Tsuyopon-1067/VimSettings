package main

import (
    "fmt"
)

func main() {
    a := make([]int, 0)
    a = append(a, 1)
    a = append(a, 2)
    for i := 2; i < 6; i++ {
        a = append(a, a[i-1]+a[i-2])
    }
    fmt.Println(a)
    fmt.Println(len(a))

    for i := 0; i < 30; i++ {
        //fmt.Println(i, lower_bound(a, i))
    }
    for i := 0; i < 30; i++ {
        fmt.Println(i, upper_bound(a, i))
    }
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
