rocks = [];
moons = [];

var rotX, rotY;

function setup() {
  createCanvas(windowWidth, windowHeight, WEBGL)
  background(0);
  smooth(0);

  texture = loadImage("saturn.jpg");
  moonText = loadImage("moon.jpg");

  rotateX(PI / 4);
  rotX = 0;
  rotY = 0;

  rocks = new Asteroid[100];
  moons = new Moon[3];

  for (var i = 0; i < 100; i++) {
    var rho = random(900, 1100);
    var theta = random(0, PI * 2);
    var phi = PI / 2;
    rocks.push(new Asteroid(getX(rho, theta, phi), getY(rho, theta, phi), getZ(rho, phi), random(2, 4)));
  }

  for (var i = 0; i < 3; i++) {
    var rho = random(1250, 2500);
    var theta = random(0, PI * 2);
    var phi = random(PI / 2 - PI / 36, PI / 2 + PI / 36);
    moons.push(new Moon(getX(rho, theta, phi), getY(rho, theta, phi), getZ(rho, phi), random(25, 75)));
  }
}

function draw() {
  rotateX(rotX);
  rotateY(rotY);

  lights();
  background(0);

  texture(texture);
  sphere(300);

  for (var a of rocks) {
    a.show();
    a.move();
  }

  for (var m of moons) {
    m.move();
    m.show();
  }

  textSize(50);
  text("FPS: " + frameRate(), 1250, 1250, 0);
}

function mouseDragged() {
  rotY += (mouseX - pmouseX) * 0.01;
  rotX -= (mouseY - pmouseY) * 0.01;
}

class Asteroid {
  constructor(xPos, yPos, zPos, s) {
    this.x = xPos;
    this.y = yPos;
    this.z = zPos;
    this.size = s;
    this.rho = getRho(x, y, z);
    this.phi = getPhi(x, y, z);
    this.theta = getTheta(x, y);
    this.speed = random(.02, .03);
    this.t = theta;
  }
  show() {
    fill(255);
    translate(this.x, this.y, this.z);
    sphere(this.size);
  }
  move() {
    theta = t;
    x = getX(rho, theta, phi);
    y = getY(rho, theta, phi);
    z = getZ(rho, phi);
    t += speed;
  }
}
class Moon extends Asteroid {
  constructor(xPos, yPos, zPos, s) {
    super(xPos, yPos, zPos, s);
    this.speed = random(.009, .015);
    this.scalar = random(-PI / 3, PI / 3);
    this.minRad = getRho(xPos, yPos, zPos);
    this.endX = x;
    this.endY = y;
    this.endZ = z;
    this.trace = [];
    this.counter = 0;
    this.lines = [];
  }
  move() {
    this.theta = t;
    this.phi = scalar * cos(t + scalar) / (PI) + PI / 2;
    rho = minRad + 250 * sin(t);
    if (counter > 3) {
      endX = getX(rho, theta, phi);
      endY = getY(rho, theta, phi);
      endZ = getZ(rho, phi);
      lines.push(new Trace(x, y, z, endX, endY, endZ));
      lines.remove(0);
      counter = 0;
    }
    x = getX(rho, theta, phi);
    y = getY(rho, theta, phi);
    z = getZ(rho, phi);
    t += speed;
    if (t == 2 * PI)
      t = 0;
    counter++;
  }
  show() {
    translate(x, y, z);
    texture(moonText);
    sphere(50);
    rotateZ(1);

    for (var t of lines) {
      t.show();
    }
  }
}
class Trace {
  constructor(startX, startY, startZ, endX, endY, endZ) {
    this.startX = startX;
    this.startY = startY;
    this.startZ = startZ;
    this.endX = endX;
    this.endY = endY;
    this.endZ = endZ;
  }
  show() {
    stroke(255);
    strokeWeight(3);
    line(this.startX, this.startY, this.startZ, this.endX, this.endY.this.endZ);
  }
}
function getTheta(x, y) {
  return atan2(this.y, this.x);
}

function getPhi(x, y, z) {
  return atan2(sqrt(this.x * this.x + this.y * this.y), this.z);
}
function getRho(x, y, z) {
  return sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
}
function getX(rho, theta, phi) {
  return this.rho * cos(this.theta) * sin(this.phi);
}
function getY(rho, theta, phi) {
  return this.rho * sin(this.theta) * sin(this.phi);
}
function getZ(rho, phi) {
  return this.rho * cos(this.phi);
}