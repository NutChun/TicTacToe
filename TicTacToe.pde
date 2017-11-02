int value = 0;
int[] en = new int[9];
int[] type = new int[9];
int col = 4;
int row = 3;
int[][] newGrid = new int[col][row];
float padLeft = 0;
float padTop = 0;
int turn = 1;
int num = 0;
boolean checker = true;
boolean delayTime = false;
String result = "";
float minWidth;


void setup() {
  fullScreen();
  //size(500, 500);
}

void draw() {
  background(#00BFA5);
  fill(255);
  //rect(20, 20, width-40, 50);
  noFill();
  strokeWeight(8);
  strokeCap(PROJECT);
  stroke(#00796B);
  
  minWidth = min(width-40,height-40);
  
  float gridSize = (height - minWidth) / 2;
  float margin = (width-minWidth)/2;
  
  if (checker) {
//    line(100 + (width - 300) / 2, (height - 300) / 2 + 10, 100 + (width - 300) / 2, 300 + (height - 300) / 2 - 10);
//    line(200 + (width - 300) / 2, (height - 300) / 2 + 10, 200 + (width - 300) / 2, 300 + (height - 300) / 2 - 10);
//    line((width - 300) / 2 + 10, 100 + (height - 300) / 2, 300 + (width - 300) / 2 - 10, 100 + (height - 300) / 2);
//    line((width - 300) / 2 + 10, 200 + (height - 300) / 2, 300 + (width - 300) / 2 - 10, 200 + (height - 300) / 2);
    // vert
    line(margin+minWidth / col, gridSize + 8, margin+minWidth / col, gridSize + minWidth - 8);
    line(2 * minWidth / col + margin, gridSize + 8, 2 * minWidth / col + margin, gridSize + minWidth - 8);
    // horiz
    line(margin+8, minWidth/row+gridSize, margin+minWidth-8, minWidth/row+gridSize);
    line(margin+8, 2*minWidth/row+gridSize, margin+minWidth-8, 2*minWidth/row+gridSize);
  }
  
  padLeft = (width-300)/2; 
  padTop = (height-300)/2;
  
  //println(en);
  //println(type);
  //println("turn: " + turn);
  //println("num: " + num);
  //println(checker);
  //println(newGrid[0][0]==0);

  if (checker) {
    int n = 0;
    //fill(0);
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        symbol(padLeft+50+100*j, padTop+50+100*i, en[n], type[n]);
        n++;
      }
    }
  }
  if (delayTime) {
//    fill(#455A64);
//    textSize(50);
//    text(result, width/2+2, height/2+2);
//    fill(255);
//    text(result, width/2, height/2);
//    noFill();
    if (result == "X\nWINNER!") {
      strokeWeight(19.2);
      strokeCap(PROJECT);
      stroke(#424242);
      line(width/2-60,padTop+19.2+20,width/2+60,padTop+120+19.2+20);
      line(width/2-60,padTop+120+19.2+20,width/2+60,padTop+19.2+20);
      fill(#00796B);
      textAlign(CENTER, BOTTOM);
      textSize(60);
      text(result.substring(2, result.length()), width/2+2, padTop+300+2-20);
      fill(255);
      text(result.substring(2, result.length()), width/2, padTop+300-20);
      noFill();
    } else if (result == "O\nWINNER!") {
      strokeWeight(19.2);
      strokeCap(PROJECT);
      stroke(#FFF8E1);
      ellipse(width/2, padTop+60+19.2+20, 120, 120);
      fill(#00796B);
      textAlign(CENTER, BOTTOM);
      textSize(60);
      text(result.substring(2, result.length()), width/2+2, padTop+300+2-20);
      fill(255);
      text(result.substring(2, result.length()), width/2, padTop+300-20);
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
      text(result.substring(4, result.length()), width/2+2, padTop+300+2-20);
      fill(255);
      text(result.substring(4, result.length()), width/2, padTop+300-20);
      noFill();
    }
    delay(500);
  }
  textSize(10.5);
  
  fill(255);
  textSize(30);
  for (int i = 0; i < 3; i++) {
    // horiz
    if (en[i*3] == 1 && en[i*3 + 1] == 1 && en[i*3 + 2] == 1) {
      if (type[i*3] == 1 && type[i*3 + 1] == 1 && type[i*3 + 2] == 1) {
        result = "X\nWINNER!";
        //text("X WINNER!", width/2, height/2);
        checker = false;
        //delay(1000);
        delayTime = true;
      }
      if (type[i*3] == 0 && type[i*3 + 1] == 0 && type[i*3 + 2] == 0) {
        result = "O\nWINNER!";
        //text("O WINNER!", width/2, height/2);
        checker = false;
        //delay(1000);
        delayTime = true;
      }
    }
  }
  for (int i = 0; i < 3; i++) {
    // vert
    if (en[i] == 1 && en[i + 3] == 1 && en[i + 6] == 1) {
      if (type[i] == 1 && type[i + 3] == 1 && type[i + 6] == 1) {
        result = "X\nWINNER!";
        //text("X Win!", width/2, height/2);
        checker = false;
        //delay(1000);
        //text("X WINNER!", width/2, height/2);
        delayTime = true;
      }
      if (type[i] == 0 && type[i + 3] == 0 && type[i + 6] == 0) {
        result = "O\nWINNER!";
        //text("O Win!", width/2, height/2);
        checker = false;
        //delay(1000);
        //text("O WINNER!", width/2, height/2);
        delayTime = true;
      }
    }
  }
  if (en[0] == 1 && en[4] == 1 && en[8] == 1) {
    if (type[0] == 1 && type[4] == 1 && type[8] == 1) {
      result = "X\nWINNER!";
      //text("X Win!", width/2, height/2);
      checker = false;
      //delay(1000);
      //text("X WINNER!", width/2, height/2);
      delayTime = true;
    }
    if (type[0] == 0 && type[4] == 0 && type[8] == 0) {
      result = "O\nWINNER!";
      //text("O Win!", width/2, height/2);
      checker = false;
      //delay(1000);
      //text("O WINNER!", width/2, height/2);
      delayTime = true;
    }
  }
  if (en[2] == 1 && en[4] == 1 && en[6] == 1) {
    if (type[2] == 1 && type[4] == 1 && type[6] == 1) {
      result = "X\nWINNER!";
      //text("X Win!", width/2, height/2);
      checker = false;
      //delay(1000);
      //text("X WINNER!", width/2, height/2);
      delayTime = true;
    }
    if (type[2] == 0 && type[4] == 0 && type[6] == 0) {
      result = "O\nWINNER!";
      //text("O Win!", width/2, height/2);
      checker = false;
      //delay(1000);
      //text("O WINNER!", width/2, height/2);
      delayTime = true;
    }
  }
  if (sum(en) == 9 && checker) {
    result = "X O\nDRAW!";
    checker = false;
    delayTime = true;
    //println(sum(en));
  }
  //println(sum(en));
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
  noFill();
}

void mousePressed() {
  //if (mouseButton == LEFT) {
    if (checker) {
      if (mouseX > padLeft && mouseX < 300 + padLeft && mouseY > padTop && mouseY < 300 + padTop) {
        if (mouseX > padLeft && mouseX < 100 + padLeft) {
          if (mouseY > padTop && mouseY < 100+padTop) {
            if (en[0] == 0) {
              en[0] = 1;
              type[0] = turn;
              turn = 1-turn;
            }
            //symbol(padLeft+50, padTop+50, en[0]);
          } else if (mouseY > padTop+100 && mouseY < padTop+200) {
            if (en[3] == 0) {
              en[3] = 1;
              type[3] = turn;
              turn = 1-turn;
            }
            //symbol(padLeft+50, padTop+50+100, en[3]);
          } else if (mouseY > padTop+200 && mouseY < padTop+300) {
            if (en[6] == 0) {
              en[6] = 1;
              type[6] = turn;
              turn = 1-turn;
            }
            //symbol(padLeft+50, padTop+50+200, en[6]);
          }
        } else if (mouseX > padLeft+100 && mouseX < padLeft+200) {
          if (mouseY > padTop && mouseY < 100+padTop) {
            if (en[1] == 0) {
              en[1] = 1;
              type[1] = turn;
              turn = 1-turn;
            }
            //symbol(padLeft+50+100, padTop+50, en[1]);
          } else if (mouseY > padTop+100 && mouseY < padTop+200) {
            if (en[4] == 0) {
              en[4] = 1;
              type[4] = turn;
              turn = 1-turn;
            }
            //symbol(padLeft+50+100, padTop+50+100, en[4]);
          } else if (mouseY > padTop+200 && mouseY < padTop+300) {
            if (en[7] == 0) {
              en[7] = 1;
              type[7] = turn;
              turn = 1-turn;
            }
            //symbol(padLeft+50+100, padTop+50+200, en[7]);
          }
        } else if (mouseX > padLeft+200 && mouseX < padLeft+300) {
          if (mouseY > padTop && mouseY < 100+padTop) {
            if (en[2] == 0) {
              en[2] = 1;
              type[2] = turn;
              turn = 1-turn;
            }
            //symbol(padLeft+50+200, padTop+50, en[2]);
          } else if (mouseY > padTop+100 && mouseY < padTop+200) {
            if (en[5] == 0) {
              en[5] = 1;
              type[5] = turn;
              turn = 1-turn;
            }
            //symbol(padLeft+50+200, padTop+50+100, en[5]);
          } else if (mouseY > padTop+200 && mouseY < padTop+300) {
            if (en[8] != 1) {
              en[8] = 1;
              type[8] = turn;
              turn = 1-turn;
            }
             //symbol(padLeft+50+200, padTop+50+200, en[8]);
          }
        }
        //if (num < 9) {
        //  turn = 1-turn;
        //}
        num++;
      }
    } else {
      if (mouseX > padLeft && mouseX < padLeft + 300 &&
          mouseY > padTop && mouseY < padTop + 300) {
        en = new int[9];
        type = new int[9];
        num = 0;
        turn = 1;
        checker = true;
        delayTime = false;
        result = "";
      }
    }
    String str = "NEW GAME";
    if (mouseX > width/2-((textWidth(str))/2+10) && 
        mouseX < width/2-((textWidth(str))/2+10)+textWidth(str)+20 &&
        mouseY > (height-300)/2+320 &&
        mouseY < (height-300)/2+320 + 30) {
          en = new int[9];
          type = new int[9];
          num = 0;
          turn = 1;
          checker = true;
          delayTime = false;
          result = "";
    }
  //}
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

int sum(int[] num) {
  int res = 0;
  for (int i : num) {
    res += i;
  }
  return res;
}