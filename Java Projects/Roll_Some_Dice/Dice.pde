class Die {
  int num, x, y, size;
  float r, g, b;

  Die (int xPos, int yPos, int s) {
    x = xPos;
    y = yPos;
    size = s;
    num = (int) random (1, 7);
    r = random(255);
    g = random(255);
    b = random(255);
  }
  void show () {
    stroke (r, g, b);
    fill(r, g, b);
    rect (x, y, size, size, size/4);
    stroke (255);
    fill(255);
    if (num == 1) {
      ellipse (x + size/2, y + size/2, size/7, size/7);
    } else if (num == 2) {
      ellipse (x + size/3, y + size/3, size/7, size/7);
      ellipse (x + size*2/3, y + size*2/3, size/7, size/7);
    } else if (num == 3) {
      ellipse (x + size/3, y + size/3, size/7, size/7);
      ellipse (x + size/2, y + size/2, size/7, size/7);
      ellipse (x + size*2/3, y + size*2/3, size/7, size/7);
    } else if (num == 4) {
      ellipse (x + size/3, y + size/3, size/7, size/7);//top left
      ellipse (x + size*2/3, y + size/3, size/7, size/7);//top right
      ellipse (x + size/3, y + size*2/3, size/7, size/7);//bottom left
      ellipse (x + size*2/3, y + size*2/3, size/7, size/7);//bottom right
    } else if (num == 5) {
      ellipse (x + size/3, y + size/3, size/7, size/7);
      ellipse (x + size*2/3, y + size/3, size/7, size/7);
      ellipse (x + size/2, y + size/2, size/7, size/7);
      ellipse (x + size/3, y + size*2/3, size/7, size/7);
      ellipse (x + size*2/3, y + size*2/3, size/7, size/7);
    } else if (num == 6) {
      ellipse (x + size/3, y + size/3, size/7, size/7);//top left
      ellipse (x + size*2/3, y + size/3, size/7, size/7);//top right
      ellipse (x + size/3, y + size/2, size/7, size/7);//mid left
      ellipse (x + size*2/3, y + size/2, size/7, size/7);//mid right
      ellipse (x + size/3, y + size*2/3, size/7, size/7);//bottom left
      ellipse (x + size*2/3, y + size*2/3, size/7, size/7);//bottom right
    }
  }
}
