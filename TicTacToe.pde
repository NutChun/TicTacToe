int col = 7;
int arrange = 7;
int[][] newGrid = new int[col][col];
int turn = 1;
boolean checker = true;
boolean delayTime = false;
int result = 0;
float minWidth;
float paddingTop, paddingLeft;
int scoreX = 0, scoreY = 0;
boolean carry = false;

void setup() {
//  size(500, 500);
  fullScreen();
}

void draw() {
  background(#00BFA5);
  fill(#ECEFF1);
  rect(0, 0, width, 100);
  
  strokeCap(PROJECT);
  stroke(#00796B);
  
  minWidth = min(width - 40 ,height - 190);
  
  paddingTop = (height - 150 - minWidth) / 2 + 100;
  paddingLeft = (width - minWidth) / 2;
  
  noFill();
  
  if (checker) {
    drawGrid();
    
    for (int i = 0; i < col; i++) {
      for (int j = 0; j < col; j++) {
        symbol((minWidth * (2 * i + 1)) / ( 2 * col),
            (minWidth * (2 * j + 1)) / ( 2 * col),
            newGrid[i][j]);
      }
    }
  }
  
  showResult();
  duplicateChecker();
  
  noStroke();
  textSize(30);
  
  if (turn == 1) {
    fill(#00796B);
    rect(15, 28, 150, 50, 35);
    fill(#ECEFF1);
    rect(width - 165, 28, 150, 50, 35);
  } else if (turn == 0) {
    fill(#ECEFF1);
    rect(15, 28, 150, 50, 35);
    fill(#00796B);
    rect(width - 165, 28, 150, 50, 35);
  }
  
  fill(255);
  rect(15, 25, 150, 50, 35);
  rect(width - 165, 25, 150, 50, 35);
  symbol(45, 50, 20, 2, #424242);
  symbol(width - 135, 50, 20, 1, #424242);
  fill(0);
  textAlign(RIGHT, CENTER);
  text(scoreX, 145, 45);
  text(scoreY, width - 35, 45);
  
  fill(255);
  textAlign(CENTER, BOTTOM);
  textSize(16);
  
  noFill();
  noStroke();
  
  String str = "NEW GAME";
  
  fill(#00796B);
  rect((width - textWidth(str)) / 2 - 7, height - 47, textWidth(str) + 20, 30, 3);
  fill(255);
  rect((width - textWidth(str)) / 2 - 10, height - 50, textWidth(str) + 20, 30, 3);
  fill(0);
  textAlign(CENTER, CENTER);
  text(str, width / 2, height - 35);
  noFill(); //<>//
}

void mousePressed() {
//  if (mouseButton == LEFT) {
    if (checker) {
      cellArea();
    }
    
    String str = "NEW GAME";
    
    if (mouseX > (width - textWidth(str)) / 2 - 10 && 
        mouseX < (width + textWidth(str)) / 2 + 10 &&
        mouseY > height - 50 &&
        mouseY < height - 20) {
          newGrid = new int[col][col];
          checker = true;
          delayTime = false;
          result = 0;
    }
    if (mouseX > width - 165 &&
        mouseX < width - 165 + 150 &&
        mouseY > 25 && mouseY < 75 &&
        turn == 1 && empty()) {
      turn = 0;
    }
    if (mouseX > 15 &&
        mouseX < 15 + 150 &&
        mouseY > 25 && mouseY < 75 &&
        turn == 0 && empty()) {
      turn = 1;
    }
//  }
}

void symbol(float xPos, float yPos, float size, int type, int colour) {
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
  float size = minWidth / (col * 2);
  strokeWeight((2 * minWidth) / (25 * col));
  strokeCap(PROJECT);
  if (type == 1) {
    stroke(#FFF8E1);
    ellipse(paddingLeft + xPos, paddingTop + yPos, minWidth / (col * 2), minWidth / (col * 2));
  } else if (type == 2) {
    stroke(#424242);
    line(paddingLeft + xPos - size / 2, paddingTop + yPos - size / 2, 
        paddingLeft + xPos + size / 2, paddingTop + yPos + size / 2);
    line(paddingLeft + xPos - size / 2, paddingTop + yPos + size / 2, 
        paddingLeft + xPos + size / 2, paddingTop + yPos - size / 2);
  }
}

void drawGrid() {
  strokeWeight((2 * minWidth) / (25 * col));
  
  // vertical grid line
  for (int i = 1; i < col; i++) {
    line((i * minWidth) / col + paddingLeft, paddingTop + (2 * minWidth) / (25 * col), 
        (i * minWidth) / col + paddingLeft, paddingTop + minWidth - (2 * minWidth) / (25 * col));
  }
  
  // horizontal grid line
  for (int i = 1; i < col; i++) {
    line(paddingLeft + (2 * minWidth) / (25 * col), (i * minWidth) / col + paddingTop, 
        paddingLeft + minWidth - (2 * minWidth) / (25 * col), (i * minWidth) / col + paddingTop);
  }
}

void cellArea() {
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      if (mouseX > paddingLeft + (i * minWidth) / col &&
          mouseX < paddingLeft + ((i + 1) * minWidth) / col &&
          mouseY > paddingTop + (j * minWidth) / col &&
          mouseY < paddingTop + ((j + 1) * minWidth) / col) {
        if (newGrid[i][j] == 0) {
          newGrid[i][j] = turn + 1;
          turn = 1 - turn;
        }
      }
    }
  }
}

void duplicateChecker() {
  int[] identity = new int[arrange];
  int n = 0;
  
  // horizontal
  if (checker) {
    for (int i = 0; i < col; i++) {
      for (int j = 0; j <= col - arrange; j++) {
        for (int k = j; k < j + arrange; k++) {
          identity[n] = newGrid[i][k];
          n++;
        }
        if (duplicate(identity)) {
          if (sum(identity) == arrange) {
            result = 1;
            checker = false;
            delayTime = true;
            identity = new int[arrange];
            carry = true;
            break;
          } else if (sum(identity) == 2 * arrange) {
            result = 2;
            checker = false;
            delayTime = true;
            identity = new int[arrange];
            carry = true;
            break;
          }
        }
        identity = new int[arrange];
        n = 0;
      }
      if (!checker) {
        break;
      }
    }
  }
  
  // vertical
  if (checker) {  
    for (int i = 0; i < col; i++) {
      for (int j = 0; j <= col - arrange; j++) {
        for (int k = j; k < j + arrange; k++) {
          identity[n] = newGrid[k][i];
          n++;
        }
        if (duplicate(identity)) {
          if (sum(identity) == arrange) {
            result = 1;
            checker = false;
            delayTime = true;
            identity = new int[arrange];
            carry = true;
            break;
          } else if (sum(identity) == 2 * arrange) {
            result = 2;
            checker = false;
            delayTime = true;
            identity = new int[arrange];
            carry = true;
            break;
          }
        }
        identity = new int[arrange];
        n = 0;
      }
      if (!checker) {
        break;
      }
    }
  }
  
  // left top to right bottom diagonal
  if (checker) {  
    for (int i = 0; i <= col - arrange; i++) {
      for (int j = i; j < i + arrange; j++) {
        identity[n] = newGrid[j][j];
        n++;
      }
      if (duplicate(identity)) {
        if (sum(identity) == arrange) {
          result = 1;
          checker = false;
          delayTime = true;
          identity = new int[arrange];
          carry = true;
        } else if (sum(identity) == 2 * arrange) {
          result = 2;
          checker = false;
          delayTime = true;
          identity = new int[arrange];
          carry = true;
        }
      }
      identity = new int[arrange];
      n = 0;
    }
  }
  
  // left bottom to right top diagonal
  if (checker) {
    for (int i = 0; i <= col - arrange; i++) {
      for (int j = i; j < i + arrange; j++) {
        identity[n] = newGrid[col - j - 1][j];
        n++;
      }
      if (duplicate(identity)) {
        if (sum(identity) == arrange) {
          result = 1;
          checker = false;
          delayTime = true;
          identity = new int[arrange];
          carry = true;
        } else if (sum(identity) == 2 * arrange) {
          result = 2;
          checker = false;
          delayTime = true;
          identity = new int[arrange];
          carry = true;
        }
      }
      identity = new int[arrange];
      n = 0;
    }
  }
  
  if (checker && full()) {
    result = 0;
    checker = false;
    delayTime = true;
    identity = new int[arrange];
    carry = true;
  }
}

void showResult() {
  if (delayTime) {
    if (result == 2) {
      symbol(width / 2, minWidth /2 + 80, 120, 2, #424242);
      fill(#00796B);
      textAlign(CENTER, TOP);
      textSize(60);
      text("WINNER!", width / 2 + 2, minWidth / 2 + 160);
      fill(255);
      text("WINNER!", width / 2, minWidth / 2 + 160);
      noFill();
      if (carry) {
        scoreX++;
        carry = false;
      }
    } else if (result == 1) {
      symbol(width / 2, minWidth / 2 + 80, 120, 1, #FFF8E1);
      fill(#00796B);
      textAlign(CENTER, TOP);
      textSize(60);
      text("WINNER!", width / 2 + 2, minWidth / 2 + 160 );
      fill(255);
      text("WINNER!", width / 2, minWidth / 2 + 160);
      noFill();
      if (carry) {
        scoreY++;
        carry = false;
      }
    } else {
      symbol(width / 2 - 70, minWidth / 2 + 80, 120, 2, #424242);
      symbol(width / 2 + 70, minWidth /2 + 80, 120, 1, #FFF8E1);
      fill(#00796B);
      textAlign(CENTER, TOP);
      textSize(60);
      text("DRAW!", width / 2 + 2, minWidth / 2 + 160 );
      fill(255);
      text("DRAW!", width / 2, minWidth / 2 + 160);
      noFill();
    }
    delay(500);
  }
}

int sum(int[] num) {
  int res = 0;
  for (int i : num) {
    res += i;
  }
  return res;
}

boolean duplicate(int[] num) {
  boolean res = true;
  for (int i : num) {
    if (i != num[0]) {
      res = false;
      break;
    }
  }
  return res;
}

boolean full() {
  int[] zero = new int[col * col];
  int n = 0;
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      if (newGrid[i][j] != 0) {
        zero[n] = 1;
      }
      n++;
    }
  }
  return (sum(zero) == col * col);
}

boolean empty() {
  int[] zero = new int[col * col];
  int n = 0;
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      if (newGrid[i][j] == 0) {
        zero[n] = 1;
      }
      n++;
    }
  }
  return (sum(zero) == col * col);
}