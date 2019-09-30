import processing.video.*;

Movie movie_to_process;
PGraphics pgGrayScale, pgConvolution;
PImage piFrame;
Button[] buttons = new Button[6];
int inputFrameRate = 30;







void fill_pg(PGraphics pg, PImage original) {
  for (int i = 0; i < pg.pixels.length; i++) {
    pg.pixels[i] = original.pixels[i];
  }
}

int get_location_pixel(int x, int y, int input_width) {    
  return y + (x * input_width);
}

int convolution_in_pixel(int[][] kernel, int initial_x, int initial_y, PImage img) {   
  int redTotal = 0;
  int greenTotal = 0;
  int blueTotal = 0;
  int pixel = 0;
  for (int i = 0; i < kernel.length; i++) {
    for (int j = 0; j < kernel[0].length; j++) {
      pixel = img.pixels[get_location_pixel(initial_x + i, initial_y + j, img.width)];
      redTotal += red(pixel) * kernel[i][j];
      greenTotal += green(pixel) * kernel[i][j];
      blueTotal += blue(pixel) * kernel[i][j];
    }
  }
  return color(redTotal, greenTotal, blueTotal);
}

void apply_convolution_mask(PImage img, int[][] kernel, PGraphics pg) {
  int imgHeight = img.height;
  int imgWidth = img.width;
  int lengthToEdge = kernel.length / 2;
  pg.beginDraw();
  pg.loadPixels();
  for (int x = lengthToEdge; x < imgHeight - lengthToEdge; x++) {
    for (int y = lengthToEdge; y < imgWidth - lengthToEdge; y++) {
      pg.pixels[get_location_pixel(x, y, imgWidth)] = convolution_in_pixel(kernel, x - lengthToEdge, y - lengthToEdge, img);
    }
  }
  
  pg.updatePixels();
  pg.endDraw();
  //image(pg, 0, 500);
}

// Edge detection kernel
int[][] kernel = {  
  {-1, -1, -1}, 
  {-1, 9, -1}, 
  {-1, -1, -1}
};




void setup() {
  
  size(1180, 1080);
  smooth();
  
  buttons[0] = new Button("Luma gray scale", 10, 5, 100, 50);
  buttons[1] = new Button("Average gray scale", 110, 5, 130, 50);
  buttons[2] = new Button("Segmentated Image Histogram", 370, 5, 190, 50);
  buttons[3] = new Button("Edge detection Convolution", 560, 5, 190, 50);
  buttons[4] = new Button("Gaussian Blur Convolution", 750, 5, 190, 50);
  buttons[5] = new Button("Unsharp masking Convolution", 940, 5, 190, 50);

  for (int i = 0; i < buttons.length; i++) {
    buttons[i].drawButton();
  }

  System.out.println(frameRate);
  frameRate(inputFrameRate);
  movie_to_process = new Movie(this, "launch2.mp4");
  movie_to_process.frameRate(inputFrameRate);
  

  
}
int active = 0;



void draw() {
  
  
  clearPgs();
  if(mousePressed==true){
    System.out.println("j");
  }
  movie_to_process.loop();
  if (movie_to_process.available()) {
    movie_to_process.read();
    pgGrayScale = createGraphics(movie_to_process.width, movie_to_process.height);
    //pgConvolution = createGraphics(movie_to_process.width, movie_to_process.height);
  }
  
  
    if (buttons[0].mouseIsOver()) {
  grayscale(movie_to_process, pgGrayScale);
  image(pgGrayScale, 0, 500);
  }else if (buttons[1].mouseIsOver()) {
    apply_convolution_mask(movie_to_process, kernel, pgGrayScale);
    image(pgGrayScale, 0, 500);
  }else if(buttons[5].mouseIsOver()){
    System.out.println("gususu");
    applyLuma(movie_to_process, pgGrayScale);
    image(pgGrayScale, 0, 500);
  }
  
  image(movie_to_process, 0, 100);
  
}





void mouseClicked() {
  clearPgs();
  
  if (buttons[0].mouseIsOver()) {
  if (movie_to_process.available()) {
    movie_to_process.read();
    pgGrayScale = createGraphics(movie_to_process.width, movie_to_process.height);
    pgConvolution = createGraphics(movie_to_process.width, movie_to_process.height);
  }
  grayscale(movie_to_process, pgGrayScale);
  image(movie_to_process, 0, 100);
  image(pgGrayScale, 0, 500);
  } else if (buttons[1].mouseIsOver()) {
    if (movie_to_process.available()) {
      movie_to_process.read();
      pgGrayScale = createGraphics(movie_to_process.width, movie_to_process.height);
      pgConvolution = createGraphics(movie_to_process.width, movie_to_process.height);
    }
    apply_convolution_mask(movie_to_process, kernel, pgConvolution);
    image(movie_to_process, 0, 100);
    image(pgGrayScale, 0, 500);
  }
  //} else if (buttons[2].mouseIsOver()) {
  //  pg.beginDraw();
  //  applyAverageGrayScale(initialImg, pg);
  //  pg.endDraw();
  //  image(pg, 10, initialImg.height+70);
  //  pgHistogram.beginDraw();
  //  Histogram histogram = new Histogram(pg);
  //  histogram.generateHistogram();
  //  histogram.drawHistogramInPg(pgHistogram);
  //  pgHistogram.endDraw();
  //  image(pgHistogram, initialImg.width+20, initialImg.height+70);
  //} else if (buttons[3].mouseIsOver()) {
  //  pg.beginDraw();
  //  applyAverageGrayScale(initialImg, pg);
  //  pg.endDraw();
  //  image(pg, 10, initialImg.height+70);
  //  pgHistogram.beginDraw();
  //  Histogram histogram = new Histogram(pg);
  //  histogram.generateHistogram();
  //  histogram.drawHistogramInPg(pgHistogram);
  //  pgHistogram.endDraw();
  //  image(pgHistogram, initialImg.width+20, initialImg.height+70);
  //  pgSegmentation.beginDraw();
  //  segmentateByBrightnessThreshold(pg, pgSegmentation, histogram.getHistogram());
  //  pgSegmentation.endDraw();
  //  image(pgSegmentation, 10, initialImg.height * 2 + 80);
  //}
  
}

void clearPgs() {
  //pgGrayScale.beginDraw();
  //pgGrayScale.clear();
  //pgGrayScale.endDraw();
  //pgConvolution.beginDraw();
  //pgConvolution.clear();
  //pgConvolution.endDraw();
  
  //image(pg, 10, initialImg.height + 70);
  //image(pgHistogram, initialImg.width+20, initialImg.height+70);
}
