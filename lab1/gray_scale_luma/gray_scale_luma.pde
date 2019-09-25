import javafx.util.Pair; //<>//
PImage img;  // Declare variable "a" of type PImage
PGraphics pg, pg2, pg3, pgHistogram, pgSegmentation;
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
  
    for (int x = 0; x < hist.length; x++){
   //System.out.println(hist[x] + " " + max(hist)); 
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

int get_location_pixel(int x, int y, int input_width) {    
  return x + (y * input_width);
}

float average_histogram(int[] histogram){
   float sum = 0; 
   for(int i = 0; i < histogram.length; i++){
       sum += histogram[i];
   }
   return sum/histogram.length;
}

void segmentateByBrightnessThreshold (PImage source, PImage dest, PImage pgHistogram, int[] histogram, PImage black_white){
    float interval = max(histogram)/4;
   // System.out.print(max(histogram));
    
    //int start = 0;
    //int end = interval;
    //int start2= interval*3;
    //int end2 = 255;
    dest.loadPixels();
    source.loadPixels();
    black_white.loadPixels();
    //System.out.println("Pixels " + dest.pixels.length + " PixelsImg: " + source.pixels.length); 
    for (int i = 0; i < source.width; i++) {
      for (int j = 0; j < source.height; j++) {
        int bright = int(brightness(source.get(i, j)));
        //System.out.println("Bright: " + bright);
        //System.out.println("i: " + i + " j: " + j + " " + dest.width + " " + dest.height);
        //System.out.println("Loc: " + get_location_pixel(i,j,img.width));
        //if((bright >= start && bright <= end ) ||(bright >= start2 && bright <= end2)){
        //   dest.pixels[get_location_pixel(i,j,img.width)] = color(0);
        //}else{
        //  dest.pixels[get_location_pixel(i,j,img.width)] = black_white.pixels[get_location_pixel(i,j,img.width)];
        //} 
        if(histogram[bright] > interval*2 && histogram[bright] < interval * 3){
           dest.pixels[get_location_pixel(i,j,img.width)] = color(0);
        }else{
          dest.pixels[get_location_pixel(i,j,img.width)] = color(255);//black_white.pixels[get_location_pixel(i,j,img.width)];
        } 
      }
    }
  dest.updatePixels();
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
   pgSegmentation = createGraphics(img.width, img.height);
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


  pgSegmentation.beginDraw();
  hist = histogram(pg2);
  segmentateByBrightnessThreshold(img, pgSegmentation, pgHistogram, hist, pg2);

  pgSegmentation.endDraw();
  image(pgSegmentation, 0, img.height+10);
  
  
  float value = 25;
  float m = map(value, 0, 100, 0, width);

  image(pgHistogram, img.width+2*20, 0);
  pg3.beginDraw();
  applyLumaInImg();
  pg3.endDraw();
  image(pg3, 0, 2*img.height+20);
}
