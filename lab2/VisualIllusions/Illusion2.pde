class Illusion2 {

  PGraphics destination; 
  Illusion2(PGraphics destination) {
    this.destination = destination;
  }

  void drawIllusion() {
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


    curve(initialX+ separation * 2, initialY + inclination3, initialX + separation * 2, initialY + heightLine, initialX + (separation * 3) - (separation / 2), initialY + heightLine + 20, initialX + (separation * 3) - (separation / 2), initialY + 20 + inclination3);
    popStyle();
    pushStyle();
    noFill();
    circle(initialX + separation/2, initialY, separation );
    circle(initialX + + separation * 2  + separation/2, initialY, separation );
    circle(initialX + + separation * 4  + separation/2, initialY, separation );
    popStyle();
    for (int i = 0; i <= 5; i++) {
      line(initialX + separation * i, initialY, initialX  + separation * i, initialY + heightLine);
      pushStyle();
      noFill();
      //arc(initialX + separation * i, initialY + heightLine, 200, 200, HALF_PI, PI);

      popStyle();
    }
    destination.endDraw();
  }
}
