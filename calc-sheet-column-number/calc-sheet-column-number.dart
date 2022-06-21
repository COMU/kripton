int titleToNumber(String s) {
  int result = 0;
  for (int i = 0; i < s.length; i++) {
    result = result * 26 + (s.codeUnitAt(i) - 64);
  }
  return result;
}

void main() {
  print(titleToNumber('A'));
  print(titleToNumber('AB'));
  print(titleToNumber('ZY'));
}
