rocks = [];
moons = [];

var easycam;

function setup() {
  createCanvas(windowWidth, windowHeight, WEBGL)
  background(0);
  smooth(0);

  planetTexture = loadImage("saturn.jpg");
  moonText = loadImage("moon.jpg");

  setAttributes('antialias', true);

  easycam = createEasyCam();

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
  noStroke();
  lights();
  lights();
  background(0);

  texture(planetTexture);
  sphere(300);

  for (var a of rocks) {
    a.show();
    a.move();
  }

  for (var m of moons) {
    m.move();
    m.show();
  }
}

class Asteroid {
  constructor(xPos, yPos, zPos, s) {
    this.x = xPos;
    this.y = yPos;
    this.z = zPos;
    this.size = s;
    this.rho = getRho(this.x, this.y, this.z);
    this.phi = getPhi(this.x, this.y, this.z);
    this.theta = getTheta(this.x, this.y);
    this.speed = random(.02, .03);
    this.t = this.theta;
  }
  show() {
    fill(255);
    translate(this.x, this.y, this.z);
    sphere(this.size);
  }
  move() {
    this.theta = this.t;
    this.x = getX(this.rho, this.theta, this.phi);
    this.y = getY(this.rho, this.theta, this.phi);
    this.z = getZ(this.rho, this.phi);
    this.t += this.speed;
  }
}
class Moon {
  constructor(xPos, yPos, zPos, s) {
    this.x = xPos;
    this.y = yPos;
    this.z = zPos;
    this.size = s;
    this.speed = random(.009, .015);
    this.scalar = random(-PI / 3, PI / 3);
    this.minRad = getRho(xPos, yPos, zPos);
    this.endX = this.x;
    this.endY = this.y;
    this.endZ = this.z;
    this.counter = 0;
    this.lines = [];
    this.t = 0;
  }
  move() {
    this.theta = this.t;
    this.phi = this.scalar * cos(this.t + this.scalar) / (PI) + PI / 2;
    this.rho = this.minRad + 250 * sin(this.t);
    if (this.counter > 3) {
      this.endX = getX(this.rho, this.theta, this.phi);
      this.endY = getY(this.rho, this.theta, this.phi);
      this.endZ = getZ(this.rho, this.phi);
      this.lines.push(new Trace(this.x, this.y, this.z, this.endX, this.endY, this.endZ));
      this.lines.splice(0, 1);
      this.counter = 0;
    }
    this.x = getX(this.rho, this.theta, this.phi);
    this.y = getY(this.rho, this.theta, this.phi);
    this.z = getZ(this.rho, this.phi);
    this.t += this.speed;
    if (this.t == 2 * PI)
      this.t = 0;
    this.counter++;
  }
  show() {
    translate(this.x, this.y, this.z);
    texture(moonText);
    sphere(50);

    for (var t of this.lines) {
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
  return atan2(y, x);
}

function getPhi(x, y, z) {
  return atan2(sqrt(x * x + y * y), z);
}

function getRho(x, y, z) {
  return sqrt(x * x + y * y + z * z);
}

function getX(rho, theta, phi) {
  return rho * cos(theta) * sin(phi);
}

function getY(rho, theta, phi) {
  return rho * sin(theta) * sin(phi);
}

function getZ(rho, phi) {
  return rho * cos(phi);
}