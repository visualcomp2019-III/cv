/** 
 * Illusion based on: https://michaelbach.de/ot/mot-spokes/index.html
 */
class Illusion3 {

  PGraphics pg;
  int arcs = 16;
  int halfArcs = arcs / 2;
  int posColor = 0;
  int contrast;
  int[] colors = new int[arcs];
  int rate;
  boolean beingDrawn = false;

  Illusion3(PGraphics pg, int initialContrast, int initialRate) {
    this.pg = pg;
    this.contrast = initialContrast;
    this.rate = initialRate;
    loadColors();
  }

  void setBeingDrawn(boolean value) {
    beingDrawn = value;
  }

  boolean isBeingDrawn() {
    return beingDrawn;
  }

  void setContrast(int value) {
    contrast = value;
    loadColors();
  }

  void decrementRate() {
    if (rate > 1) rate--;
  }

  void increaseRate() {
    if (rate <= 30) rate++;
  }

  private void loadColors() {
    int currentColor = 255;
    for (int i = 0; i < arcs; i++) {
      colors[i] = currentColor;
      if (i < halfArcs) {  
        currentColor -= contrast;
      } else {
        currentColor += contrast;
      }
    }
  }

  void drawIllusion() {
    pg.beginDraw();
    pg.background(150);
    pg.stroke(150);
    pg.strokeWeight(2);

    posColor++;
    posColor %= arcs;

    int center = pg.height / 2;
    float radius = 400;
    float radians = PI / halfArcs;    
    for (int i = 0; i < arcs; i++) {
      pg.pushStyle();
      pg.fill(colors[(i + posColor) % arcs]);
      pg.arc(center, center, radius, radius, radians * i, radians * (i + 1), PIE); 
      pg.popStyle();
    }
    pg.endDraw();
  }
}
