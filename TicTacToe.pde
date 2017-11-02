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

void setup() {
  fullScreen();
  //size(500, 500);
}

void draw() {
  background(#00BFA5);
  fill(255);
  rect(0, 0, width, 100);
  rect(0, height, width, -50);
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
  
  fill(255);
  textAlign(CENTER, BOTTOM);
  textSize(16);
  //textWeight()
  text("Tic-Tac-Toe", width/2, (height-300)/2-20);
  noFill();
  
  noStroke();
  //strokeWeight(1);
  fill(#00796B);
  String str = "NEW GAME";
  rect(width/2-((textWidth(str))/2 + 10) + 2, (height-300)/2+320 + 2, textWidth(str)+20 + 2, 30 + 2, 3);
  fill(255);
  rect(width/2-((textWidth(str))/2 + 10), (height-300)/2+320, textWidth(str)+20, 30, 3);
  fill(0);
  textAlign(CENTER, CENTER);
  text(str, width/2, (height-300)/2+320 + 15);
  noFill(); //<>//
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
        mouseY > (height-300)/2+320 &&
        mouseY < (height-300)/2+320 + 30) {
          newGrid = new int[col][row];
          num = 0;
          turn = 1;
          checker = true;
          delayTime = false;
          result = 0;
    }
  }
}

void symbol(float x, float y, int en, int type) {
  if (type == 0) {
    if (en != 0) {
      strokeWeight(8);
      strokeCap(PROJECT);
      stroke(#FFF8E1);
      ellipse(x, y, 50, 50);
    }
  } else {
    if (en != 0) {
      fill(0);
      strokeWeight(8);
      strokeCap(PROJECT);
      stroke(#424242);
      line(x-25,y-25,x+25,y+25);
      line(x-25,y+25,x+25,y-25);
    }
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
          break;
        } else if (sum(identity) == 2 * col) {
          result = 2;
          checker = false;
          delayTime = true;
          identity = new int[col];
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
          break;
        } else if (sum(identity) == 2 * col) {
          result = 2;
          checker = false;
          delayTime = true;
          identity = new int[col];
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
      } else if (sum(identity) == 2 * col) {
        result = 2;
        checker = false;
        delayTime = true;
        identity = new int[col];
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
      } else if (sum(identity) == 2 * col) {
        result = 2;
        checker = false;
        delayTime = true;
        identity = new int[col];
      }
    }
  }
  
  if (checker && full()) {
    result = 0;
    checker = false;
    delayTime = true;
    identity = new int[col];
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