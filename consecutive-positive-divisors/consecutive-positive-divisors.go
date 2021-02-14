package main

import "fmt"

func main() {
	count := 0
	var numberdivisorarray [10000001]int
	var newnumberdivisorarray [10000001]int

	for i := 1; i <= 10000000; i++ {
		for j := 1; i*j <= 10000000; j++ {
			numberdivisorarray[i*j] = numberdivisorarray[i*j] + 1

		}
	}

	newnumberdivisorarray = numberdivisorarray

	for l := 2; l < 10000000; l++ {
		if newnumberdivisorarray[l] == numberdivisorarray[l+1] {
			count++

		}
	}

	fmt.Println(count)

}
