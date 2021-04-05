//
// Created by Engin Manap on 14.03.2021.
//

// Needs C++20

#include <iostream>
#include <cstring>
#include <chrono>

bool *numbers;
long long *numberResults;
bool debugEnabled;

inline void printDebug(const std::string& output) {
    if(debugEnabled) {
        std::cout << output;
    }
}

inline bool findNextElement(size_t& currentNumber, size_t arraySize, bool currentDirection) {
    printDebug("searching from " + std::to_string(currentNumber) + " with " + std::to_string(currentDirection) + ":");
    int direction;
    size_t limit;
    if(currentDirection) {
        direction = 1;
        limit = arraySize+1;
    } else {
        direction = -1;
        limit = 1;
    }
    while (numbers[currentNumber] == 1 && currentNumber != limit) {
        currentNumber +=direction;
    }
    if(currentNumber == limit) {
        currentNumber -=direction;
        printDebug(" not found\n");
        return false;
    }
    printDebug(" found " + std::to_string(currentNumber) +"\n");
    return true;
}

long long bruteForceSearch(long long arraySize) {

    numbers = (bool*)malloc(arraySize  + 1);
    memset(numbers, 0, arraySize  + 1);
    size_t lastNumber = 0;
    size_t remainingNumberCount = arraySize;
    size_t currentNumber = 1;
    bool currentDirection = true;//true forward false backward;
    while(true) {
        if(!numbers[currentNumber]) {
            remainingNumberCount--;
            numbers[currentNumber] = true;
            lastNumber = currentNumber;
            printDebug(std::to_string(currentNumber) + "\n");
        }
        if(remainingNumberCount == 0) {
            break;
        }
        bool found = false;
        if(findNextElement(currentNumber, arraySize, currentDirection)) {
            //there is a number to process, but we should skip one
            if(currentNumber == arraySize || currentNumber == 1) {
                //limits reached, reverse
            } else {
                currentDirection ? currentNumber++ : currentNumber--;
                printDebug("found continue\n");
                if (findNextElement(currentNumber, arraySize, currentDirection)) {
                    found = true;
                    printDebug("found done\n");
                }
            }
        }
        if(!found) {
            //we didn't found 2 numbers, reverse and search again
            currentDirection = !currentDirection;
            //since we didn't change the number, if it is valid it will be no op
            findNextElement(currentNumber, arraySize, currentDirection);
        }
    }
    delete numbers;
    return lastNumber;
}

long long algorithmicSearch(long long arraySize) {
    if (arraySize == 1) {
        return 1;
    }
    if (arraySize == 2 || arraySize == 3) {
        return 2;
    }
    long long previous = arraySize / 4;
    long long result = algorithmicSearch(previous) * 4;
    if (arraySize % 4 < 2) {
        result -= 2;
    }
    return result;
}

bool setupNumberResults(long long arraySize) {
    numberResults = (long long*)malloc(sizeof(long long)*arraySize  + 1);
    if(numberResults == nullptr) {
        std::cerr << "unable to allocate " << std::endl;
        return false;
    }
    memset(numberResults, 0, sizeof (long long)*arraySize  + 1);
    numberResults[1] = 1;
    numberResults[2] = numberResults[3] = 2;
    return true;
}

inline long long algorithmicAndMemoizationSearch(long long arraySize) {
    if(numberResults[arraySize] != 0) {
        return numberResults[arraySize];
    }
    long long previous = arraySize / 4;
    long long result = algorithmicAndMemoizationSearch(previous) * 4;
    if (arraySize % 4 < 2) {
        result -= 2;
    }
    numberResults[arraySize] = result;
    return result;
}

const int MOD = 987654321;

