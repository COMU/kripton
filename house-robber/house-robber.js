let memorize = [];

var rob = function(nums) {

    //initialize the array with -1 . So we can understand whether the array is empty
    for(let i=0; i < 100; i++){
        memorize[i] = -1;
    }

    if (nums.length === 0){
        return 0;
    }
    //we can start stealing money from the first house or from the second house.
    //we'll calculate the total money for two different starts and turn the bigger one.
    return Math.max(subSum(nums, 0), subSum(nums, 1));
};

function subSum(nums, start){

    //If the starting index is greater than the length of the array, we return 0
    if (start > nums.length-1){
        return 0;
    }

    //if we've already calculated the path amount, we just get the value from the memorize array.
    if(memorize[start] !== -1){
        return memorize[start];
    }

    // If not, then we should calculate it.
    //We need to calculate 2 houses after and 3 houses after the starting index.
    //subSum is a recursive function. So we'll call it for both ways.
    let subMax = Math.max(subSum(nums, start+2), subSum(nums, start+3));
    memorize[start] = nums[start] + subMax;
    return nums[start] + subMax;
}