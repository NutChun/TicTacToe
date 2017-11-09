int col, scene, result, full, scoreX, scoreY; //<>//
int[][] board;
int turn = 1;
float boardArea, marginTop, marginLeft;
boolean delayTime = false;
boolean carry = false;

void setup() {
  size(500, 500);
  setTableSize(3);
  board = new int[col][col];
  surface.setResizable(true);
}

void draw() { //<>//
  background(#00BFA5);
  fill(#ECEFF1);
  rect(0, 0, width, 100);

  strokeCap(PROJECT);
  stroke(#00796B);

  boardArea = min(width - 40, height - 190);

  marginTop = (height - 150 - boardArea) / 2 + 100;
  marginLeft = (width - boardArea) / 2;

  noFill();

  if (scene == 0) {
    drawGrid();

    // Get the value of the index of the board to draw "X" or "O".
    for (int i = 0; i < col; i++) {
      for (int j = 0; j < col; j++) {
        drawOX_mark(board[i][j], 
          (boardArea * (2 * i + 1)) / ( 2 * col), 
          (boardArea * (2 * j + 1)) / ( 2 * col));
      }
    }
  }

  showResult();
  getWinner();

  noStroke();
  textSize(30);

  // Display "X" and "O" buttons.
  buttonOX();

  fill(255);
  textAlign(CENTER, BOTTOM);
  textSize(16);

  noFill();
  noStroke();

  // "NEW GAME" button.
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
  /* This function will call everytime the mouse has been press. */

  if (mouseButton == LEFT) {

    // Call onCellArea function
    if (scene == 0) {
      onCellArea();
    }

    // Reset some value of variables to start a new game.
    String str = "NEW GAME";

    if (mouseX > (width - textWidth(str)) / 2 - 10 && 
      mouseX < (width + textWidth(str)) / 2 + 10 &&
      mouseY > height - 50 &&
      mouseY < height - 20) {
      board = new int[col][col];
      scene = 0;
      delayTime = false;
      result = 0;
      full = 0;
    }

    // Switch between "X" and "O" buttons.
    if (mouseX > width - 165 &&
      mouseX < width - 165 + 150 &&
      mouseY > 25 && mouseY < 75 &&
      turn == 1 && full == 0) {
      turn = 0;
    } else if (mouseX > 15 &&
      mouseX < 15 + 150 &&
      mouseY > 25 && mouseY < 75 &&
      turn == 0 && full == 0) {
      turn = 1;
    }
  }
}

void drawGrid() {
  /* Draw the board grid line, both of horizontal and vertical line. */

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
  /* This function will assign new value to the board at the index 
   where the mouse has been clicked on its area and change the turn of the players
   if the value of the index is 0, if it's not, do nothing. 
   1 for "O" and 2 for "X". */

  for (int i = 0; i < col; i++) {
    for (int j = 0; j < col; j++) {
      if (mouseX > marginLeft + (i * boardArea) / col &&
        mouseX < marginLeft + ((i + 1) * boardArea) / col &&
        mouseY > marginTop + (j * boardArea) / col &&
        mouseY < marginTop + ((j + 1) * boardArea) / col) {
        if (board[i][j] == 0) {
          board[i][j] = turn + 1;
          turn = 1 - turn;
          full++;
        }
      }
    }
  }
}

void getWinner() {
  /* Check the values that arrange in all row, 
   for horizontal, vertical, diagonal and otherwise case, respectively. */
  
  // horizontal and vertical
  if (scene == 0) {
    for (int i = 0; i < col; i++) {
      int sumHoriz = 0;
      int sumVert = 0;
      for (int j = 0; j < col; j++) {
        if (board[i][j] == board[i][0]) {
          sumHoriz += board[i][j];
        }
        if (board[j][i] == board[0][i]) {
          sumVert += board[j][i];
        }
      }
      if (sumHoriz == col || sumVert == col) {
        result = 1;
        scene = 1;
        delayTime = true;
        carry = true;
        break;
      } else if (sumHoriz == 2 * col || sumVert == 2 * col) {
        result = 2;
        scene = 1;
        delayTime = true;
        carry = true;
        break;
      }
    }
  }
  
  // diagonal
  if (scene == 0) {  
    int sumDiagonal1 = 0;
    int sumDiagonal2 = 0;
    
    for (int i = 0; i < col; i++) {
      if (board[i][i] == board[0][0]) {
        sumDiagonal1 += board[i][i];
      }
      if (board[col - i - 1][i] == board[col - 1][0]) {
        sumDiagonal2 += board[col - i - 1][i];
      }
    }
    if (sumDiagonal1 == col || sumDiagonal2 == col) {
      result = 1;
      scene = 1;
      delayTime = true;
      carry = true;
    } else if (sumDiagonal1 == 2 * col || sumDiagonal2 == 2 * col) {
      result = 2;
      scene = 1;
      delayTime = true;
      carry = true;
    }
  }

  // otherwise
  if (scene == 0 && full == col * col) {
    result = 0;
    scene = 1;
    delayTime = true;
    carry = true;
  }
}

void showResult() {
  /* Display the result scene to show the players who the win is.
   1 for "O", 2 for "X" and otherwise for DRAW. */

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