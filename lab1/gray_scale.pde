PImage img;  // Declare variable "a" of type PImage
PGraphics pg, pg2;

int convolution_mask(int a, int b){
  return 5;
}

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

void setup() {
  size(1080, 1080);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("data/lizzy.png");  // Load the image into the program
  
  //System.out.println(pixels.length);
  //System.out.println(img.pixels.length);
  pg = createGraphics(img.width, img.height);
  pg2 = createGraphics(img.width, img.height);
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

  
}
