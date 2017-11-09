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

void drawOX_mark(int select, float xPos, float yPos) {
  /* Draw the symbols ("X" or "O") in the board area. */
  
  float size = boardArea / (col * 2);
  strokeWeight((2 * boardArea) / (25 * col));
  strokeCap(PROJECT);
  if (select == 1) {
    stroke(#FFF8E1);
    ellipse(marginLeft + xPos, marginTop + yPos, boardArea / (col * 2), boardArea / (col * 2));
  } else if (select == 2) {
    stroke(#424242);
    line(marginLeft + xPos - size / 2, marginTop + yPos - size / 2, 
        marginLeft + xPos + size / 2, marginTop + yPos + size / 2);
    line(marginLeft + xPos - size / 2, marginTop + yPos + size / 2, 
        marginLeft + xPos + size / 2, marginTop + yPos - size / 2);
  }
}

void buttonOX() {
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
}