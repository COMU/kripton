import 'dart:math';

void main() {
  List<int> houses = [1, 2, 3, 1, 7, 4, 3, 8];
  print(rob(houses));
}

int rob(List<int> houses) {
  if (houses.length == 0) {
    return 0;
  }
  if (houses.length == 1) {
    return houses[0];
  }
  if (houses.length == 2) {
    return max(houses[0], houses[1]);
  }
  int result = 0;
  int prev = 0;
  int cur = 0;
  for (int i = 0; i < houses.length; i++) {
    cur = max((prev + houses[i]), cur);
    prev = result;
    result = max(cur, result);
  }
  return result;
}
