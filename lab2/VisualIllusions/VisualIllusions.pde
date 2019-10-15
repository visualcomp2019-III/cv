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

  pgVisualIlussion = createGraphics(INITIAL_IMG_WIDTH, INITIAL_IMG_HEIGHT);

  createButtons();
  drawAllButtons();

  pg = createGraphics(750, 700);
  hs1 = new HScrollbar(120, 620, 300, 16, 2);
  illusion1 = new Illusion1(pg);
  illusion2 = new Illusion2(pg);
  illusion3 = new Illusion3(pg, 0, 15);
  illusion4 = new Illusion4(pg, 500, 100, 60, 110, 6, color(0), color(200));
  illusion5 = new Illusion5(pg, 200, 200, 150.0, 13);
  illusion6 = new Illusion6(pg);
  image(pg, 50, 120);
}

float speed = frameCount / 150.0;
int points = 13;
void draw() {
  if(currentIllusion == 1){
    illusion1.drawIllusion();
  } else if(currentIllusion == 2){
    illusion2.drawIllusion();
  } else if (currentIllusion == 3) {
    frameRate(illusion3.rate);
    illusion3.setContrast((int)hs1.getPos() / 10);
    illusion3.drawIllusion();
    image(pg, 50, 120);
    stroke(160);
    hs1.update();
    hs1.display();
  } else if (currentIllusion == 4) {
    illusion4.drawIllusion();
  } else if (currentIllusion == 5) {
    illusion5.drawIllusion();
  } else if (currentIllusion == 6) {
    illusion6.drawIllusion();
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

  if (buttons[0].mouseIsOver()) {
    pgToClear(pgVisualIlussion);
    illusion1.drawIllusion();
  } else if (buttons[1].mouseIsOver()) {
    currentIllusion = 2;
  } else if (buttons[2].mouseIsOver()) {
    frameRate(15);
    currentIllusion = 3;
  } else if (buttons[3].mouseIsOver()) {
    illusion4.drawIllusion();
    image(pg, 50, 120);
    currentIllusion = 4;
  } else if (buttons[4].mouseIsOver()) {
    frameRate(60);
    currentIllusion = 5;
  } else if (buttons[5].mouseIsOver()) {
    illusion6.drawIllusion();
  }

  displayAllPgs();
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
