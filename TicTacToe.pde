Board board; //<>//

void setup() {
  size(500, 500);
  background(#00BFA5);
  board = new Board();
  board.setTableSize(5);
  board.setGameCont(true);
  surface.setResizable(true);
}

void draw() {
  Display display = new Display(board);
  Controller ctrl = new Controller(board, display);

  background(#00BFA5);
  fill(#ECEFF1);
  noStroke();
  rect(0, 0, width, 100);

  if (board.getGameCont()) {
    display.drawGrid();
    for (int i = 0; i < board.getTableSize(); i++) {
      for (int j = 0; j < board.getTableSize(); j++) {
        display.drawOX_mark(board.getValue(i, j), 
          (board.getTableArea() * (2 * i + 1)) / ( 2 * board.getTableSize()), 
          (board.getTableArea() * (2 * j + 1)) / ( 2 * board.getTableSize()));
      }
    }
  }

  display.showResult();
  ctrl.mouseClicked();

  noStroke();
  textSize(30);

  // Display "X" and "O" buttons.
  display.buttonOX();

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

class Board {
  int[][] board;
  int turn, full, scoreX, scoreO;
  float tableArea, marginTop, marginLeft;
  boolean gameCont, adder;

  Board() {
    turn = 1;
    full = 0;
    scoreX = 0;
    scoreO = 0;
    adder = true;
    tableArea = abs(min(width - 40, height - 190));
    marginTop = abs((height - 150 - tableArea) / 2 + 100);
    marginLeft = abs((width - tableArea) / 2);
  }

  void setTableSize(int size) {
    board = new int[size][size];
  }

  void setValue(int i, int j, int val) {
    board[i][j] = val;
  }

  void setTurn(int val) {
    turn = val;
  }
  
  void setGameCont(boolean b) {
    gameCont = b;
  }
  
  void addFull() {
    full++;
  }
  
  void addScoreX() {
    if (adder) {
      scoreX++;
      adder = false;
    }
  }
  
  void addScoreO() {
    if (adder) {
      scoreO++;
      adder = false;
    }
  }

  int getTableSize() {
    return board.length;
  }

  int getValue(int i, int j) {
    return board[i][j];
  }

  int getTurn() {
    return turn;
  }
  
  int getScoreX() {
    return scoreX;
  }
  
  int getScoreO() {
    return scoreO;
  }

  boolean getGameCont() {
    return gameCont;
  }
  
  int getFull() {
    return full;
  }

  float getTableArea() {
    return tableArea;
  }

  float getMarginLeft() { 
    return marginLeft;
  }

  float getMarginTop() { 
    return marginTop;
  }

  int getWinner() {
    /*
     * Check the values that arrange in all row, for horizontal, vertical, diagonal
     * and otherwise case, respectively.
     */

    int size = getTableSize();

    // horizontal and vertical
    for (int i = 0; i < size; i++) {
      int sumHoriz = 0, sumVert = 0;
      for (int j = 0; j < size; j++) {
        if (getValue(i, j) != getValue(i, 0)) {
          sumHoriz = 0;
          break;
        } else {
          sumHoriz += getValue(i, j);
        }
      }
      for (int j = 0; j < size; j++) {
        if (getValue(j, i) != getValue(0, i)) {
          sumVert = 0;
          break;
        } else {
          sumVert += getValue(j, i);
        }
      }
      if ((sumHoriz == size) || (sumVert == size)) {
        setGameCont(false);
        return 1;
      } else if ((sumHoriz == 2 * size) || (sumVert == 2 * size)) {
        setGameCont(false);
        return 2;
      }
    }

    // diagonal
    int sumDiagonal1 = 0, sumDiagonal2 = 0;
    for (int i = 0; i < size; i++) {
      if (getValue(i, i) != getValue(0, 0)) {
        sumDiagonal1 = 0;
        break;
      } else {
        sumDiagonal1 += getValue(i, i);
      }
    }
    for (int i = 0; i < size; i++) {
      if (getValue(size - i - 1, i) != getValue(size - 1, 0)) {
        sumDiagonal2 = 0;
        break;
      } else {
        sumDiagonal2 += getValue(size - i - 1, i);
      }
    }
    if ((sumDiagonal1 == size) || (sumDiagonal2 == size)) {
      setGameCont(false);
      return 1;
    } else if ((sumDiagonal1 == 2 * size) || (sumDiagonal2 == 2 * size)) {
      setGameCont(false);
      return 2;
    }

    // otherwise
    if (full == size * size) {
      setGameCont(false);
      return 3;
    }

    return 0;
  }
  
  void resetFull() {
    full = 0;
  }
  
  void resetAdder() {
    adder = true;
  }
}

class Controller {
  Board board;
  Display display;
  float tableArea;
  float marginLeft;
  float marginTop;

  public Controller(Board board, Display display) {
    this.board = board;
    this.display = display;
    tableArea = board.getTableArea();
    marginLeft = board.getMarginLeft();
    marginTop = board.getMarginTop();
  }

  void mouseClicked() {
    /* This function will assign new value to the table at the index 
     where the mouse has been clicked on its area and change the turn of the players
     if the value of the index is 0, if it's not, do nothing. 
     1 for "O" and 2 for "X". */

    if (mouseButton == LEFT) {
      if (board.getWinner() == 0) {
        for (int i = 0; i < board.getTableSize(); i++) {
          for (int j = 0; j < board.getTableSize(); j++) {
            if (mouseX > marginLeft + (i * tableArea) / board.getTableSize() &&
              mouseX < marginLeft + ((i + 1) * tableArea) / board.getTableSize() &&
              mouseY > marginTop + (j * tableArea) / board.getTableSize() &&
              mouseY < marginTop + ((j + 1) * tableArea) / board.getTableSize()) {
              if (board.getValue(i, j) == 0) {
                board.setValue(i, j, board.getTurn() + 1);
                board.setTurn(1 - board.getTurn());
                board.addFull();
              }
            }
          }
        }
      }

      // Reset all values of variable to start a new game.
      String str = "NEW GAME";

      if (mouseX > (width - textWidth(str)) / 2 - 10 && 
        mouseX < (width + textWidth(str)) / 2 + 10 &&
        mouseY > height - 50 &&
        mouseY < height - 20) {
        board.setTableSize(board.getTableSize());
        board.setGameCont(true);
        board.resetAdder();
        board.resetFull();
      }

      // Switch between "X" and "O" buttons.
      if (mouseX > width - 165 &&
        mouseX < width - 165 + 150 &&
        mouseY > 25 && mouseY < 75 &&
        board.getTurn() == 1 && board.getFull() == 0) {
        board.setTurn(0);
      } else if (mouseX > 15 &&
        mouseX < 15 + 150 &&
        mouseY > 25 && mouseY < 75 &&
        board.getTurn() == 0 && board.getFull() == 0) {
        board.setTurn(1);
      }
    }
  }
}

class Display {
  Board board;
  float tableArea;
  float marginLeft;
  float marginTop;

  public Display(Board table) {
    this.board = table;
    this.tableArea = board.getTableArea();
    this.marginLeft = board.getMarginLeft();
    this.marginTop = board.getMarginTop();
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

  void buttonOX() {
    if (board.getTurn() == 1) {
      fill(#00796B);
      rect(15, 28, 150, 50, 35);
      fill(#ECEFF1);
      rect(width - 165, 28, 150, 50, 35);
    } else if (board.getTurn() == 0) {
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
    text(board.getScoreX(), 145, 45);
    text(board.getScoreO(), width - 35, 45);
  }

  void drawGrid() {
    /* Draw the table grid line, both of horizontal and vertical line. */

    stroke(#00796B);
    strokeCap(PROJECT);
    strokeWeight((2 * tableArea) / (25 * board.getTableSize()));

    // vertical grid line
    for (int i = 1; i < board.getTableSize(); i++) {
      line((i * tableArea) / board.getTableSize() + marginLeft, marginTop + (2 *tableArea) / (25 * board.getTableSize()), 
        (i * tableArea) / board.getTableSize() + marginLeft, marginTop + tableArea - (2 * tableArea) / (25 * board.getTableSize()));
    }

    // horizontal grid line
    for (int i = 1; i < board.getTableSize(); i++) {
      line(marginLeft + (2 * tableArea) / (25 * board.getTableSize()), (i * tableArea) / board.getTableSize() + marginTop, 
        marginLeft + tableArea - (2 * tableArea) / (25 * board.getTableSize()), (i * tableArea) / board.getTableSize() + marginTop);
    }
  }

  void drawOX_mark(int select, float xPos, float yPos) {
    /* Draw the symbols ("X" or "O") in the table area. */

    float size = tableArea / (board.getTableSize() * 2);
    strokeWeight((2 * tableArea) / (25 * board.getTableSize()));
    strokeCap(PROJECT);
    noFill();
    if (select == 1) {
      stroke(#FFF8E1);
      ellipse(marginLeft + xPos, marginTop + yPos, tableArea / (board.getTableSize() * 2), tableArea / (board.getTableSize() * 2));
    } else if (select == 2) {
      stroke(#424242);
      line(marginLeft + xPos - size / 2, marginTop + yPos - size / 2, 
        marginLeft + xPos + size / 2, marginTop + yPos + size / 2);
      line(marginLeft + xPos - size / 2, marginTop + yPos + size / 2, 
        marginLeft + xPos + size / 2, marginTop + yPos - size / 2);
    }
  }

  void showResult() {
    /* Display the result scene to show the players who the win is.
     1 for "O", 2 for "X" and otherwise for DRAW. */

    noFill();
    if (!board.getGameCont()) {
      //fill(#00BFA5);
      //noStroke();
      //rect(0, 100, width, height - 100);
      //noFill();
      if (board.getWinner() == 1) {
        symbol(width / 2, tableArea / 2 + 80, 120, 1, #FFF8E1);
        fill(#00796B);
        textAlign(CENTER, TOP);
        textSize(60);
        text("WINNER!", width / 2 + 2, tableArea / 2 + 160 );
        fill(255);
        text("WINNER!", width / 2, tableArea / 2 + 160);
        noFill();
        board.addScoreO();
      } else if (board.getWinner() == 2) {
        symbol(width / 2, tableArea /2 + 80, 120, 2, #424242);
        fill(#00796B);
        textAlign(CENTER, TOP);
        textSize(60);
        text("WINNER!", width / 2 + 2, tableArea / 2 + 160);
        fill(255);
        text("WINNER!", width / 2, tableArea / 2 + 160);
        noFill();
        board.addScoreX();
      } else if (board.getWinner() == 3) {
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
}