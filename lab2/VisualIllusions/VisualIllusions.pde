// 1 https://michaelbach.de/ot/ang-tiltedTable/index.html

PGraphics pgVisualIlussion;
Button[] buttons = new Button[6];


final int BUTTON_HEIGHT = 50;
final int IMAGE_LEFT_PADDING = 80;
final int IMAGE_TOP_PADDING = BUTTON_HEIGHT + 20;
int INITIAL_IMG_HEIGHT = 500;
int INITIAL_IMG_WIDTH = 500;
//Set width of the buttons
int width_button_0 = 120, width_button_1 = 150, width_button_2 = 180, width_button_3 = 180, width_button_4 = 180, width_button_5 = 180, accumulated = 0, separation_buttons = 10;

void setup() {
  size(1200, 700);
  smooth();

  pgVisualIlussion = createGraphics(INITIAL_IMG_WIDTH, INITIAL_IMG_HEIGHT);

  createButtons();
  drawAllButtons();


}

void draw() {
  
  
}

void mouseClicked() {
  //clearAllPgs();

  if (buttons[0].mouseIsOver()) {
    pgToClear(pgVisualIlussion);
    drawFirstIlussion(pgVisualIlussion);
    
  } else if (buttons[1].mouseIsOver()) {
    pgToClear(pgVisualIlussion);
    drawSecondIllusion(pgVisualIlussion);
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
   destination.fill(255);
   destination.rect(initialX, initialY, widthRectangle, heightRectangle);
   destination.fill(0);
   destination.ellipse(widthRectangle / 2 + initialX, initialY + heightRectangle + (radius / 2) , radius, radius);
   destination.fill(255);
   destination.rect(initialXSecondRectangle, initialYSecondRectangle, widthRectangle/2, heightRectangle*2);
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
void drawInternalLines(boolean orientation, int gap, int initialX, int initialY, int widthRectangle, int heightRectangle){
     int leftGap = gap, rightGap = gap;
     int rest1 = 0, rest2 = 0;
    strokeWeight(4);
     
     
     //False is moving up
     //True is moving right
     boolean corner1 = true;
     boolean corner2 = true;
     //First left: true First right: false
     boolean whichCorner = true;
     if(orientation){
     int currentX1 = initialX;
     int currentY1 = initialY + heightRectangle;
     int currentX2 = currentX1;
     int currentY2 = currentY1;
     
     //False is moving up
     //True is moving right
     
     //First left: true First right: false
     
     while(true){
       
       
       if(currentY1 <= initialY){
         rest1 = initialY - currentY1;
         corner1 = false;
         if(corner2 == false) whichCorner = true;
       }
       
       if(currentX2 >= initialX + widthRectangle){
         rest2 = initialX + widthRectangle - currentX2;
         corner2 = false;
         if(corner1 == false) whichCorner = false;
       }
       
      
       
       if(corner1 && corner2){
         currentY1 -= leftGap;
         currentX2 += rightGap;
         
         
       }
       
       else if(!corner1 && corner2){
         if(rest1 != 0) {
           currentY1 = initialY;
           currentX1 += rest1;
           rest1 = 0;
         }
         currentX1 += leftGap;
         currentX2 += rightGap;
       }
       
       else if(corner1 && !corner2){
          if(rest2 != 0) {
           currentX2 = initialX + widthRectangle;
           currentY2 -= rest2;
           rest2 = 0;
         }
          currentY1 -= leftGap;
          currentY2 -= rightGap;
  
       }
       
       else if(!corner1 && !corner2){  
          
        if(!whichCorner && (rest1 != 0)) {
           currentY1 = initialY;
           currentX1 += rest1;
           rest1 = 0;
        }
        if(whichCorner && (rest2 != 0)){
           currentX2 = initialX + widthRectangle;
           currentY2 -= rest2;
           rest2 = 0;
         }
          currentX1 += leftGap;
          currentY2 -= rightGap;
       }
       
       if((currentX1 >= initialX + widthRectangle) && (currentY2 <= initialY)) break;
       System.out.println("X1: " + currentX1 + " Y1:" + currentY1 + " // X2:" + currentX2 + " Y2:" + currentY2 + "///" + corner1 + " " + corner2); 
       line(currentX1, currentY1, currentX2, currentY2);
     }
   } else {
     int currentX1 = initialX;
     int currentY1 = initialY;
     int currentX2 = currentX1;
     int currentY2 = currentY1;
     
  
          while(true){
            System.out.println("--------");
       System.out.println("X1: " + currentX1 + " Y1:" + currentY1 + " // X2:" + currentX2 + " Y2:" + currentY2 + "///" + corner1 + " " + corner2); 
       
       if(currentY1 >= initialY + heightRectangle){
         rest1 = currentY1 - initialY - heightRectangle;
         corner1 = false;
         if(corner2 == false) whichCorner = true;
       }
       
       if(currentX2 >= initialX + widthRectangle){
         rest2 = currentX2 - initialX - widthRectangle;
         corner2 = false;
         if(corner1 == false) whichCorner = false;
       }
       
      
       
       if(corner1 && corner2){
         currentY1 += leftGap;
         currentX2 += rightGap;
         
         
       }
       
       else if(!corner1 && corner2){
         if(rest1 != 0) {
           currentY1 = initialY + heightRectangle;
           currentX1 += rest1;
           rest1 = 0;
         }
         currentX1 += leftGap;
         currentX2 += rightGap;
       }
       
       else if(corner1 && !corner2){
          if(rest2 != 0) {
           currentX2 = initialX + widthRectangle;
           currentY2 += rest2;
           rest2 = 0;
         }
          currentY1 += leftGap;
          currentY2 += rightGap;
  
       }
       
       else if(!corner1 && !corner2){  
          
        if(!whichCorner && (rest1 != 0)) {
           currentY1 = initialY + heightRectangle;
           currentX1 += rest1;
           rest1 = 0;
        }
        if(whichCorner && (rest2 != 0)){
           currentX2 = initialX + widthRectangle;
           currentY2 -= rest2;
           rest2 = 0;
         }
          currentX1 += leftGap;
          currentY2 += rightGap;
       }
       
       if((currentX1 >= initialX + widthRectangle) && (currentY2 >= initialY + heightRectangle)) break;
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
  
    smooth();
  accumulated = 10;
  buttons[0] = new Button("Tilted table", accumulated, 5, width_button_0, 50);
  accumulated += separation_buttons + width_button_0;
  buttons[1] = new Button("Average gray scale", accumulated, 5, width_button_1, 50);
  accumulated += separation_buttons + width_button_1;
  buttons[2] = new Button("Sharpen kernel convolution", accumulated, 5, width_button_2, 50);
  accumulated += separation_buttons + width_button_2;
  buttons[3] = new Button("Blur kernel convolution", accumulated, 5, width_button_3, 50);
  accumulated += separation_buttons + width_button_3;
  buttons[4] = new Button("Blur kernel 5  Convolution", accumulated, 5, width_button_4, 50);
  accumulated += separation_buttons + width_button_4;
  buttons[5] = new Button("Edge detection Convolution", accumulated, 5, width_button_5, 50);
  accumulated += separation_buttons + width_button_5;

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
