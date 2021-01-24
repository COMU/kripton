let memorize = [];

var rob = function(nums) {
    for(let i=0; i < 100; i++){
        memorize[i] = -1;
    }

    if (nums.length === 0){
        return 0;
    }
    return Math.max(subSum(nums, 0), subSum(nums, 1));
};

function subSum(nums, start){
    if (start > nums.length-1){
        return 0;
    }
    if(memorize[start] !== -1){
        return memorize[start];
    }
    let subMax = Math.max(subSum(nums, start+2), subSum(nums, start+3));
    memorize[start] = nums[start] + subMax;
    return nums[start] + subMax;
}