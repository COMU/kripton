#!/usr/bin/python3

# Solution for 198. House Robber on LeetCode
# https://leetcode.com/problems/house-robber/
from typing import List


class Solution:
    def rob(self, nums: List[int]) -> int:
        # we know that if the thief robbed i(th) house,
        # he will also rob one of the houses at i+2 or i+3.

        # we start from the last house and reassign a value
        # to i(th) element which shows max possible income
        # after i (including i)
        for i in range(len(nums)-1, -1, -1):
            # we will rob either i+2 or i+3 after i
            a = i+2 < len(nums) and nums[i+2] or 0
            b = i+3 < len(nums) and nums[i+3] or 0
            # more open version of one liner for readability
            # works slower :) 
            # if i+2 < len(nums):
            #    a = nums[i+2]
            # else:
            #    a = 0
            # if i+3 < len(nums):
            #    b = nums [i+3]
            # else:
            #    b = 0

            # pick one that will give us maximum
            nums[i] = max(a, b) + nums[i]

        # return element that will give maximum income
        return nums and sorted(nums)[-1] or 0


if __name__ == '__main__':
   print(Solution().rob([2, 7, 9, 3, 1]))
