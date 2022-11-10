
// Top to Bottom approach for Maximum path sum I (Problem 18)

#include<stdio.h>

int main(void)
{
    int numbers[15][15] = 
    {
        {75},
        {95, 64},
        {17, 47, 82},
        {18, 35, 87, 10},
        {20, 4, 82, 47, 65},
        {19, 1, 23, 75, 3, 34},
        {88, 2, 77, 73, 7, 63, 67},
        {99, 65, 4, 28, 6, 16, 70, 92},
        {41, 41, 26, 56, 83, 40, 80, 70, 33},
        {41, 48, 72, 33, 47, 32, 37, 16, 94, 29},
        {53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14},
        {70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57},
        {91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48},
        {63, 66, 4, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31},
        {4, 62, 98, 27, 23, 9, 70, 98, 73, 93, 38, 53, 60, 4, 2}
    };

/*
    First for loop iterates each row from top to bottom (excl. the first row)
    Second for loop iterates each element (number) in the row.
    -> Each row has 'row-number' of elements / numbers, i.e: 3rd row has 3 elements.
    -> Each element picks the greater number of the two neighboring elements from the upper row.
        * Leftmost element can only pick the first element from the upper row.
        * Rightmost element can only pick the last element from the upper row.
    -> Then the selected number is summed into the current element.
    -> At the end of the loop, last row contains the greatest possible numbers.
*/

    for(int row = 1; row < 15; row++)
    {
        for(int element = 0; element <= row; element++)
        {
            // For the leftmost side
            if(element == 0)
                numbers[row][element] += numbers[row-1][element];

            // For the rightmost side
            else if(element == row)
                numbers[row][element] += numbers[row-1][element-1];

            // For everywhere else
            else
            {
                int left = numbers[row-1][element-1];
                int right = numbers[row-1][element];

                if(left > right)
                    numbers[row][element] += left;
                else
                    numbers[row][element] += right;
            }
        }
    }

    /*
        Elements of the last row contains the greatest possible numbers.
        Biggest one of them is the answer we're looking for.
    */

    int max = -1;

    for(int i = 0; i < 15; i++)
    {
        if(numbers[14][i] > max)
            max = numbers[14][i];
    }
    
    printf("max: %d\n", max);
}