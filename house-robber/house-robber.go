// lisp kodunun algoritmasıdır
package main

import (
	"fmt"
)

func rob(nums []int) int {
	num_homes := len(nums)
	total_robbed := make([]int, num_homes)
	if num_homes == 0 {
		return 0
	} else if num_homes == 1 {
		return nums[0]
	}
	total_robbed[0] = nums[0]
	if nums[0] > nums[1] {
		total_robbed[1] = nums[0]
	} else {
		total_robbed[1] = nums[1]
	}
	for i := 2; i < num_homes; i++ {
		// max olmadığı için yapılan işlemler
		if total_robbed[i-1] > (total_robbed[i-2] + nums[i]) {
			total_robbed[i] = total_robbed[i-1]
		} else {
			total_robbed[i] = total_robbed[i-2] + nums[i]
		}
	}

	return total_robbed[len(total_robbed)-1]

}
func main() {
	x := []int{1, 2, 3, 1}
	fmt.Println(rob(x))
	x = []int{2, 7, 9, 3, 1}
	fmt.Println(rob(x))
}
