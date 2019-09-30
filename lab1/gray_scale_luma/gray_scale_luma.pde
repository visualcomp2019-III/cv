PImage initialImg; //<>//
PGraphics pg, pg2, pgLumaImg, pgHistogram, pgSegmentation;

Button[] buttons = new Button[7];

// ----------------------------------------
void setup() {
  size(1180, 1080);
  smooth();

  initialImg = loadImage("../data/lizzy.png");

  buttons[0] = new Button("Luma gray scale", 10, 5, 100, 50);
  buttons[1] = new Button("Average gray scale", 110, 5, 130, 50);
  buttons[2] = new Button("Display Histogram", 240, 5, 130, 50);
  buttons[3] = new Button("Segmentated Image Histogram", 370, 5, 190, 50);
  buttons[4] = new Button("Edge detection Convolution", 560, 5, 190, 50);
  buttons[5] = new Button("Gaussian Blur Convolution", 750, 5, 190, 50);
  buttons[6] = new Button("Unsharp masking Convolution", 940, 5, 190, 50);

  for (int i = 0; i < buttons.length; i++) {
    buttons[i].drawButton();
  }

  pg = createGraphics(initialImg.width, initialImg.height);
  pg2 = createGraphics(initialImg.width, initialImg.height);
  pgLumaImg = createGraphics(initialImg.width, initialImg.height);
  pgHistogram = createGraphics(initialImg.width, initialImg.height);
  pgSegmentation = createGraphics(initialImg.width, initialImg.height);

  image(initialImg, 10, 60);
}

void draw() {
  clearPgs();
}

void mouseClicked() {
  clearPgs();
  if (buttons[0].mouseIsOver()) {
    pg.beginDraw();
    applyLuma(initialImg, pg);
    pg.endDraw();
    image(pg, 10, initialImg.height + 70);
  } else if (buttons[1].mouseIsOver()) {
    pg.beginDraw();
    applyAverageGrayScale(initialImg, pg);
    pg.endDraw();
    image(pg, 10, initialImg.height+70);
  } else if (buttons[2].mouseIsOver()) {
    pg.beginDraw();
    applyAverageGrayScale(initialImg, pg);
    pg.endDraw();
    image(pg, 10, initialImg.height+70);
    pgHistogram.beginDraw();
    Histogram histogram = new Histogram(pg);
    histogram.generateHistogram();
    histogram.drawHistogramInPg(pgHistogram);
    pgHistogram.endDraw();
    image(pgHistogram, initialImg.width+20, initialImg.height+70);
  } else if (buttons[3].mouseIsOver()) {
    pg.beginDraw();
    applyAverageGrayScale(initialImg, pg);
    pg.endDraw();
    image(pg, 10, initialImg.height+70);
    pgHistogram.beginDraw();
    Histogram histogram = new Histogram(pg);
    histogram.generateHistogram();
    histogram.drawHistogramInPg(pgHistogram);
    pgHistogram.endDraw();
    image(pgHistogram, initialImg.width+20, initialImg.height+70);
    pgSegmentation.beginDraw();
    segmentateByBrightnessThreshold(pg, pgSegmentation, histogram.getHistogram());
    pgSegmentation.endDraw();
    image(pgSegmentation, 10, initialImg.height * 2 + 80);
  }
  
}

void clearPgs() {
  pg.beginDraw();
  pg.clear();
  pg.endDraw();
  pgHistogram.beginDraw();
  pgHistogram.clear();
  pgHistogram.endDraw();
  
  image(pg, 10, initialImg.height + 70);
  image(pgHistogram, initialImg.width+20, initialImg.height+70);
}
