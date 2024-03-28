#include <iostream>

int counter = 0;

int main()
{
    for(int i = 1; i < 10000000; i++){
        int number = i;
        while(number != 1 && number != 89){
            int temp = 0;
            while(number != 0){
                temp += (number % 10) * (number % 10);
                number /= 10;

            }
            number = temp;
        }
        if(number == 89){
            counter++;
        }
    }
    printf("%d", counter);
}
