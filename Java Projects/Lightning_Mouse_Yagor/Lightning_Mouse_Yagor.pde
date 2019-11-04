float startX, startY, endX, endY, spread, d;
PImage plasmaGlobe, hand;
void setup() {
  fullScreen();
  frameRate(60);
  startX = 900;
  startY = 650;
  endX = 900;
  endY = 650;
  spread = 25;
  d = 0;
  background(255);
  strokeWeight(15);
  plasmaGlobe = loadImage("PlasmaGlobe.png");
  hand = loadImage("Hand.png");
}
void draw() {
  background(255);
  image(plasmaGlobe, 20, 0);
  stroke(random(155, 255), random(155, 255), random(155, 255));
  fill(random(200, 255), random(200, 255), random(200, 255));
  if (calcD(mouseX, mouseY) < 570) {
    startX = 900+60*cos(calcAngleToMouse());
    startY = 650+60*sin(calcAngleToMouse());
    while (d < calcD(mouseX, mouseY)) {
      endX = startX + (random(1, spread)*cos(calcAngleToMouse()));
      endY = startY + (random(1, spread)*sin(calcAngleToMouse()));
      println(calcAngleToMouse());
      line(startX, startY, endX, endY);
      startX = endX;
      startY = endY;
      d = calcD (endX, endY);
      ellipse(mouseX, mouseY, 100, 100);
    }
  }
  startX = 900;
  startY = 650;
  endX = 900;
  endY = 650;
  d = 0;
  image(hand, mouseX-125, mouseY-25);
}
float calcD (float x, float y) {
  return sqrt(sq(x - 900)+sq(y - 650));
}
float calcAngleToMouse () {
  return atan2(mouseY-650, mouseX-900);
}
