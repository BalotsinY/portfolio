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
    pushMatrix();
    stroke(255);
    strokeWeight(3);
    line(x, y, z, X, Y, Z);
    popMatrix();
  }
}
