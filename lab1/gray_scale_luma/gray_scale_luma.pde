import javafx.util.Pair; //<>//
PImage img;  // Declare variable "a" of type PImage
PGraphics pg, pg2, pg3, pgHistogram;
int  hist[];

int [] histogram(PImage img) {
  int[] hist = new int[256];
  // Calculate the histogram
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      int bright = int(brightness(img.get(i, j)));
      hist[bright]++;
    }
  }
  return hist;
}

void drawHistogram(int[] hist, PGraphics pgHist) {
  // Find the largest value in the histogram
  int histMax = max(hist);

  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < pgHist.width; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, pgHist.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, pgHist.height, 0));
    pgHist.line(i, pgHist.height, i, y);
  }
}

int applyLumaInPixel(int pixel) {
  float redP = red(pixel);
  float greenP = green(pixel);
  float blueP = blue(pixel);
  return color(0.2126 * redP + 0.7152 * greenP + 0.0722 * blueP);
}

void applyLumaInImg(){
  pg3.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    pg3.pixels[i] = applyLumaInPixel(img.pixels[i]);
  }
  pg3.updatePixels();
}

void segBrightnessThreshold (PImage source, PImage dest, PImage pgHistogram) {
  //What are we gonna do?
}

// ----------------------------------------
void setup() {
  size(1400, 1080);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("../data/ejem.png");  // Load the image into the program
  hist = histogram(img);
  //System.out.println(pixels.length);
  //System.out.println(img.pixels.length);
  pg = createGraphics(img.width, img.height);
  pg2 = createGraphics(img.width, img.height);
  pg3 = createGraphics(img.width, img.height);
  pgHistogram = createGraphics(img.width, img.height);
    // Displays the image at its actual size at point (0,0)

  //pg.beginDraw();

  //pg.endDraw();
  image(img, 0, 0);
  //image(pg, 0, 0);
  //pg = createGraphics(500, 500);.

  pg2.beginDraw();

  int average;
  pg2.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {

    average = ((int) red(img.pixels[i]) + (int) green(img.pixels[i]) + (int) blue(img.pixels[i]))/3;
    pg2.pixels[i] = color(average, average, average);
    //= img.pixels[i]color(255,15,255);
  }
  pg2.updatePixels();
  pg2.endDraw();

  image(pg2, 0, img.height+10);

  pgHistogram.beginDraw();

  drawHistogram(hist, pgHistogram);

  pgHistogram.endDraw();

  float value = 25;
  float m = map(value, 0, 100, 0, width);

  image(pgHistogram, img.width+2*20, 0);
  pg3.beginDraw();
  applyLumaInImg();
  pg3.endDraw();
  image(pg3, 0, 2*img.height+20);
}
