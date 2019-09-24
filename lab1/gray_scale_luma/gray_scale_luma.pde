import javafx.util.Pair; //<>//
PImage img;  // Declare variable "a" of type PImage
PGraphics pg, pg2, pg3, pgHistogram;
int  hist[];


int get_R(int pixel){
  int R = (pixel & 0x000000FF);
  int G = (pixel & 0x0000FF00) >> 8;
  int B = (pixel & 0x00FF0000) >> 16;
  return R;
}

int get_G(int pixel){
  int R = (pixel & 0x000000FF);
  int G = (pixel & 0x0000FF00) >> 8;
  int B = (pixel & 0x00FF0000) >> 16;
  return G;
}

int get_B(int pixel){
  int R = (pixel & 0x000000FF);
  int G = (pixel & 0x0000FF00) >> 8;
  int B = (pixel & 0x00FF0000) >> 16;
  return B;
}

float apply_luma(int pixel){
  float red = red(pixel);
  float green = green(pixel);
  float blue = blue(pixel);

  return 0.2126 * red + 0.7152 * green + 0.0722 * blue;


}


int [] histogram(PImage img){
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




void drawHistogram(int[] hist, PGraphics pgHist){
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

void segBrightnessThreshold (PImage source, PImage dest, PImage pgHistogram){
//What are we gonna do?
}

// ----------------------------------------
void setup() {
  size(1080, 1080);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("../data/lizzy.jpeg");  // Load the image into the program
  hist = histogram(img);
  //System.out.println(pixels.length);
  //System.out.println(img.pixels.length);
  pg = createGraphics(img.width, img.height);
  pg2 = createGraphics(img.width, img.height);
  pg3 = createGraphics(img.width, img.height);
  pgHistogram = createGraphics(img.width, img.height);
  System.out.println(pg.pixels);



  


  
}





void draw() {
  // Displays the image at its actual size at point (0,0)

  //pg.beginDraw();
   
  //pg.endDraw();
  image(img, 0, 0);
  //image(pg, 0, 0);
  //pg = createGraphics(500, 500);.
    
  pg2.beginDraw();

  int average;
  pg2.loadPixels();
 for(int i = 0; i < img.pixels.length; i++){
    
    //average = (get_R(pg2.pixels[i]) + get_G(pg2.pixels[i]) + get_B(pg2.pixels[i]))/3;
    average = ((int) red(img.pixels[i]) + (int) green(img.pixels[i]) + (int) blue(img.pixels[i]))/3;
    pg2.pixels[i] = color(average,average,average);
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
ellipse(m, 200, 10, 10);

  
  
  image(pgHistogram, 0,2*img.height+2*20);
  pg3.beginDraw();

  
  pg3.loadPixels();
  for(int i = 0; i < img.pixels.length; i++){
    
    pg3.pixels[i] = (int) apply_luma(img.pixels[i]);
    //= img.pixels[i]color(255,15,255);
  }
  pg3.updatePixels();
  pg3.endDraw();
  image(pg3, 0,   2000);
  
  

  
}
