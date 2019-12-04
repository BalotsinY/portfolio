PImage texture;
PImage moonText;
PShape planet;

Asteroid rocks [];
Moon moons [];

float rotX, rotY;

void setup() {
  fullScreen(P3D);
  background(0);
  smooth(0);

  texture = loadImage("saturn.jpg");
  moonText = loadImage("moon.jpg");

  rotateX(PI/4);
  rotX = 0;
  rotY = 0;

  rocks = new Asteroid [100];
  moons = new Moon [3];

  for (int i = 0; i < rocks.length; i++) {
    float rho = random(900, 1100);
    float theta = random(0, PI*2);
    float phi = PI/2;//random(PI/2-PI/72, PI/2+PI/72);
    rocks[i] = new Asteroid(getX(rho, theta, phi), getY(rho, theta, phi), getZ(rho, phi), (int)random(2, 4));
  }

  for (int i = 0; i < moons.length; i++) {
    float rho = random(1250, 2500);
    float theta = random(0, PI*2);
    float phi = random(PI/2-PI/36, PI/2+PI/36);
    moons[i] = new Moon(getX(rho, theta, phi), getY(rho, theta, phi), getZ(rho, phi), (int)random(25, 75), moonText);
  }

  noStroke();
  noFill();
  planet = createShape(SPHERE, 300);
  planet.setTexture(texture);
  planet.rotateX(PI/2);
}
void draw() {
  rotateX(rotX);
  rotateY(rotY);

  lights();
  background(0);

  shape(planet);

  for (Asteroid a : rocks) {
    a.show();
    a.move();
  }

  for (Moon m : moons) {
    m.move();
    m.show();
  }

  textSize(50);
  text("FPS: "+(int)frameRate, 1250, 1250, 0);
}

void mouseDragged(){
  rotY += (mouseX - pmouseX) * 0.01;
  rotX -= (mouseY - pmouseY) * 0.01;
}

class Asteroid {
  float x, y, z, rho, phi, theta, t, speed;//, scalar;
  int size;
  
  public Asteroid(float xPos, float yPos, float zPos, int s) {
    x = xPos;
    y = yPos;
    z = zPos;
    size = s;
    rho = getRho(x, y, z);
    phi = getPhi(x, y, z);
    theta = getTheta(x, y);
    speed = random(.02, .03);
    t = theta;
    
  }

  void show() {
    pushMatrix();
    fill(255);
    translate(x, y, z);
    sphere(size);
    popMatrix();
  }
  void move() {
    theta = t;
    x = getX(rho, theta, phi);
    y = getY(rho, theta, phi);
    z = getZ(rho, phi);
    t += speed;
  }
}
class Moon extends Asteroid {
  float scalar, minRad, endX, endY, endZ;
  PShape moon;
  int counter;
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
    for (int i = 0; i < 50; i++) {
      lines.add(new Trace(xPos, yPos, zPos, xPos, yPos, zPos));
    }
    counter = 0;
  }
  void move () {
    theta = t;
    phi = scalar * cos(t + scalar)/(PI) + PI/2;
    rho = minRad + 250*sin(t);
    if (counter > 3) { 
      endX = getX(rho, theta, phi);
      endY = getY(rho, theta, phi);
      endZ = getZ(rho, phi);
      lines.add(new Trace(x, y, z, endX, endY, endZ));
      lines.remove(0);
      counter = 0;
    }
    x = getX(rho, theta, phi);
    y = getY(rho, theta, phi);
    z = getZ(rho, phi);
    t += speed;
    if (t == 2*PI)
      t = 0;
    counter++;
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
class Trace { 
  float x, y, z, X, Y, Z;
  public Trace(float startX, float startY, float startZ, float endX, float endY, float endZ) {
    x = startX;
    y = startY;
    z = startZ;
    X = endX;
    Y = endY;
    Z = endZ;
  }
  void show() {
    stroke(255);
    strokeWeight(3);
    line(x, y, z, X, Y, Z);
  }
}
float getTheta (float x, float y) {
  return atan2(y, x);
}
float getPhi (float x, float y, float z) {
  return atan2(sqrt(x*x + y*y), z);
}
float getRho (float x, float y, float z) {
  return sqrt(x*x+y*y+z*z);
}
float getX (float rho, float theta, float phi) {
  return rho * cos(theta) * sin(phi);
}
float getY (float rho, float theta, float phi) {
  return rho * sin(theta) * sin(phi);
}
float getZ (float rho, float phi) {
  return rho * cos(phi);
}