void diagonalArrange(int[][] grid) {
  if (checker) {
    for (int i = 0; i <= col - arrange; i++) {
      int outBound = 0;
      for (int j = i; j <= col - arrange; j++) {
        int[] identity = new int[arrange];
        int inBound = outBound;
        int n = 0;
        for (int k = j; k < j + arrange; k++) {
          identity[n] = grid[k][inBound];
          inBound++;
          n++;
        }
        if (duplicate(identity) && sum(identity) != 0) {
          if (sum(identity) == arrange) {
            result = 1;
          } else if (sum(identity) == 2 * arrange) {
            result = 2;
          }
          checker = false;
          delayTime = true;
          carry = true;
          break;
        }
        outBound++;
      }
      if (!checker) {
        break;
      }
    }
  }
}

int[][] inverseGrid(int[][] grid) {
  int[][] res = new int[col][col];
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      res[i][j] = grid[j][i];
    }
  }
  return res;
}

int[][] reflectGrid(int[][] grid) {
  int[][] res = new int[col][col];
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      res[i][j] = grid[i][col - 1 - j];
    }
  }
  return res;
}