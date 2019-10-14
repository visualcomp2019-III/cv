/** 
 * Illusion based on: https://michaelbach.de/ot/lum-diamond/index.html
 */
class Illusion4 {
  private float diamondHeight;
  private float halfHeight;
  private float halfWidth;
  private int color1;
  private int color2;
  private int rows;
  private int initialX; 
  private int initialY;
  private PGraphics pg;

  Illusion4(PGraphics pg, int initialX, int initialY, float diamondWidth, float diamondHeight, int rows, int color1, int color2 ) {
    this.pg = pg;
    this.initialX = initialX;
    this.initialY = initialY;
    this.diamondHeight = diamondHeight;
    this.halfHeight = diamondHeight / 2;
    this.halfWidth = diamondWidth / 2;
    this.rows = rows;
    this.color1 = color1;
    this.color2 = color2;
  }

  void drawIllusion() {
    pg.beginDraw();
    for (int i = 0; i < 6; i++) {
      drawRowOfDiamonds(rows, initialX, initialY, rows == 0);
      initialX += halfWidth;
      initialY += halfHeight;
      rows--;
    }
    drawRowOfDiamonds(0, initialX, initialY, true);
    pg.endDraw();
  }

  private void drawRowOfDiamonds(int row, int initialX, int initialY, boolean paintHalf) {
    drawDiamond(initialX, initialY, paintHalf);
    if (row == 0) return;
    if (row == 1) paintHalf = true;

    drawRowOfDiamonds(row - 1, initialX - (int)halfWidth, initialY + (int)halfHeight, paintHalf);
  }

  private void drawDiamond(int x, int y, boolean paintHalf) {
    float addToX = 0;
    float slope = halfHeight / halfWidth;
    // Based on: https://processing.org/examples/lineargradient.html for the color gradient
    for (int i = y; i <= y+diamondHeight; i++) {
      float inter = map(i, y, y+diamondHeight, 0, 1);
      color c = lerpColor(color1, color2, inter);
      pg.stroke(c);
      if (i <= (y + halfHeight)) {
        addToX = (i - y) / slope;
        pg.line(x - addToX, i, x + addToX, i);
      } else if (!paintHalf) {
        addToX = (i - y) / slope - halfWidth;
        pg.line(x - halfWidth + addToX, i, x + halfWidth - addToX, i);
      }
    }
  }
}
