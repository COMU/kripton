
package main

import (
  "fmt"
  "math"
)


func maxArea(height []int) int {
    max, left_index, right_index := 0, 0, len(height)-1
    for left_index < right_index {
        possible_max := int(math.Min(float64(height[left_index]), float64(height[right_index])) * float64(right_index-left_index))
        /*
        Open version of min and max functions
        possible_max := 0
        if height[left_index] < height[right_index] {
            possible_max = height[left_index] * (right_index - left_index)
            left_index += 1
        } else {
            possible_max = height[right_index] * (right_index - left_index)
            right_index -= 1
        }
        */
        if max < possible_max {
            max = possible_max
        }
        if height[left_index] < height[right_index] {
            left_index += 1
        } else {
            right_index -= 1
        }
    }
    return max
}

func main() {
    s := int[]{1,3,44,2,44}
    fmt.Println(maxArea(s))
}
