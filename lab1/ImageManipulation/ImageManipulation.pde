PImage initialImg; //<>//
PGraphics pgTransformedImg, pgHistogram, pgSegmentation;

Button[] buttons = new Button[7];
Histogram histogram;

final int BUTTON_HEIGHT = 50;
final int IMAGE_LEFT_PADDING = 80;
final int IMAGE_TOP_PADDING = BUTTON_HEIGHT + 20;
int INITIAL_IMG_HEIGHT;
int INITIAL_IMG_WIDTH;

void setup() {
  size(1180, 650);
  smooth();

  initialImg = loadImage("lizzy.png");
  INITIAL_IMG_HEIGHT = initialImg.height;
  INITIAL_IMG_WIDTH = initialImg.width;

  createButtons();
  drawAllButtons();

  pgTransformedImg = createGraphics(INITIAL_IMG_WIDTH, INITIAL_IMG_HEIGHT);
  pgHistogram = createGraphics(INITIAL_IMG_WIDTH, INITIAL_IMG_HEIGHT);
  pgSegmentation = createGraphics(INITIAL_IMG_WIDTH, INITIAL_IMG_HEIGHT);

  image(initialImg, IMAGE_LEFT_PADDING, IMAGE_TOP_PADDING);
}

void draw() {
}

void mouseClicked() {
  clearAllPgs();

  if (buttons[0].mouseIsOver()) {
    displayLumaGrayScale();
  } else if (buttons[1].mouseIsOver()) {
    displayAverageGrayScale();
  } else if (buttons[2].mouseIsOver()) {
    displayHistogram();
  } else if (buttons[3].mouseIsOver()) {
    displaySegmentatedImage();
  } else if (buttons[4].mouseIsOver()) {
    displayEdgeDetectionConvolution();
  } else if (buttons[5].mouseIsOver()) {
    displayGaussianBlurConvolution();
  } else if (buttons[6].mouseIsOver()) {
    displayUnsharpMaskingConvolution();
  }

  displayAllPgs();
}

void createButtons() {
  buttons[0] = new Button("Luma gray scale", 10, 5, 100, BUTTON_HEIGHT);
  buttons[1] = new Button("Average gray scale", 115, 5, 130, BUTTON_HEIGHT);
  buttons[2] = new Button("Display Histogram", 250, 5, 130, BUTTON_HEIGHT);
  buttons[3] = new Button("Segmented Image Histogram", 385, 5, 190, BUTTON_HEIGHT);
  buttons[4] = new Button("Edge detection Convolution", 580, 5, 190, BUTTON_HEIGHT);
  buttons[5] = new Button("Gaussian Blur Convolution", 775, 5, 190, BUTTON_HEIGHT);
  buttons[6] = new Button("Unsharp masking Convolution", 970, 5, 190, BUTTON_HEIGHT);
}

void drawAllButtons() {
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].drawButton();
  }
}

void displayAllPgs() {
  image(pgTransformedImg, IMAGE_LEFT_PADDING, INITIAL_IMG_HEIGHT + IMAGE_TOP_PADDING + 10);
  image(pgHistogram, INITIAL_IMG_WIDTH + IMAGE_LEFT_PADDING + 10, INITIAL_IMG_HEIGHT + IMAGE_TOP_PADDING + 10);
  image(pgSegmentation, IMAGE_LEFT_PADDING, INITIAL_IMG_HEIGHT * 2 + IMAGE_TOP_PADDING + 20);
}

void displayUnsharpMaskingConvolution() {
  int[][] unsharpMaskingKernel = {  
    {1, 4, 6, 4, 1}, 
    {4, 16, 24, 16, 4}, 
    {6, 24, -476, 24, 6}, 
    {4, 16, 24, 16, 4}, 
    {1, 4, 6, 4, 1}, 
  };

  pgTransformedImg.beginDraw();
  convoluteImage(initialImg, pgTransformedImg, unsharpMaskingKernel, -256);
  pgTransformedImg.endDraw();
}

void displayGaussianBlurConvolution() {
  int[][] gaussianBlurKernel = {  
    {1, 2, 1}, 
    {2, 4, 2}, 
    {1, 2, 1}
  };

  pgTransformedImg.beginDraw();
  convoluteImage(initialImg, pgTransformedImg, gaussianBlurKernel, 16);
  pgTransformedImg.endDraw();
}

void displayEdgeDetectionConvolution() {
  int[][] edgeKernel = {  
    {-1, -1, -1}, 
    {-1, 9, -1}, 
    {-1, -1, -1}
  };

  pgTransformedImg.beginDraw();
  convoluteImage(initialImg, pgTransformedImg, edgeKernel, 1);
  pgTransformedImg.endDraw();
}

void displayLumaGrayScale() {
  pgTransformedImg.beginDraw();
  applyLuma(initialImg, pgTransformedImg);
  pgTransformedImg.endDraw();
}

void displayAverageGrayScale() {
  pgTransformedImg.beginDraw();
  applyAverageGrayScale(initialImg, pgTransformedImg);
  pgTransformedImg.endDraw();
}

void displayHistogram() {
  displayLumaGrayScale();

  pgHistogram.beginDraw();
  histogram = new Histogram(pgTransformedImg);
  histogram.generateHistogram();
  histogram.drawHistogramInPg(pgHistogram);
  pgHistogram.endDraw();
}

void displaySegmentatedImage() {
  displayHistogram();

  pgSegmentation.beginDraw();
  segmentateByBrightnessThreshold(pgTransformedImg, pgSegmentation, histogram.getHistogram());
  pgSegmentation.endDraw();
}

void clearAllPgs() {
  pgTransformedImg.beginDraw();
  clearPg(pgTransformedImg);
  pgTransformedImg.endDraw();
  
  pgHistogram.beginDraw();
  clearPg(pgHistogram);
  pgHistogram.endDraw();

  pgSegmentation.beginDraw();
  clearPg(pgSegmentation);
  pgSegmentation.endDraw();
}

void clearPg(PImage pgToClear) {
  pgToClear.loadPixels();
  loadPixels();
  for (int i = 0; i < pgToClear.pixels.length; i++) {
    pgToClear.pixels[i] = pixels[0];
  }
  pgToClear.updatePixels();
}
