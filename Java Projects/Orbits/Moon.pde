class Moon extends Asteroid {
  float scalar, minRad, endX, endY, endZ;
  int counter;
  PShape moon;
  ArrayList <Trace> lines;

  public Moon (float xPos, float yPos, float zPos, int s, PImage text) {
    super(xPos, yPos, zPos, s);
    speed = random(.009, .015);
    scalar = random(-PI/3, PI/3);
    minRad = getRho(xPos, yPos, zPos);
    endX = x;
    endY = y;
    endZ = z;

    noStroke();
    noFill();
    moon = createShape(SPHERE, s);
    moon.setTexture(text);

    lines = new ArrayList <Trace>();
    for (int i = 0; i < 100; i++) {
      lines.add(new Trace(xPos, yPos, zPos, xPos, yPos, zPos));
    }
  }
  void move () {
    theta = t;
    phi = scalar * cos(t + scalar)/(PI) + PI/2;
    rho = minRad + 250*sin(t);
    endX = getX(rho, theta, phi);
    endY = getY(rho, theta, phi);
    endZ = getZ(rho, phi);
    lines.add(new Trace(x, y, z, endX, endY, endZ));
    x = getX(rho, theta, phi);
    y = getY(rho, theta, phi);
    z = getZ(rho, phi);
    t += speed;
    lines.remove(0);
  }
  void show() {
    pushMatrix();
    translate(x, y, z);
    shape(moon);
    rotateZ(1);
    popMatrix();
    for (Trace t : lines) {
      t.show();
    }
  }
}
