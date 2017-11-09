int getTableSize() {
  return board.length;
}

int getValue(int i, int j) {
  return board[i][j];
}

void setTableSize(int size) {
  col = size;
}

void setValue(int i, int j, int val) {
  board[i][j] = val;
}

void symbol(float xPos, float yPos, float size, int type, int colour) {
  /* Draw the symbols ("X" or "O") */
  
  strokeWeight((8 * size) / 50);
  strokeCap(PROJECT);
  if (type == 1) {
    stroke(colour);
    ellipse(xPos, yPos, size + (8 * size) / 50, size + (8 * size) / 50);
  } else if (type == 2) {
    stroke(colour);
    line(xPos - size / 2, yPos - size / 2, xPos + size / 2, yPos + size / 2);
    line(xPos - size / 2, yPos + size / 2, xPos + size / 2, yPos - size / 2);
  }
  noFill();
}

void symbol(float xPos, float yPos, int type) {
  /* Draw the symbols ("X" or "O") in the board area. */
  
  float size = boardArea / (col * 2);
  strokeWeight((2 * boardArea) / (25 * col));
  strokeCap(PROJECT);
  if (type == 1) {
    stroke(#FFF8E1);
    ellipse(marginLeft + xPos, marginTop + yPos, boardArea / (col * 2), boardArea / (col * 2));
  } else if (type == 2) {
    stroke(#424242);
    line(marginLeft + xPos - size / 2, marginTop + yPos - size / 2, 
        marginLeft + xPos + size / 2, marginTop + yPos + size / 2);
    line(marginLeft + xPos - size / 2, marginTop + yPos + size / 2, 
        marginLeft + xPos + size / 2, marginTop + yPos - size / 2);
  }
}

void diagonalArrange(int[][] grid) {
  // Check the values that arrange in a diagonal row.
  
  if (scene == 0) {
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
          scene = 1;
          delayTime = true;
          carry = true;
          break;
        }
        outBound++;
      }
      if (scene == 1) {
        break;
      }
    }
  }
}

void horizontalArrange(int[][] grid) {
  // Check the values that arrange in a horizontal row.
  
  if (scene == 0) {
    for (int i = 0; i < col; i++) {
      for (int j = 0; j <= col - arrange; j++) {
        int[] identity = new int[arrange];
        int n = 0;
        for (int k = j; k < j + arrange; k++) {
          identity[n] = grid[i][k];
          n++;
        }
        if (duplicate(identity) && sum(identity) != 0) {
          if (sum(identity) == arrange) {
            result = 1;
          } else if (sum(identity) == 2 * arrange) {
            result = 2;
          }
          scene = 1;
          delayTime = true;
          carry = true;
          break;
        }
      }
      if (scene == 1) {
        break;
      }
    }
  }
}

int[][] inverseGrid(int[][] grid) {
  // Make the grid inverse.
  
  int[][] res = new int[col][col];
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      res[i][j] = grid[j][i];
    }
  }
  return res;
}

int[][] reflectGrid(int[][] grid) {
  // Make the grid reverse.
  
  int[][] res = new int[col][col];
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      res[i][j] = grid[i][col - 1 - j];
    }
  }
  return res;
}

int sum(int[] num) {
  // Return sum of the array.
  
  int res = 0;
  for (int i : num) {
    res += i;
  }
  return res;
}

boolean duplicate(int[] num) {
  // Return true if the array has all the same values.
  
  for (int i : num) {
    if (i != num[0]) {
      return false;
    }
  }
  return true;
}

boolean full(int[][] stuff) {
  // Return true if the array is full.
  
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      if (stuff[i][j] == 0) {
        return false;
      }
    }
  }
  return true;
}

boolean empty(int[][] stuff) {
  // Return true if the array is empty.
  
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      if (stuff[i][j] != 0) {
        return false;
      }
    }
  }
  return true;
}