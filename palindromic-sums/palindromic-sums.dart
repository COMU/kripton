import 'dart:math';

void main() {
  Set<int> sumSet = Set<int>();
  int squareSum = 0;
  for (int n = 1; n < 7072; n++) {
    squareSum = n * n;
    for (int m = n + 1; m < 7072; m++) {
      squareSum += m * m;
      if (squareSum > pow(10, 8)) {
        break;
      }
      if (isPalindrome(squareSum)) {
        sumSet.add(squareSum);
      }
    }
  }
  print(sumSet.reduce((a, b) => a + b));
}

bool isPalindrome(int squareSum) {
  String str = squareSum.toString();
  int length = str.length;
  for (int i = 0; i < length / 2; i++) {
    if (str[i] != str[length - i - 1]) {
      return false;
    }
  }
  return true;
}
