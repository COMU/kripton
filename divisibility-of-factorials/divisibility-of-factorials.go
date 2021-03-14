package main

import (
	"fmt"
	"math"
)

const LIMIT uint64 = 100000001

func main() {
	var smallest []uint64
	var n, v, i, sum, coeff, j, temp, k uint64

	for n = 0; n < LIMIT; n++ {
		smallest = append(smallest, 0)
	}

	for i = 2; i < LIMIT; i++ {
		if smallest[i] == 0 {
			coeff = 1
			j = i
			for coeff < (LIMIT / 2) {
				coeff *= i
				for k = coeff; k < LIMIT; k += coeff {
					smallest[k] = uint64(math.Max(float64(j), float64(smallest[k])))
				}
				temp = j / i
				for temp%i == 0 {
					coeff *= i
					temp /= i
				}
				j += i
			}
			continue
		}
	}

	sum = 0
	for _, v = range smallest {
		sum += v
	}

	fmt.Printf("sum: %d\n", sum)
}
