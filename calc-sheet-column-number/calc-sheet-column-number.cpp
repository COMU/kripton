// Build instruction: g++ -g calc-sheet-column-number.cpp -o calc-sheet-column-number.o

#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {

public:
    int titleToNumber(string s) 
    {
        string sLetters("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
        int nSum = 0;
        int nDigitNum = s.size(); // Hangi basamakta olduğumuzun bilgisini tutmak için tanımlandı.

        /*   sLetters.find(s[i])+1 sırası gelen harfin sLetters içindeki konumunu döndürecektir.
         *   Bu aynı zamanda harfin değeri anlamına da gelir.
         *   find fonksiyonu A'nın konumunu 0 döndürür. 1 den balşaması gerektiğinden +1 eklenmiştir.
         *
         *   C++ -- ++ operatörünü başta ve sonda kullanmanın farkı şöyledir.
         *   int x = 5;
         *   cout << x--  Çıktısı 5 olacaktır. Eksiltilmiş değer kullanım anına yansımaz. Sonraki satırlarda artık 4 olarak görülebilir.
         *
         *   int y = 5;
         *   cout << --y; Çıktısı 4 olacaktır. Eksiltilmiş değer tam kullanım anına yansır.
         */

        for(int i = 0; i< s.size(); i++)
            nSum += pow(26, --nDigitNum) * (sLetters.find(s[i])+1);  

        return nSum;
    }
};

int main()
{
    Solution sObj;
    string s1("KRPT");

    cout << "nSum: " << sObj.titleToNumber(s1) << endl; 
    return 0;
}
