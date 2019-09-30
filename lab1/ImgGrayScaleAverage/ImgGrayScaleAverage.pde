PImage img;
PGraphics pg;

void transformImgToGrayScale() {
  pg.loadPixels();
  int average;
  for (int i = 0; i < img.pixels.length; i++) {
    average = ((int) red(img.pixels[i]) + (int) green(img.pixels[i]) + (int) blue(img.pixels[i]))/3;
    pg.pixels[i] = color(average, average, average);
  }
  pg.updatePixels();
}

void setup() {
  size(800, 650);
  img = loadImage("../data/lizzy.jpeg");  // Load the image into the program
  pg = createGraphics(img.width, img.height);
  
  // Displays the image at its actual size at point (0,0)
  image(img, 0, 0);

  pg.beginDraw();  
  transformImgToGrayScale();
  pg.endDraw();
  image(pg, 0, img.height+10);
}
