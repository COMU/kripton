proc maxArea(height: [?D]) : int
{
	var max = 0;	
	var left_index = 0;	
	var right_index = height.size - 1;	

	while ( left_index < right_index ) {
		var possible_max = 0;
		if ( height(left_index) < height(right_index) ) then {
			possible_max = height(left_index) * (right_index-left_index);
		}
		else {
			possible_max = height(right_index) * (right_index-left_index);
		}
		
		if ( max < possible_max ) then {
			max = possible_max;
		}
		if ( height(left_index) < height(right_index) ) then {
			left_index += 1;
		}
		else {
			right_index -= 1;
		}
	}
	return max;
}

var s = [1,3,44,2,44];
writeln(maxArea(s));
