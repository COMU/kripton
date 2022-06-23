import 'dart:math';

void main() {
  List<int> heights = [1, 8, 6, 2, 5, 4, 8, 3, 7];
  print(maxArea(heights));
}

int maxArea(List<int> heights) {
  int maxWaterHeight = 0;
  int leftIndex = 0;
  int rightIndex = heights.length - 1;

  int waterHeight = 0;
  while (leftIndex < rightIndex) {
    waterHeight =
        min(heights[leftIndex], heights[rightIndex]) * (rightIndex - leftIndex);
    maxWaterHeight = max(maxWaterHeight, waterHeight);
    if (heights[leftIndex] < heights[rightIndex]) {
      leftIndex++;
    } else {
      rightIndex--;
    }
  }
  return maxWaterHeight;
}
