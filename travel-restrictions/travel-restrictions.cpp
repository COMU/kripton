// Build instruction: g++ -g travel-restrictions.cpp -o travel-restrictions.o

#include <iostream>
#include <vector>
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

typedef pair<int, pair<string, string>> Case;
typedef vector<vector<char>> ResultMatrix;

// Soluiton class declaration
class Solution
{
public:
    ResultMatrix findCase(const Case& aCase);
    void readInput( string sInputFileName);
    void printResult(const ResultMatrix& aResult);

    int nInputCount; // save the first row of the input file. It means case count.
    vector<Case> aCaseArray; // a struct for a case. eg: 2, YY, NN
};

// Soluiton class definetion
ResultMatrix Solution::findCase(const Case& aCase)
{
        int nCountryCount = aCase.first;
        string sInput = aCase.second.first; // entry restriction rules for all countries.
        string sOutput = aCase.second.second; // exit restriction rules for all countries.
        ResultMatrix aResult;

        for(int nDeparture = 0; nDeparture < nCountryCount; nDeparture++)
        {
            vector<char> aResCase;

            for(int nArrival = 0; nArrival< nCountryCount; nArrival++)
            {
                bool bIsPassPermitted = true; // is there any permitted country between departure and arrival.
                int tmp; // holds country index between departure and arrival

                // No need to check restrictions if we won't travel.
                if( nDeparture == nArrival )
                {
                    aResCase.push_back('Y');
                    continue;
                }

                // If there is no exit restriction for departure country and no entry restriction for arrival
                // country , need to check if there is any restriction between departure and arrival countries.
                if (sOutput[nDeparture] == 'Y' && sInput[nArrival] == 'Y')
                {
                    if(nDeparture < nArrival)
                    {
                        tmp = nDeparture + 1;
                        while(tmp < nArrival)
                        {
                            if(sInput[tmp] == 'N' || sOutput[tmp] == 'N')
                            {
                                   bIsPassPermitted = false;
                                   break;
                            }
                            tmp++;
                        }
                    }
                    else
                    {
                        tmp = nArrival + 1;
                        while( tmp < nDeparture)
                        {
                            if(sInput[tmp] == 'N' || sOutput[tmp] == 'N')
                            {
                                   bIsPassPermitted = false;
                                   break;
                            }
                            tmp++;
                        }
                    }

                    if( bIsPassPermitted )
                        aResCase.push_back('Y');
                    else
                        aResCase.push_back('N');
                }
                else
                    aResCase.push_back('N');
            }

            aResult.push_back(aResCase);
        }

    return aResult;
}

void Solution::printResult(const vector<vector<char>>& aResult)
{
    for (int i = 0; i < aResult.size(); i++)
    {
        for (int j = 0; j < aResult[i].size(); j++)
            cout << aResult[i][j];

        cout << endl;
    }
}

void Solution::readInput( string sInputFileName)
{
    ifstream fInputFile(sInputFileName); // read the input file

    string sLine;
    int nLineCount = 0;
    int nCountryCount;
    bool bCheckFirst = true;
    Case aCase;

    while ( getline( fInputFile, sLine ) )
    {
        if( bCheckFirst )
        {
            nInputCount = stoi(sLine);
            bCheckFirst = false;
            continue;
        }

        switch( nLineCount % 3 ) // our cases consist of three lines. %3 help us to find  first second or third line of the case.
        {
            case 0: // country count
                nCountryCount = stoi(sLine);
                aCase.first = nCountryCount;
                nLineCount++;
                break;
            case 1: // entry restrictions
                aCase.second.first = sLine;
                nLineCount++;
                break;
            case 2: // exit restrictions
                aCase.second.second = sLine;
                aCaseArray.push_back(aCase);
                nLineCount++;
                break;
        }
    }
}

int main()
{
    Solution s1;
    s1.readInput("travel_restrictions_sample_input.txt");

    for(int i = 0; i < s1.aCaseArray.size(); i++)
    {
        cout << "Case #" << i+1 << endl;
        s1.printResult(s1.findCase(s1.aCaseArray[i]));
    }

    return 0;
}

