/**
 * Illusion based on: https://michaelbach.de/ot/ang-tiltedTable/index.html
 */

class Illusion1 {

  PGraphics destination; 
  Illusion1(PGraphics destination) {
    this.destination = destination;
  }

  void drawIllusion() {
    //Link: https://michaelbach.de/ot/ang-tiltedTable/index.html
    destination.beginDraw();
    destination.loadPixels();
    int initialX = 80;
    int initialY = 100;
    int widthRectangle = 800;
    int heightRectangle = 75;
    int widthLine = 4;
    int radius = 10;
    int gapBetweenRectangles = 200;
    int initialXSecondRectangle = widthRectangle / 2 + initialX -  (widthRectangle / 4);
    int initialYSecondRectangle = initialY + heightRectangle + radius;
    fill(255);
    rect(initialX, initialY, widthRectangle, heightRectangle);
    fill(0);
    ellipse(widthRectangle / 2 + initialX, initialY + heightRectangle + (radius / 2), radius, radius);
    fill(255);
    rect(initialXSecondRectangle, initialYSecondRectangle, widthRectangle/2, heightRectangle*2);

    boolean drawLeftToRight = false;
    int gap = 12;
    drawInternalLines(drawLeftToRight, gap, initialX, initialY, widthRectangle, heightRectangle);
    drawInternalLines(!drawLeftToRight, gap, initialXSecondRectangle, initialYSecondRectangle, widthRectangle/2, heightRectangle*2);

    destination.endDraw();
  }

  // If the orientation is true, lines are draw from left to right
  // If the orientation is false, lines are draw from right to left
  void drawInternalLines(boolean orientation, int gap, int initialX, int initialY, int widthRectangle, int heightRectangle) {
    int leftGap = gap, rightGap = gap;
    int rest1 = 0, rest2 = 0;

    //False is moving up
    //True is moving right
    boolean corner1 = true;
    boolean corner2 = true;
    //First left: true First right: false
    boolean whichCorner = true;
    if (orientation) {
      int currentX1 = initialX;
      int currentY1 = initialY + heightRectangle;
      int currentX2 = currentX1;
      int currentY2 = currentY1;

      //False is moving up
      //True is moving right

      //First left: true First right: false
      while (true) {
        if (currentY1 <= initialY) {
          rest1 = initialY - currentY1;
          corner1 = false;
          if (corner2 == false) whichCorner = true;
        }
        if (currentX2 >= initialX + widthRectangle) {
          rest2 = initialX + widthRectangle - currentX2;
          corner2 = false;
          if (corner1 == false) whichCorner = false;
        }

        if (corner1 && corner2) {
          currentY1 -= leftGap;
          currentX2 += rightGap;
        } else if (!corner1 && corner2) {
          if (rest1 != 0) {
            currentY1 = initialY;
            currentX1 += rest1;
            rest1 = 0;
          }
          currentX1 += leftGap;
          currentX2 += rightGap;
        } else if (corner1 && !corner2) {
          if (rest2 != 0) {
            currentX2 = initialX + widthRectangle;
            currentY2 -= rest2;
            rest2 = 0;
          }
          currentY1 -= leftGap;
          currentY2 -= rightGap;
        } else if (!corner1 && !corner2) {  

          if (!whichCorner && (rest1 != 0)) {
            currentY1 = initialY;
            currentX1 += rest1;
            rest1 = 0;
          }
          if (whichCorner && (rest2 != 0)) {
            currentX2 = initialX + widthRectangle;
            currentY2 -= rest2;
            rest2 = 0;
          }
          currentX1 += leftGap;
          currentY2 -= rightGap;
        }

        if ((currentX1 >= initialX + widthRectangle) && (currentY2 <= initialY)) break;
        System.out.println("X1: " + currentX1 + " Y1:" + currentY1 + " // X2:" + currentX2 + " Y2:" + currentY2 + "///" + corner1 + " " + corner2); 
        line(currentX1, currentY1, currentX2, currentY2);
      }
    } else {
      int currentX1 = initialX;
      int currentY1 = initialY;
      int currentX2 = currentX1;
      int currentY2 = currentY1;

      while (true) {
        //System.out.println("--------");
        //System.out.println("X1: " + currentX1 + " Y1:" + currentY1 + " // X2:" + currentX2 + " Y2:" + currentY2 + "///" + corner1 + " " + corner2); 
        if (currentY1 >= initialY + heightRectangle) {
          rest1 = currentY1 - initialY - heightRectangle;
          corner1 = false;
          if (corner2 == false) whichCorner = true;
        }
        if (currentX2 >= initialX + widthRectangle) {
          rest2 = currentX2 - initialX - widthRectangle;
          corner2 = false;
          if (corner1 == false) whichCorner = false;
        }
        if (corner1 && corner2) {
          currentY1 += leftGap;
          currentX2 += rightGap;
        } else if (!corner1 && corner2) {
          if (rest1 != 0) {
            currentY1 = initialY + heightRectangle;
            currentX1 += rest1;
            rest1 = 0;
          }
          currentX1 += leftGap;
          currentX2 += rightGap;
        } else if (corner1 && !corner2) {
          if (rest2 != 0) {
            currentX2 = initialX + widthRectangle;
            currentY2 += rest2;
            rest2 = 0;
          }
          currentY1 += leftGap;
          currentY2 += rightGap;
        } else if (!corner1 && !corner2) {  

          if (!whichCorner && (rest1 != 0)) {
            currentY1 = initialY + heightRectangle;
            currentX1 += rest1;
            rest1 = 0;
          }
          if (whichCorner && (rest2 != 0)) {
            currentX2 = initialX + widthRectangle;
            currentY2 -= rest2;
            rest2 = 0;
          }
          currentX1 += leftGap;
          currentY2 += rightGap;
        }
        if ((currentX1 >= initialX + widthRectangle) && (currentY2 >= initialY + heightRectangle)) break;
        //System.out.println("X1: " + currentX1 + " Y1:" + currentY1 + " // X2:" + currentX2 + " Y2:" + currentY2 + "///" + corner1 + " " + corner2);
        //System.out.println("--------");
        line(currentX1, currentY1, currentX2, currentY2);
      }
    }
  }
}
