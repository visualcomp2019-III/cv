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

  HScrollbar scrollbar;

  Illusion3(PGraphics pg, int initialContrast, int initialRate) {
    this.pg = pg;
    this.contrast = initialContrast;
    this.rate = initialRate;
    loadColors();
    scrollbar = new HScrollbar(120, 620, 300, 16, 2, Integer.toString((255 / halfArcs)), Integer.toString(0));
  }

  void setContrast(int value) {
    contrast = value;
    loadColors();
  }

  void decrementRate() {
    if (rate > 1) rate--;
  }

  void increaseRate() {
    if (rate <= (255 / halfArcs)) rate++;
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

  void drawScrollbar() {    
    stroke(160);
    scrollbar.update();
    scrollbar.display();
  }

  void drawIllusion() {
    this.setContrast((int) scrollbar.getPos() / 10);
    pg.beginDraw();
    pg.background(150);
    pg.stroke(150);
    pg.strokeWeight(2);

    posColor++;
    posColor %= arcs;

    int centerY = pg.height / 2;
    int centerX = pg.width / 2;
    float radius = 400;
    float radians = PI / halfArcs;    
    for (int i = 0; i < arcs; i++) {
      pg.pushStyle();
      pg.fill(colors[(i + posColor) % arcs]);
      pg.arc(centerX, centerY, radius, radius, radians * i, radians * (i + 1), PIE); 
      pg.popStyle();
    }
    pg.endDraw();
  }
}
