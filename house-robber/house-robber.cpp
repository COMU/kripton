// Build instruction: g++ -g house-robber.cpp -o house-robber.o

#include <iostream>
#include <vector>

using namespace std;

int rob( vector<int> houses)
{
    if(houses.size() == 0) // Eğer ev sayısı 0 ise 0 dön
        return 0;
    else if(houses.size() == 1) // Ev sayısı 1 ise ilk elemanı dön
        return houses[0];
    else 
    {
        vector<int> result(houses.size(), 0); // Çözüm dizisi oluştur  ve elemanlarını 0 ata
        result[0] = houses[0]; // İlk eleman houses[0]
        result[1] = max(houses[0], houses[1]); // İkinci eleman max(houses[0], houses[1])

        for(int n = 2; n < houses.size(); n++) // İkinden son elemana kadar 
            result[n] = max(result[n-1], (result[n-2] + houses[n]));

        return result.back(); // Dizinin son elemanını dön
    }
}

int main()
{
    vector<int> houses {2, 7, 9, 3, 1};

    cout << "Result: " << rob(houses) << endl;

    return 0;
}

