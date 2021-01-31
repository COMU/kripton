package main

import (
  "fmt"
  "math"
)

// Basic formula of function is getting values of characters which are in base26 presentation.

func titleToNumber(s string) int {
    sum := 0
    tmp := 0.0
    for i:= (len(s)-1); i!=-1; i-- {
    /*
      Character cast to integer for getting Ascii value
      64 subtract from ascii value to get character value
    */ 
        sum += (int(s[i])-64) * int(math.Pow(26, tmp))
        tmp += 1.0
    } 
    return sum
}


func main() {
  	s := "AB"
  	fmt.Println(titleToNumber(s))
}
