import java.util.*;

int grid = 30;
int numFields = 200;
int numMines = 40;
Field[] fields;

void settings() {
  size(601,301);
}

void setup() { 
  fields = new Field[numFields];
  
  textSize(grid/2);
  
  int[] randomIndices = getRandomIndices(numMines, 200);
  println(Arrays.toString(randomIndices));
  
  for (int i = 0; i < numFields; i++) {
    fields[i] = new Field(false); 
  }
  
  for (int i: randomIndices) {
    fields[i].mine = true; 
  }
}

void mousePressed() {
  int index = (width/grid) * (mouseY/grid) + mouseX / grid;
  fields[index].click();
}

void draw() {
  background(30);
  
  for (int i = 0; i < fields.length; i++) {
    Field f = fields[i];
    f.show(i);
  }
  
   checkGameOver();
}

void checkGameOver() {
  textSize(56);
  fill(0);
  for (Field f: fields) {
    if (f.mine && f.shown) {
      noLoop();
      text("GAME LOST", width / 4, height / 2);
      return;
    }
    if (! f.mine && ! f.shown) {
      return;
    }
  }
  noLoop();
  text("GAME WON", width / 4, height / 2);
  for (Field f: fields) f.shown = true;
}

int[] getRandomIndices(int n, int max) {
  int[] array = new int[n];
  for (int i = 0; i < n; i++) {
    array[i] = (int) (max * Math.random()); 
  }
  return array;
}