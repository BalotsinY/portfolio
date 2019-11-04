int size, savedTime, totalTime, x, y, l, counter, minX, minY, maxX, maxY;
Die dice [][];
boolean cascade;

void setup () {
  //size(500, 500);
  fullScreen();
  dice = new Die [5][5];
  size = (int)height/dice[0].length - 25;
  totalTime = 500;
  savedTime = millis();
  x = 0; 
  y = 0;
  cascade = true;
  l = 1;
  counter = 1;
  minX = 2;
  minY = 2;
  maxX = 2;
  maxY = 2;

  for (int i = 0; i < dice.length; i++) {
    for (int j = 0; j < dice[i].length; j++) {
      dice[i][j] = new Die ((size+25)*(i), (size+25)*(j), size);
    }
  }
}

void draw () {
  background(0);

  int passedTime = millis() - savedTime;

  for (int i = 0; i < dice.length; i++) {
    for (int j = 0; j < dice[i].length; j++) {
      dice[i][j].show();
    }
  }

  if (passedTime > totalTime) {
    if (cascade) {
      dice[x][y] = new Die ((size+25)*(x), (size+25)*(y), size);
      x++;
    } else {
      x = minX;
      y = minY;
      dice[x][y] = new Die ((size+25)*(minX), (size+25)*(minY), size);

      while (x < maxX) { //<>//
        dice[x][y] = new Die ((size+25)*(minX), (size+25)*(minY), size);
        x++;
      }
      while (y < maxY) { //<>//
        dice[x][y] = new Die ((size+25)*(minX), (size+25)*(minY), size);
        y++;
      }
      while (x > minX) { //<>//
        dice[x][y] = new Die ((size+25)*(minX), (size+25)*(minY), size);
        x--;
      }
      while (y > minY) { //<>//
        dice[x][y] = new Die ((size+25)*(minX), (size+25)*(minY), size);
        y--;
      }
    }
    counter++;
    l = 2 * (counter - 1);

    savedTime = millis();
    if (cascade) {
      if (x == dice.length && y == dice[0].length - 1) {
        x = 0;
        y = 0;
      } else if (x == dice.length) {
        y++;
        x = 0;
      }
    } else if (!cascade) {
      minX--;
      minY--;
      maxX++;
      maxY++;
      if (minX < 0 || maxX > 4 || minY < 0 || maxY > 4) {
        minX = 2;
        minY = 2;
        maxX = 2;
        maxY = 2;
      }
    }
  }
}

void mousePressed() {
  for (int i = 0; i < dice.length; i++) {
    for (int j = 0; j < dice[i].length; j++) {
      dice[i][j] = new Die ((size+25)*(i), (size+25)*(j), size);
    }
  }
  x = 0;
  y = 0;
  if (cascade) {
    cascade = false;
  } else {
    cascade = true;
  }
}