inline long long bruteForceTotal(long long arraySize) {
    auto start = std::chrono::steady_clock::now();
    long long result = 0;
    for (int i = 1; i <= arraySize; ++i) {
        result += bruteForceSearch(i);
        result = result % MOD;
    }
    std::chrono::duration<double> elapsed_seconds = std::chrono::steady_clock::now() - start;
    std::cout << "Brute force result for " << arraySize << " is " << result << std::endl;
    std::cout << "Brute force elapsed time: " << elapsed_seconds.count() << "s" << std::endl;
    return result;
}

inline long long algorithmicIterativeTotal(long long arraySize) {
    auto start = std::chrono::steady_clock::now();
    long long result = 0;
    for (int i = 1; i <= arraySize; ++i) {
        result += algorithmicSearch(i);
        result = result % MOD;
    }
    std::chrono::duration<double> elapsed_seconds = std::chrono::steady_clock::now() - start;
    std::cout << "Algorithmic Iterative result for " << arraySize << " is " << result << std::endl;
    std::cout << "Algorithmic Iterative elapsed time: " << elapsed_seconds.count() << "s" << std::endl;
    return result;
}

inline long long algorithmicAndMemoizationTotal(long long arraySize) {
    auto start = std::chrono::steady_clock::now();
    long long result = 0;
    for (int i = 1; i <= arraySize; ++i) {
        result += algorithmicAndMemoizationSearch(i);
        result = result % MOD;
    }
    std::chrono::duration<double> elapsed_seconds = std::chrono::steady_clock::now() - start;
    std::cout << "Algorithmic Memoization result for " << arraySize << " is " << result << std::endl;
    std::cout << "Algorithmic Memoization elapsed time: " << elapsed_seconds.count() << "s" << std::endl;
    return result;
}

inline long long algorithmicFullTotalRecursive(long long arraySize) {
    if (arraySize == 0)
        return 0;
    if (arraySize == 1)
        return 1;
    if (arraySize == 2)
        return 3;
    if (arraySize == 3)
        return 5;
    long long x = arraySize / 4;
    long long result = algorithmicFullTotalRecursive(x - 1) * 16 - (x - 1) * 4 + 5;
    result = result % MOD;
    for(long long i = x * 4; i <= arraySize; ++i) {
        result = result + algorithmicSearch(i) % MOD;
    }
    return (result + MOD) % MOD;
}

inline long long aLgorithmicFullTotal(long long arraySize) {
    auto start = std::chrono::steady_clock::now();
    long long result = algorithmicFullTotalRecursive(arraySize);
    std::chrono::duration<double> elapsed_seconds = std::chrono::steady_clock::now() - start;
    std::cout << "Full Algorithmic result for " << arraySize << " is " << result << std::endl;
    std::cout << "Full Algorithmic elapsed time: " << elapsed_seconds.count() << "s" << std::endl;
    return result;
}

int main() {
    debugEnabled = false;
    long long result;
    long long smallNumber = 1e8;
    long long mediumNumber = 1e9;
    long long bigNumber = 1e18;

    auto bruteForceStartTime = std::chrono::steady_clock::now();
    result = bruteForceSearch(smallNumber);

    std::chrono::duration<double> elapsed_seconds = std::chrono::steady_clock::now() - bruteForceStartTime;
    std::cout << "Brute Force Search result for " << smallNumber << " is " << result << std::endl;
    std::cout << "Brute Force Search  elapsed time: " << elapsed_seconds.count() << "s" << std::endl;
    result = algorithmicSearch(smallNumber);
    std::cout << "Algorithmic Search result for " << smallNumber << " is " << result << std::endl;

    //Algorithmic search if fast enough to try calculating bigger numbers
    algorithmicIterativeTotal(mediumNumber);
    //Iterative total is not fast enough, try to memoize
    if(setupNumberResults(mediumNumber)) {
        algorithmicAndMemoizationTotal(mediumNumber);
        free(numberResults);
    }
    //even with memoize it is not fast enough try full algorithmic
    aLgorithmicFullTotal(mediumNumber);
    //full algorithmic was fast enough, try the big number
    aLgorithmicFullTotal(bigNumber);

}