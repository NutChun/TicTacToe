int full, scoreX, scoreO; //<>//
int[][] table;
int turn = 1;
float tableArea, marginTop, marginLeft;
boolean result = false;
boolean carry = false;
boolean keep = true;

void setup() {
  size(500, 500);
  setTableSize(3);
  surface.setResizable(true);
}

void draw() {
  background(#00BFA5);
  fill(#ECEFF1);
  rect(0, 0, width, 100);

  strokeCap(PROJECT);
  stroke(#00796B);

  tableArea = min(width - 40, height - 190);

  marginTop = (height - 150 - tableArea) / 2 + 100;
  marginLeft = (width - tableArea) / 2;

  noFill();

  if (!result) {
    drawGrid();

    // Get the value of the index of the table to draw "X" or "O".
    for (int i = 0; i < getTableSize(); i++) {
      for (int j = 0; j < getTableSize(); j++) {
        drawOX_mark(getValue(i, j), 
          (tableArea * (2 * i + 1)) / ( 2 * getTableSize()), 
          (tableArea * (2 * j + 1)) / ( 2 * getTableSize()));
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
  noFill();
}

void mousePressed() {
  /* This function will call everytime the mouse has been press. */

  if (mouseButton == LEFT) {

    // Call onCellArea function
    if (getWinner() == 0) {
      onCellArea();
    }

    // Reset some value of variables to start a new game.
    String str = "NEW GAME";

    if (mouseX > (width - textWidth(str)) / 2 - 10 && 
      mouseX < (width + textWidth(str)) / 2 + 10 &&
      mouseY > height - 50 &&
      mouseY < height - 20) {
      setTableSize(getTableSize());
      result = false;
      full = 0;
      carry = false;
      keep = true;
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
  /* Draw the table grid line, both of horizontal and vertical line. */

  strokeWeight((2 * tableArea) / (25 * getTableSize()));

  // vertical grid line
  for (int i = 1; i < getTableSize(); i++) {
    line((i * tableArea) / getTableSize() + marginLeft, marginTop + (2 * tableArea) / (25 * getTableSize()), 
      (i * tableArea) / getTableSize() + marginLeft, marginTop + tableArea - (2 * tableArea) / (25 * getTableSize()));
  }

  // horizontal grid line
  for (int i = 1; i < getTableSize(); i++) {
    line(marginLeft + (2 * tableArea) / (25 * getTableSize()), (i * tableArea) / getTableSize() + marginTop, 
      marginLeft + tableArea - (2 * tableArea) / (25 * getTableSize()), (i * tableArea) / getTableSize() + marginTop);
  }
}

void onCellArea() {
  /* This function will assign new value to the table at the index 
   where the mouse has been clicked on its area and change the turn of the players
   if the value of the index is 0, if it's not, do nothing. 
   1 for "O" and 2 for "X". */

  for (int i = 0; i < getTableSize(); i++) {
    for (int j = 0; j < getTableSize(); j++) {
      if (mouseX > marginLeft + (i * tableArea) / getTableSize() &&
        mouseX < marginLeft + ((i + 1) * tableArea) / getTableSize() &&
        mouseY > marginTop + (j * tableArea) / getTableSize() &&
        mouseY < marginTop + ((j + 1) * tableArea) / getTableSize()) {
        if (getValue(i, j) == 0) {
          setValue(i, j, turn + 1);
          turn = 1 - turn;
          full++;
        }
      }
    }
  }
}

int getWinner() {
  /* Check the values that arrange in all row, 
   for horizontal, vertical, diagonal and otherwise case, respectively. */
  
  // horizontal and vertical
  for (int i = 0; i < getTableSize(); i++) {
    int sumHoriz = 0, sumVert = 0;
    for (int j = 0; j < getTableSize(); j++) {
      if (getValue(i, j) == getValue(i, 0)) {
        sumHoriz += getValue(i, j);
      }
      if (getValue(j, i) == getValue(0, i)) {
        sumVert += getValue(j, i);
      }
    }
    if ((sumHoriz == getTableSize()) || (sumVert == getTableSize())) {
      result = true;
      carry = true;
      return 1;
    } else if ((sumHoriz == 2 * getTableSize()) || (sumVert == 2 * getTableSize())) {
      result = true;
      carry = true;
      return 2;
    }
  }
  
  // diagonal
  int sumDiagonal1 = 0, sumDiagonal2 = 0;
  for (int i = 0; i < getTableSize(); i++) {
    if (getValue(i, i) == getValue(0, 0)) {
      sumDiagonal1 += getValue(i, i);
    }
    if (getValue(getTableSize() - i - 1, i) == getValue(getTableSize() - 1, 0)) {
      sumDiagonal2 += getValue(getTableSize() - i - 1, i);
    }
  }
  if ((sumDiagonal1 == getTableSize()) || (sumDiagonal2 == getTableSize())) {
    result = true;
    carry = true;
    return 1;
  } else if ((sumDiagonal1 == 2 * getTableSize()) || (sumDiagonal2 == 2 * getTableSize())) {
    result = true;
    carry = true;
    return 2;
  }

  // otherwise
  if (full == getTableSize() * getTableSize()) {
    result = true;
    carry = true;
    return 3;
  }
  
  return 0;
}

void showResult() {
  /* Display the result scene to show the players who the win is.
   1 for "O", 2 for "X" and otherwise for DRAW. */

  if (result) {
    if (getWinner() == 1) {
      symbol(width / 2, tableArea / 2 + 80, 120, 1, #FFF8E1);
      fill(#00796B);
      textAlign(CENTER, TOP);
      textSize(60);
      text("WINNER!", width / 2 + 2, tableArea / 2 + 160 );
      fill(255);
      text("WINNER!", width / 2, tableArea / 2 + 160);
      noFill();
      if (carry && keep) {
        scoreO++;
        keep = false;
      }
    } else if (getWinner() == 2) {
      symbol(width / 2, tableArea /2 + 80, 120, 2, #424242);
      fill(#00796B);
      textAlign(CENTER, TOP);
      textSize(60);
      text("WINNER!", width / 2 + 2, tableArea / 2 + 160);
      fill(255);
      text("WINNER!", width / 2, tableArea / 2 + 160);
      noFill();
      if (carry && keep) {
        scoreX++;
        keep = false;
      }
    } else if (getWinner() == 3) {
      symbol(width / 2 - 70, tableArea / 2 + 80, 120, 2, #424242);
      symbol(width / 2 + 70, tableArea /2 + 80, 120, 1, #FFF8E1);
      fill(#00796B);
      textAlign(CENTER, TOP);
      textSize(60);
      text("DRAW!", width / 2 + 2, tableArea / 2 + 160 );
      fill(255);
      text("DRAW!", width / 2, tableArea / 2 + 160);
      noFill();
    }
    delay(500);
  }
}

class Board {
  
}

class Controller {
  
}

class Display {
  
}