/**
 * @param {number[]} height
 * @return {number}
 */

function maxArea(height) {
    let maxWaterHeight = 0;
    let leftIndex = 0, rightIndex = height.length - 1;

    while(leftIndex < rightIndex){
        maxWaterHeight = Math.max(maxWaterHeight,(rightIndex- leftIndex) * Math.min(height[leftIndex], height[rightIndex]));

        if (height[leftIndex] <= height[rightIndex])
            leftIndex++;
        else
            rightIndex--;
    }

    return maxWaterHeight;
}

console.log(maxArea([1,8,6,2,5,4,8,3,7]));