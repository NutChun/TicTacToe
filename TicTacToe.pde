int value = 0;
int[] en = new int[9];
int[] type = new int[9];
int col = 3;
int row = 3;
int[][] newGrid = new int[col][row];
float padLeft = 0;
float padTop = 0;
int turn = 1;
int num = 0;
boolean checker = true;
boolean delayTime = false;
int result = 0;
float minWidth;
float gridSize;
float margin;
int scoreX = 0, scoreY = 0;
boolean carry = false;

void setup() {
  //fullScreen();
  size(500, 500);
}

void draw() {
  background(#00BFA5);
  fill(#ECEFF1);
  rect(0, 0, width, 100);
  //rect(0, height, width, -50);
  fill(255);
  //rect(20, 20, width-40, 50);
  noFill();
  strokeWeight(8);
  strokeCap(PROJECT);
  stroke(#00796B);
  
  minWidth = min(width - 40 ,height - 40 - 150);
  
  gridSize = (100 + 20);
  margin = (width-minWidth)/2;
  
  if (checker) {
    drawGrid();
    strokeWeight(8);
  }
  
  padLeft = (width-300)/2; 
  padTop = (height-300)/2;

  if (checker) {
    for (int i = 0; i < col; i++) {
      for (int j = 0; j < row; j++) {
        symbol((minWidth * (2 * i + 1)) / ( 2 * col),
            (minWidth * (2 * j + 1)) / ( 2 * row),
            newGrid[i][j]);
      }
    }
  }
  
  showResult();
  
  textSize(10.5);
  
  fill(255);
  textSize(30);
  
  duplicateChecker();
  noStroke();
  fill(#00796B);
  //rect(10, 20, 150, 60, 30);
  //rect(width - 160, 20, 150, 60, 30);
  fill(255);
  rect(15, 25, 150, 50, 35);
  rect(width - 165, 25, 150, 50, 35);
  symbol(45, 50, 20, 2, #424242);
  symbol(width - 165 + 35, 50, 20, 1, #424242);
  
  fill(255);
  textAlign(CENTER, BOTTOM);
  textSize(16);
  //textWeight()
  //text("Tic-Tac-Toe", width/2, (height-300)/2-20);
  noFill();
  
  noStroke();
  //strokeWeight(1);
  String str = "NEW GAME";
  fill(#00796B);
  rect(width/2-((textWidth(str))/2 + 10) + 3, (height-50)+25-15+3, textWidth(str)+20, 30, 3);
  if (mousePressed &&
      mouseX > width/2-((textWidth(str))/2+10) && 
      mouseX < width/2-((textWidth(str))/2+10)+textWidth(str)+20 &&
      mouseY > (height-50)+25-15 &&
      mouseY < (height-50)+25-15 + 30) {
    fill(255);
    rect(width/2-((textWidth(str))/2 + 10) + 3, (height-50)+25-15+3, textWidth(str)+20, 30, 3);
    fill(0);
    textAlign(CENTER, CENTER);
    text(str, width/2 + 3, (height-50)+25 + 3);
    noFill();
    newGrid = new int[col][row];
    num = 0;
    turn = 1;
    checker = true;
    delayTime = false;
    result = 0;
  }  else {
    fill(255);
    rect(width/2-((textWidth(str))/2 + 10), (height-50)+25-15, textWidth(str)+20, 30, 3);
    fill(0);
    textAlign(CENTER, CENTER);
    text(str, width/2, (height-50)+25);
    noFill();
  }
  //fill(255);
  //rect(width/2-((textWidth(str))/2 + 10), (height-50)+25-15, textWidth(str)+20, 30, 3);
  //fill(0);
  //textAlign(CENTER, CENTER);
  //text(str, width/2, (height-50)+25);
  //noFill(); //<>//
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (checker) {
      cellArea();
    } else {
      if (mouseX > padLeft && mouseX < padLeft + 300 &&
          mouseY > padTop && mouseY < padTop + 300) {
        //en = new int[9];
        //type = new int[9];
        //num = 0;
        //turn = 1;
        //checker = true;
        //delayTime = false;
        //result = "";
      }
    }
    String str = "NEW GAME";
    if (mouseX > width/2-((textWidth(str))/2+10) && 
        mouseX < width/2-((textWidth(str))/2+10)+textWidth(str)+20 &&
        mouseY > (height-50)+25-15 &&
        mouseY < (height-50)+25-15 + 30) {
          newGrid = new int[col][row];
          num = 0;
          turn = 1;
          checker = true;
          delayTime = false;
          result = 0;
    }
  }
}

void symbol(float x, float y, float size, int type, int colour) {
  strokeWeight((8 * size) / 50);
  strokeCap(PROJECT);
  if (type == 1) {
    //stroke(#FFF8E1);
    stroke(colour);
    ellipse(x, y, size + (8 * size) / 25, size + (8 * size) / 25);
  } else if (type == 2) {
    fill(0);
    //stroke(#424242);
    stroke(colour);
    line(x - size / 2, y - size / 2, x + size / 2, y + size / 2);
    line(x - size / 2, y + size / 2, x + size / 2, y - size / 2);
  }
  noFill();
}

void symbol(float x, float y, int type) {
  float sSize = minWidth / (col * 2);
  if (type == 1) {
    strokeWeight((2 * minWidth) / (25 * col));
    strokeCap(PROJECT);
    stroke(#FFF8E1);
    ellipse(margin + x, gridSize + y, minWidth / (col * 2), minWidth / (col * 2));
  } else if (type == 2) {
    fill(0);
    strokeWeight((2 * minWidth) / (25 * col));
    strokeCap(PROJECT);
    stroke(#424242);
    line(margin + x - sSize / 2, gridSize + y - sSize / 2, margin + x + sSize / 2, gridSize + y + sSize / 2);
    line(margin + x - sSize / 2, gridSize + y + sSize / 2, margin + x + sSize / 2, gridSize + y - sSize / 2);
  }
  noFill();
}

int sum(int[] num) {
  int res = 0;
  for (int i : num) {
    res += i;
  }
  return res;
}

void drawGrid() {
  strokeWeight((2 * minWidth) / (25 * col));
  // vertical grid line
  for (int i = 1; i < col; i++) {
    line((i * minWidth) / col + margin, gridSize + 8, (i * minWidth) / col + margin, gridSize + minWidth - 8);
  }
  
  // horizontal grid line
  for (int i = 1; i < row; i++) {
    line(margin + 8, (i * minWidth) / row + gridSize, margin + minWidth - 8, (i * minWidth) / row + gridSize);
  }
}

void cellArea() {
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < row; j++) {
      //float cellX = (i * minWidth) / col;
      //float cellY = (j * minWidth) / row;
      if (mouseX > margin + (i * minWidth) / col &&
          mouseX < margin + ((i + 1) * minWidth) / col &&
          mouseY > gridSize + (j * minWidth) / row &&
          mouseY < gridSize + ((j + 1) * minWidth) / row) {
        if (newGrid[i][j] == 0) {
          newGrid[i][j] = turn + 1;
          turn = 1 - turn;
        }
      }
    }
  }
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

void duplicateChecker() {
  int[] identity = new int[col];
  if (checker) {
    for (int i = 0; i < col; i++) {
      for (int j = 0; j < col; j++) {
        identity[j] = newGrid[i][j];
      }
      if (duplicate(identity)) {
        if (sum(identity) == col) {
          result = 1;
          checker = false;
          delayTime = true;
          identity = new int[col];
          carry = true;
          break;
        } else if (sum(identity) == 2 * col) {
          result = 2;
          checker = false;
          delayTime = true;
          identity = new int[col];
          carry = true;
          break;
        }
      }
    }
  }
  
  if (checker) {  
    for (int i = 0; i < col; i ++) {
      for (int j = 0; j < col; j++) {
        identity[j] = newGrid[j][i];
      }
      if (duplicate(identity)) {
        if (sum(identity) == col) {
          result = 1;
          checker = false;
          delayTime = true;
          identity = new int[col];
          carry = true;
          break;
        } else if (sum(identity) == 2 * col) {
          result = 2;
          checker = false;
          delayTime = true;
          identity = new int[col];
          carry = true;
          break;
        }
      }
    }
  }
  
  if (checker) {  
    for (int i = 0; i < col; i++) {
      identity[i] = newGrid[i][i];
    }
    if (duplicate(identity)) {
      if (sum(identity) == col) {
        result = 1;
        checker = false;
        delayTime = true;
        identity = new int[col];
        carry = true;
      } else if (sum(identity) == 2 * col) {
        result = 2;
        checker = false;
        delayTime = true;
        identity = new int[col];
        carry = true;
      }
    }
  }
  
  if (checker) {
    for (int i = 0; i < col; i++) {
      identity[i] = newGrid[col - i - 1][i];
    }
    if (duplicate(identity)) {
      if (sum(identity) == col) {
        result = 1;
        checker = false;
        delayTime = true;
        identity = new int[col];
        carry = true;
      } else if (sum(identity) == 2 * col) {
        result = 2;
        checker = false;
        delayTime = true;
        identity = new int[col];
        carry = true;
      }
    }
  }
  
  if (checker && full()) {
    result = 0;
    checker = false;
    delayTime = true;
    identity = new int[col];
    carry = true;
  }
}

void showResult() {
  if (delayTime) {
    if (result == 2) {
      strokeWeight(19.2);
      strokeCap(PROJECT);
      stroke(#424242);
      line(width/2-60,padTop+19.2+20,width/2+60,padTop+120+19.2+20);
      line(width/2-60,padTop+120+19.2+20,width/2+60,padTop+19.2+20);
      fill(#00796B);
      textAlign(CENTER, BOTTOM);
      textSize(60);
      text("WINNER!", width/2+2, padTop+300+2-20);
      fill(255);
      text("WINNER!", width/2, padTop+300-20);
      noFill();
      if (carry) {
        scoreX++;
        carry = false;
      }
    } else if (result == 1) {
      strokeWeight(19.2);
      strokeCap(PROJECT);
      stroke(#FFF8E1);
      ellipse(width/2, padTop+60+19.2+20, 120, 120);
      fill(#00796B);
      textAlign(CENTER, BOTTOM);
      textSize(60);
      text("WINNER!", width/2+2, padTop+300+2-20);
      fill(255);
      text("WINNER!", width/2, padTop+300-20);
      noFill();
      if (carry) {
        scoreY++;
        carry = false;
      }
    } else {
      strokeWeight(19.2);
      strokeCap(PROJECT);
      stroke(#424242);
      line(width/2-120-15,padTop+19.2+20,width/2-15,padTop+120+19.2+20);
      line(width/2-120-15,padTop+120+19.2+20,width/2-15,padTop+19.2+20);
      stroke(#FFF8E1);
      ellipse(width/2+19.2+15+60, padTop+60+19.2+20, 120, 120);
      fill(#00796B);
      textAlign(CENTER, BOTTOM);
      textSize(60);
      text("DRAW!", width/2+2, padTop+300+2-20);
      fill(255);
      text("DRAW!", width/2, padTop+300-20);
      noFill();
    }
    delay(500);
  }
}

void button(String str, float xPos, float yPos, float fontSize) {
  noStroke();
  //strokeWeight(1);
  fill(#00796B);
  //String str = "NEW GAME";
  rect(width/2-((textWidth(str))/2 + 10) + 2, (height-300)/2+320 + 2, textWidth(str)+20 + 2, 30 + 2, 3);
  fill(255);
  rect(width/2-((textWidth(str))/2 + 10), (height-300)/2+320, textWidth(str)+20, 30, 3);
  fill(0);
  textAlign(CENTER, CENTER);
  text(str, width/2, (height-300)/2+320 + 15);
  noFill();
}