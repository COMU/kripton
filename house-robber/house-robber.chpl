use Sort;
proc rob(nums: [?D]) : int
{
	var num_homes: int = nums.size;
	
	var total_robbed: [0..num_homes-1] int;
	if(num_homes == 0) then return 0;
	else if(num_homes == 1) then return nums(0);
	
	total_robbed(0) = nums(0);

	if(nums(0) > nums(1)) then total_robbed(1) = nums(0);
	else total_robbed(1) = nums(1);

	for i in 2..nums.size-1 {
		if (total_robbed(i-1) > (total_robbed(i-2) + nums(i))) then total_robbed(i) = total_robbed(i-1);
		else total_robbed(i) = total_robbed(i-2) + nums(i);
	}
	return total_robbed(total_robbed.size - 1);
}

var a = [2,7,9,3,1];
writeln(rob(a));
