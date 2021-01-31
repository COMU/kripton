// Build instruction: g++ -g container-with-most-water.cpp -o container-with-most-water.o

#include <iostream>
#include <vector>

using namespace std;

class Solution {

public:
    int maxArea(vector<int>& height)
    {
        int nLeft = 0;
        int nRight = height.size()-1;
        int nMaxArea = 0;
        int nWidth = 0; //Taban genişliği

        while (nLeft < nRight)
        {
            nWidth = nRight-nLeft; // Her ilerlemede tabanı güncelliyoruz
            nMaxArea = max(nMaxArea, nWidth * min(height[nLeft], height[nRight])); // Yeni alan = (Taban * küçük duvar).
                                                                                   // Yeni alan elimizdeki maximumdan büyük mü diye bakıyoruz.
            if (height[nLeft] < height[nRight]) // Küçük olan duvar tarafından bir adım içeri girmesini sağlıyoruz.
                nLeft++;
            else
                nRight--;
        }
        return nMaxArea;
    }
};

int main()
{
    Solution sObj;
    vector<int> height1 {1, 8, 6, 2, 5, 4, 8, 3, 7};

    cout << "Result: " << sObj.maxArea(height1) << endl;
    return 0;
}

