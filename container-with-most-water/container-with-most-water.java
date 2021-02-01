import java.lang.*;

class Solution {
    public int maxArea(int[] height) {
        int maxArea , leftIndex, rightIndex;
        maxArea = leftIndex = 0;
        rightIndex = height.length-1;

        while(leftIndex < rightIndex){
            int newArea = Math.min(height[leftIndex], height[rightIndex]) * (rightIndex- leftIndex);
            maxArea = Math.max(newArea, maxArea);
            
            if(height[leftIndex] > height[rightIndex])
                --rightIndex;
            else
                ++leftIndex;
        }
        return maxArea; 
    
    }
}

class Main {
    public static void main(String[] args) {
        int [] height = {1,8,6,2,5,4,8,3,7};
        Solution sl = new Solution();
        sl.maxArea(height);
    }
}
