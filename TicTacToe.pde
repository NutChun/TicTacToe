Board board = new Board(); //<>//
Display display = new Display();
Controller ctrl = new Controller();
boolean result = false, adder = true;
float tableArea, marginTop, marginLeft;
int scoreX, scoreO, full;

void setup() {
  size(500, 500);
  board.setTableSize(5);
  surface.setResizable(true);
}

void draw() {
  background(#00BFA5);
  fill(#ECEFF1);
  noStroke();
  rect(0, 0, width, 100);
  
  tableArea = min(width - 40, height - 190);
  marginTop = (height - 150 - tableArea) / 2 + 100;
  marginLeft = (width - tableArea) / 2;
  
  if (!result) {
    display.drawGrid();
    
    // Get the value of the index of the table to draw "X" or "O".
    for (int i = 0; i < board.getTableSize(); i++) {
      for (int j = 0; j < board.getTableSize(); j++) {
        display.drawOX_mark(board.getValue(i, j), 
          (tableArea * (2 * i + 1)) / ( 2 * board.getTableSize()), 
          (tableArea * (2 * j + 1)) / ( 2 * board.getTableSize()));
      }
    }
  }
  
  display.showResult();
  display.getWinner();

  noStroke();
  textSize(30);

  // Display "X" and "O" buttons.
  ctrl.buttonOX();

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
    if (display.getWinner() == 0) {
      ctrl.onCellArea();
    }
    
    // Reset some value of variables to start a new game.
    String str = "NEW GAME";

    if (mouseX > (width - textWidth(str)) / 2 - 10 && 
      mouseX < (width + textWidth(str)) / 2 + 10 &&
      mouseY > height - 50 &&
      mouseY < height - 20) {
      board.setTableSize(board.getTableSize());
      result = false;
      adder = true;
      full = 0;
    }
    
    // Switch between "X" and "O" buttons.
    if (mouseX > width - 165 &&
      mouseX < width - 165 + 150 &&
      mouseY > 25 && mouseY < 75 &&
      board.getTurn() == 1 && full == 0) {
      board.setTurn(0);
    } else if (mouseX > 15 &&
      mouseX < 15 + 150 &&
      mouseY > 25 && mouseY < 75 &&
      board.getTurn() == 0 && full == 0) {
      board.setTurn(1);
    }
  }
}

class Board {
  int[][] board;
  int turn = 1;

  void setTableSize(int size) {
    board = new int[size][size];
  }

  void setValue(int i, int j, int val) {
    board[i][j] = val;
  }
  
  void setTurn(int val) {
    turn = val;
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
}

class Controller {
  
}

class Display {
  
}