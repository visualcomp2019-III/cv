// 1 https://michaelbach.de/ot/ang-tiltedTable/index.html
PGraphics pgVisualIlussion, pg;

HScrollbar hs1;

final int TOTAL_BUTTONS = 6;
Button[] buttons = new Button[TOTAL_BUTTONS];

final int BUTTON_HEIGHT = 50;
final int IMAGE_LEFT_PADDING = 80;
final int IMAGE_TOP_PADDING = BUTTON_HEIGHT + 20;
int INITIAL_IMG_HEIGHT = 500;
int INITIAL_IMG_WIDTH = 500;

Illusion3 illusion3;

void setup() {
  size(1200, 700);
  smooth();

  pgVisualIlussion = createGraphics(INITIAL_IMG_WIDTH, INITIAL_IMG_HEIGHT);

  createButtons();
  drawAllButtons();

  pg = createGraphics(500, 500);
  hs1 = new HScrollbar(120, 620, 300, 16, 2);
  illusion3 = new Illusion3(pg, 0, 15);
}

void draw() {
  if (illusion3.isBeingDrawn()) {
    frameRate(illusion3.rate);
    illusion3.setContrast((int)hs1.getPos() / 10);
    illusion3.drawIllusion();
    image(pg, 120, 120);
    stroke(160);
    hs1.update();
    hs1.display();
  }
}

void keyPressed() {
  if (illusion3.isBeingDrawn()) {
    if (keyCode == UP) illusion3.increaseRate();
    else if (keyCode == DOWN) illusion3.decrementRate();
  }
}

void mouseClicked() {
  //clearAllPgs();
  illusion3.setBeingDrawn(false);

  if (buttons[0].mouseIsOver()) {
    pgToClear(pgVisualIlussion);
    drawFirstIlussion(pgVisualIlussion);
  } else if (buttons[1].mouseIsOver()) {
    illusion3.setBeingDrawn(true);
  } else if (buttons[2].mouseIsOver()) {
    drawSecondIllusion(pgVisualIlussion);
  } else if (buttons[3].mouseIsOver()) {
    drawSecondIllusion(pgVisualIlussion);
  } else if (buttons[4].mouseIsOver()) {
    drawSecondIllusion(pgVisualIlussion);
  } else if (buttons[5].mouseIsOver()) {
    drawSecondIllusion(pgVisualIlussion);
  }

  displayAllPgs();
}

void drawFirstIlussion(PGraphics destination){
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
   ellipse(widthRectangle / 2 + initialX, initialY + heightRectangle + (radius / 2) , radius, radius);
   fill(255);
   rect(initialXSecondRectangle, initialYSecondRectangle, widthRectangle/2, heightRectangle*2);
   // Draw a rectangle in the worst possible way
   //rect(initialX, initialY, widthLine, heightRectangle);
   //rect(initialX, initialY, widthRectangle, widthLine);
   //rect(initialX + widthRectangle, initialY, widthLine, heightRectangle );
   ////rect(initialX, initialY + heightRectangle, widthRectangle, widthLine  );



   boolean drawLeftToRight = false;
   int gap = 12;
   drawInternalLines(drawLeftToRight, gap, initialX, initialY, widthRectangle, heightRectangle);
   drawInternalLines(!drawLeftToRight, gap, initialXSecondRectangle, initialYSecondRectangle, widthRectangle/2, heightRectangle*2);


   //rect(40,100,4,100);
   //rect(40,100,4,100);
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
      System.out.println("--------");
      System.out.println("X1: " + currentX1 + " Y1:" + currentY1 + " // X2:" + currentX2 + " Y2:" + currentY2 + "///" + corner1 + " " + corner2); 

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
      System.out.println("X1: " + currentX1 + " Y1:" + currentY1 + " // X2:" + currentX2 + " Y2:" + currentY2 + "///" + corner1 + " " + corner2);
      System.out.println("--------");
      line(currentX1, currentY1, currentX2, currentY2);
    }
  }
}


void drawSecondIllusion(PGraphics destination){

  destination.beginDraw();
  destination.loadPixels();
  int initialX = 80;
  int initialY = 100;
  int heightLine = 250;
  int separation = 40;
  strokeWeight(4);
  int inclination = 200, inclination2 = -50, inclination3 = 200;
  pushStyle();
  noFill();
  curve(initialX, initialY - inclination, initialX, initialY + heightLine, initialX + separation * 4, initialY + heightLine, initialX + separation * 4, initialY - inclination);
  curve(initialX, initialY - inclination2, initialX + separation * 1, initialY + heightLine, initialX + separation * 3, initialY + heightLine, initialX + separation * 3, initialY - inclination2);
  //curve(initialX + separation * 2 - 10, initialY, initialX + separation * 2 - 10, initialY + heightLine + 55, initialX + separation * 5, initialY + heightLine, initialX + separation * 5, initialY);
  curve(initialX + separation * 2 - 10, initialY+170, initialX + separation * 2 - 10, initialY + heightLine + 55, initialX + separation * 5, initialY + heightLine, initialX + 50, initialY - 50);


  curve(initialX+ separation * 2 , initialY + inclination3, initialX + separation * 2, initialY + heightLine, initialX + (separation * 3) - (separation / 2), initialY + heightLine + 20, initialX + (separation * 3) - (separation / 2), initialY + 20 + inclination3);
  popStyle();
  pushStyle();
  noFill();
  circle(initialX + separation/2, initialY,  separation );
  circle(initialX + + separation * 2  + separation/2, initialY,  separation );
  circle(initialX + + separation * 4  + separation/2, initialY,  separation );
  popStyle();
  for(int i = 0; i <= 5; i++){
    line(initialX + separation * i, initialY , initialX  + separation * i, initialY + heightLine);
    pushStyle();
    noFill();
    //arc(initialX + separation * i, initialY + heightLine, 200, 200, HALF_PI, PI);

    popStyle();
  }
  destination.endDraw();


}

void createButtons() {
  //Set width of the buttons
  int accumulatedWidth = 10, buttonsGap = 10;
  String[] titleButtons = {"Button 1", "Button 2", "Button 3", "Button 4", "Button 5", "Button 6"};
  int[] widthButtons = {120, 120, 120, 120, 120, 120};

  for (int i = 0; i < TOTAL_BUTTONS; i++) {
    buttons[i] = new Button(titleButtons[i], accumulatedWidth, 5, widthButtons[i], 50);
    accumulatedWidth += buttonsGap + widthButtons[i];
  }
}

void drawAllButtons() {
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].drawButton();
  }
}

void displayAllPgs() {
}


void pgToClear(PGraphics pgToClear) {
  pgToClear.beginDraw();
  pgToClear.loadPixels();
  clearPg(pgToClear);
  pgToClear.updatePixels();
  pgToClear.endDraw();

}

void clearPg(PImage pgToClear) {
  pgToClear.loadPixels();
  loadPixels();
  for (int i = 0; i < pgToClear.pixels.length; i++) {
    pgToClear.pixels[i] = pixels[0];
  }
  pgToClear.updatePixels();
}
