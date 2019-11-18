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
}
