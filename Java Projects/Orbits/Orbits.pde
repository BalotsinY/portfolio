import peasy.*;
PeasyCam cam;
PImage texture;
PImage moonText;
PShape planet;

Asteroid rocks [];
Moon moons [];

void setup() {
  fullScreen(P3D);
  background(0);
  smooth(0);

  texture = loadImage("saturn.jpg");
  moonText = loadImage("moon.jpg");

  cam = new PeasyCam (this, 2000);
  cam.rotateX(-PI/4);

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

  textSize(50); //<>//
  text("FPS: "+(int)frameRate, 1250, 1250, 0);
  //drawText();
}

void drawText () {
  pushMatrix();
  textSize(50); 
  stroke(255, 0, 0);
  line(0, 0, 0, 1000, 0, 0);
  text("x", 1050, 0, 0);

  stroke(0, 255, 0);
  line(0, 0, 0, 0, 1000, 0);
  text("y", 0, 1050, 0);

  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 1000);
  text("z", 0, 0, 1050);

  stroke(255, 0, 0);
  line(0, 0, 0, -1000, 0, 0);
  text("-x", -1050, 0, 0);

  stroke(0, 255, 0);
  line(0, 0, 0, 0, -1000, 0);
  text("-y", 0, -1050, 0);

  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, -1000);
  text("-z", 0, 0, -1050);

  textSize(50);
  text("FPS: "+(int)frameRate, 1250, 1250, 0);
  popMatrix();
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
