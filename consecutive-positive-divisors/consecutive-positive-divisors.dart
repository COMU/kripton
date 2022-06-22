void main() {
  print(consecutivePositiveDivisors(10000000));
}

int consecutivePositiveDivisors(int maxNumber) {
  int currentNumber = 0;
  int nextNumber = 0;
  int count = 0;
  List<int> newNumberDivisorArray = calculateDivisorsCount(maxNumber);
  for (int i = 2; i < maxNumber; i++) {
    currentNumber = i;
    nextNumber = i + 1;
    if (newNumberDivisorArray[currentNumber] ==
        newNumberDivisorArray[nextNumber]) {
      count++;
    }
  }
  return count;
}

List<int> calculateDivisorsCount(int num) {
  List<int> divisorArray = List.filled(num + 1, 0);
  for (int i = 1; i <= num; i++) {
    for (int j = 1; i * j <= num; j++) {
      divisorArray[i * j]++;
    }
  }
  return divisorArray;
}
