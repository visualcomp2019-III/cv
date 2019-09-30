PImage initialImg; //<>//
PGraphics pgTransformedImg, pgHistogram, pgSegmentation;

Button[] buttons = new Button[7];

// Edge detection kernel
int[][] edgeKernel = {  
  {-1, -1, -1}, 
  {-1, 9, -1}, 
  {-1, -1, -1}
};

// Gaussian blur kernel
int[][] gaussianBlurKernel = {  
  {1, 2, 1}, 
  {2, 4, 2}, 
  {1, 2, 1}
};

// Gaussian blur kernel
int[][] unsharpMaskingKernel = {  
  {1, 4, 6, 4, 1},
  {4, 16, 24, 16, 4},
  {6, 24, -476, 24, 6},
  {4, 16, 24, 16, 4},
  {1, 4, 6, 4, 1},
};


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
  
  pgTransformedImg = createGraphics(initialImg.width, initialImg.height);
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
    pgTransformedImg.beginDraw();
    applyLuma(initialImg, pgTransformedImg);
    pgTransformedImg.endDraw();
    image(pgTransformedImg, 10, initialImg.height + 70);
  } else if (buttons[1].mouseIsOver()) {
    pgTransformedImg.beginDraw();
    applyAverageGrayScale(initialImg, pgTransformedImg);
    pgTransformedImg.endDraw();
    image(pgTransformedImg, 10, initialImg.height+70);
  } else if (buttons[2].mouseIsOver()) {
    pgTransformedImg.beginDraw();
    applyAverageGrayScale(initialImg, pgTransformedImg);
    pgTransformedImg.endDraw();
    image(pgTransformedImg, 10, initialImg.height+70);
    pgHistogram.beginDraw();
    Histogram histogram = new Histogram(pgTransformedImg);
    histogram.generateHistogram();
    histogram.drawHistogramInPg(pgHistogram);
    pgHistogram.endDraw();
    image(pgHistogram, initialImg.width+20, initialImg.height+70);
  } else if (buttons[3].mouseIsOver()) {
    pgTransformedImg.beginDraw();
    applyAverageGrayScale(initialImg, pgTransformedImg);
    pgTransformedImg.endDraw();
    image(pgTransformedImg, 10, initialImg.height+70);
    pgHistogram.beginDraw();
    Histogram histogram = new Histogram(pgTransformedImg);
    histogram.generateHistogram();
    histogram.drawHistogramInPg(pgHistogram);
    pgHistogram.endDraw();
    image(pgHistogram, initialImg.width+20, initialImg.height+70);
    pgSegmentation.beginDraw();
    segmentateByBrightnessThreshold(pgTransformedImg, pgSegmentation, histogram.getHistogram());
    pgSegmentation.endDraw();
    image(pgSegmentation, 10, initialImg.height * 2 + 80);
  } else if (buttons[4].mouseIsOver()) {
    pgTransformedImg.beginDraw();
    convoluteImage(initialImg, pgTransformedImg, edgeKernel, 1);
    pgTransformedImg.endDraw();
    image(pgTransformedImg, 10, initialImg.height+70);
  } else if (buttons[5].mouseIsOver()) {
    pgTransformedImg.beginDraw();
    convoluteImage(initialImg, pgTransformedImg, gaussianBlurKernel, 16);
    pgTransformedImg.endDraw();
    image(pgTransformedImg, 10, initialImg.height+70);
  } else if (buttons[6].mouseIsOver()) {
    pgTransformedImg.beginDraw();
    convoluteImage(initialImg, pgTransformedImg, unsharpMaskingKernel, -256);
    pgTransformedImg.endDraw();
    image(pgTransformedImg, 10, initialImg.height+70);
  }
}

void clearPgs() {
  pgTransformedImg.beginDraw();
  pgTransformedImg.clear();
  pgTransformedImg.endDraw();
  pgHistogram.beginDraw();
  pgHistogram.clear();
  pgHistogram.endDraw();

  image(pgTransformedImg, 10, initialImg.height + 70);
  image(pgHistogram, initialImg.width+20, initialImg.height+70);
}
