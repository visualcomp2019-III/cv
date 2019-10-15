/** 
 * Illusion based on: https://michaelbach.de/ot/mot-kaleidoscope/index.html
 */
class Illusion5 {
  float rateRotation;
  int points;
  PGraphics pg; 
  int centerX;
  int centerY;

  Illusion5(PGraphics pg, int x, int y, float rateRotation, int points) {
    this.pg = pg;
    this.centerX = x;
    this.centerY = y;
    this.rateRotation = rateRotation;
    this.points = points;
  }
  
  void increaseSpeed(){
    if(this.rateRotation > 10) this.rateRotation -= 10;
  }
  
  void decreaseSpeed(){
    if(this.rateRotation < 500) this.rateRotation += 10;
  }

  void drawIllusion() {
    int gap = 18;
    int widthRing = 15;
    int initialRadius = 110;

    pg.beginDraw();

    fill(0, 0, 102);
    createStar(initialRadius + gap * 2 + widthRing * 2, initialRadius + gap * 3 + widthRing * 2, false);

    fill(255);
    createStar(initialRadius + gap + widthRing, initialRadius + gap * 2 + widthRing, false);

    fill(204, 0, 0);
    createStar(initialRadius + gap + widthRing, initialRadius + gap * 2 + widthRing, true);

    fill(255);
    createStar(initialRadius, initialRadius + gap, true);

    fill(0, 0, 102);
    createStar(initialRadius, initialRadius + gap, false);
    pg.endDraw();
  }

  void createStar(int radius1, int radius2, boolean rotateShape) {
    pushMatrix();
    translate(width*0.2, height*0.5);
    if (rotateShape) rotate(frameCount / rateRotation);
    star(0, 0, radius1, radius2);  
    popMatrix();
  }
  
  
  // Function taken from: https://processing.org/examples/star.html
  void star(float x, float y, float radius1, float radius2) {
    float angle = TWO_PI / points;
    float halfAngle = angle / 2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}
