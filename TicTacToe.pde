int col = 5;
int arrange = 5;
int[][] board = new int[col][col];
int turn = 1;
int result = 0;
boolean checker = true;
boolean delayTime = false;
float boardArea, marginTop, marginLeft;
int scoreX = 0, scoreY = 0;
boolean carry = false;
float x = 150, y = 150;
float easing = 0.15;

void setup() {
  size(500, 500);
  //fullScreen();
  surface.setResizable(true);
}

void draw() {
  background(#00BFA5);
  fill(#ECEFF1);
  rect(0, 0, width, 100);
  
  strokeCap(PROJECT);
  stroke(#00796B);
  
  boardArea = abs(min(width - 40 ,height - 190));
  
  marginTop = (height - 150 - boardArea) / 2 + 100;
  marginLeft = (width - boardArea) / 2;
  
  noFill();
  
  if (checker) {
    drawGrid();
    
    for (int i = 0; i < col; i++) {
      for (int j = 0; j < col; j++) {
        symbol((boardArea * (2 * i + 1)) / ( 2 * col),
            (boardArea * (2 * j + 1)) / ( 2 * col),
            board[i][j]);
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
      onCellArea();
    }
    
    String str = "NEW GAME";
    
    if (mouseX > (width - textWidth(str)) / 2 - 10 && 
        mouseX < (width + textWidth(str)) / 2 + 10 &&
        mouseY > height - 50 &&
        mouseY < height - 20) {
          board = new int[col][col];
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

void drawGrid() {
  strokeWeight((2 * boardArea) / (25 * col));
  
  // vertical grid line
  for (int i = 1; i < col; i++) {
    line((i * boardArea) / col + marginLeft, marginTop + (2 * boardArea) / (25 * col), 
        (i * boardArea) / col + marginLeft, marginTop + boardArea - (2 * boardArea) / (25 * col));
  }
  
  // horizontal grid line
  for (int i = 1; i < col; i++) {
    line(marginLeft + (2 * boardArea) / (25 * col), (i * boardArea) / col + marginTop, 
        marginLeft + boardArea - (2 * boardArea) / (25 * col), (i * boardArea) / col + marginTop);
  }
}

void onCellArea() {
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      if (mouseX > marginLeft + (i * boardArea) / col &&
          mouseX < marginLeft + ((i + 1) * boardArea) / col &&
          mouseY > marginTop + (j * boardArea) / col &&
          mouseY < marginTop + ((j + 1) * boardArea) / col) {
        if (board[i][j] == 0) {
          board[i][j] = turn + 1;
          turn = 1 - turn;
        }
      }
    }
  }
}

void duplicateChecker() {
  // horizontal
  horizontalArrange(board);
  
  // vertical
  horizontalArrange(inverseGrid(board));
  
  // diagonal
  diagonalArrange(board);
  diagonalArrange(inverseGrid(board));
  diagonalArrange(reflectGrid(board));
  diagonalArrange(inverseGrid(reflectGrid(board)));
  
  // otherwise
  if (checker && full()) {
    result = 0;
    checker = false;
    delayTime = true;
    carry = true;
  }
}

void showResult() {
  if (delayTime) {
    if (result == 2) {
      symbol(width / 2, boardArea /2 + 80, 120, 2, #424242);
      fill(#00796B);
      textAlign(CENTER, TOP);
      textSize(60);
      text("WINNER!", width / 2 + 2, boardArea / 2 + 160);
      fill(255);
      text("WINNER!", width / 2, boardArea / 2 + 160);
      noFill();
      if (carry) {
        scoreX++;
        carry = false;
      }
    } else if (result == 1) {
      symbol(width / 2, boardArea / 2 + 80, 120, 1, #FFF8E1);
      fill(#00796B);
      textAlign(CENTER, TOP);
      textSize(60);
      text("WINNER!", width / 2 + 2, boardArea / 2 + 160 );
      fill(255);
      text("WINNER!", width / 2, boardArea / 2 + 160);
      noFill();
      if (carry) {
        scoreY++;
        carry = false;
      }
    } else {
      symbol(width / 2 - 70, boardArea / 2 + 80, 120, 2, #424242);
      symbol(width / 2 + 70, boardArea /2 + 80, 120, 1, #FFF8E1);
      fill(#00796B);
      textAlign(CENTER, TOP);
      textSize(60);
      text("DRAW!", width / 2 + 2, boardArea / 2 + 160 );
      fill(255);
      text("DRAW!", width / 2, boardArea / 2 + 160);
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
  for (int i : num) {
    if (i != num[0]) {
      return false;
    }
  }
  return true;
}

boolean full() {
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      if (board[i][j] == 0) {
        return false;
      }
    }
  }
  return true;
}

boolean empty() {
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      if (board[i][j] != 0) {
        return false;
      }
    }
  }
  return true;
}