PGraphics pgVisualIlussion;

final int TOTAL_BUTTONS = 6;
Button[] buttons = new Button[TOTAL_BUTTONS];
Button changeOrientation;
Button drawLines;

final int BUTTON_HEIGHT = 50;
int PG_ILLUSION_HEIGHT = 600;
int PG_ILLUSION_WIDTH = 1000;

Illusion1 illusion1;
Illusion2 illusion2;
Illusion3 illusion3;
Illusion4 illusion4;
Illusion5 illusion5;
Illusion6 illusion6;

int currentIllusion = 0;

void setup() {
  size(1200, 700);
  smooth();

  pgVisualIlussion = createGraphics(PG_ILLUSION_WIDTH, PG_ILLUSION_HEIGHT);

  createButtons();
  drawAllButtons();

  illusion1 = new Illusion1(pgVisualIlussion, true, true);
  illusion2 = new Illusion2(pgVisualIlussion);
  illusion3 = new Illusion3(pgVisualIlussion, 0, 15);
  illusion4 = new Illusion4(pgVisualIlussion, 500, 100, 60, 110, 6, color(0), color(200));
  illusion5 = new Illusion5(pgVisualIlussion, 200, 200, 150.0, 13);
  illusion6 = new Illusion6(pgVisualIlussion);
}

int points = 13;
void draw() {
  if (currentIllusion == 1) {
    illusion1.drawIllusion();
  } else if (currentIllusion == 2) {
    illusion2.drawIllusion();
  } else if (currentIllusion == 3) {
    frameRate(illusion3.rate);
    illusion3.drawIllusion();
    image(pgVisualIlussion, 50, 80);
    illusion3.drawScrollbar();
  } else if (currentIllusion == 5) {
    illusion5.drawIllusion();
  } else if (currentIllusion == 6) {
    //illusion6.drawIllusion();
  }
}

void keyPressed() {
  if (currentIllusion == 3) {
    if (keyCode == UP) illusion3.increaseRate(); 
    else if (keyCode == DOWN) illusion3.decrementRate();
  } else   if (currentIllusion == 5) {
    if (keyCode == UP) illusion5.increaseSpeed(); 
    else if (keyCode == DOWN) illusion5.decreaseSpeed();
  }
}

void mouseClicked() {
  currentIllusion = 0;
  pgToClear(pgVisualIlussion);
  frameRate(60);
  if (buttons[0].mouseIsOver()) {
    pgToClear(pgVisualIlussion);
    illusion1.drawIllusion();
    changeOrientation.drawButton();
    drawLines.drawButton();
    currentIllusion = 1;
  } else if (buttons[1].mouseIsOver()) {
    currentIllusion = 2;
  } else if (buttons[2].mouseIsOver()) {
    frameRate(15);
    currentIllusion = 3;
  } else if (buttons[3].mouseIsOver()) {
    frameRate(1);
    illusion4.drawIllusion();
    currentIllusion = 4;
  } else if (buttons[4].mouseIsOver()) {
    currentIllusion = 5;
  } else if (buttons[5].mouseIsOver()) {
    illusion6.drawIllusion();
    currentIllusion = 6;
  }
  if(changeOrientation.mouseIsOver()){
    illusion1.orientation = !illusion1.orientation;
    illusion1.drawIllusion();
    currentIllusion = 1;
  }
    if(drawLines.mouseIsOver()){
    illusion1.drawLines = !illusion1.drawLines;
    illusion1.drawIllusion();
    currentIllusion = 1;
  }
  image(pgVisualIlussion, 50, 80);
}

void createButtons() {
  //Set width of the buttons
  int accumulatedWidth = 10, buttonsGap = 10;
  String[] titleButtons = {"Titled Table", "Devil's Fork", "Reverse Spoke", "Shaded Diamonds", "Kaleidoscope Motion", "Checker illusion"};
  int[] widthButtons = {120, 120, 120, 120, 130, 120};

  for (int i = 0; i < TOTAL_BUTTONS; i++) {
    buttons[i] = new Button(titleButtons[i], accumulatedWidth, 5, widthButtons[i], 50);
    accumulatedWidth += buttonsGap + widthButtons[i];
  }
  
  changeOrientation = new Button("Cambiar orientacion", 850, 5, 150, 50);
  drawLines = new Button("Quitar lineas", 1000, 5, 150, 50);
  
  
}

void drawAllButtons() {
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].drawButton();
  }
  
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
