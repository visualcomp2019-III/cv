
//import processing.video.*;


//PGraphics canvas_initial;
//PGraphics canvas_trans;

//Movie video;

//int initialFrameRate = 60;

//boolean showVideo = true;


//void movieEvent(Movie m) {
//  m.read();
//}


//void chargeMedia(boolean media, PGraphics canvas) {
//  canvas.beginDraw();
//  if (media) {
//    video = new Movie(this, "transit.mov");
//    canvas.image(video, 0, 0, video.height, video.width);
//    video.play();
//    video.loop();
//  } 
//  canvas.endDraw();
//  image(canvas, 510, 510);
//}
//void setup() {
//   size(1000, 1000);
//  background(0);
//    canvas_initial = createGraphics(1960, 1540);
//    chargeMedia(showVideo, canvas_initial);
    
//}

//void draw(){
//    if (video.available()) {
//    pushStyle();
//    stroke(255);
//    rectMode(CORNER);
//    fill(255);
//    rect(50, 500, 900, 40);
//    popStyle();

//    String frameRateText = "Eficiencia Computacional "+ frameRate/initialFrameRate*100 + "%";
//    textSize(18);
//    text(frameRateText, 50, 520);
//    video.read();
//    canvas_initial.beginDraw();
//    canvas_initial.image(video, 0, 0, 750, 450);
//    canvas_initial.endDraw();
//    image(canvas_initial, 50, 50);
    
//  }
  
//}






  
  
import processing.video.*;
Movie myMovie;
PGraphics pgFrame, pgConvolution;
PImage piFrame;





void grayscale(PImage original_image, PGraphics destination, int j){
    
    int average;
    destination.beginDraw();
    destination.loadPixels();
    //System.out.println("Destination pixels");
    //System.out.println(original_image.pixels.length);
    //System.out.println(destination.pixels.length);
    
    for(int i = 0; i < original_image.pixels.length; i++){
      average = ((int) red(original_image.pixels[i]) + (int) green(original_image.pixels[i]) + (int) blue(original_image.pixels[i]))/3;
      destination.pixels[i] = color(average,average,average);
    }
  destination.updatePixels();
  destination.endDraw();
  image(pgFrame, 0, 500+j+j);
  
}



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
  image(pg, 0, 500);
}

// Edge detection kernel
int[][] kernel = {  
  {-1, -1, -1}, 
  {-1, 9, -1}, 
  {-1, -1, -1}
};




void setup() {
  size(1200, 1200);
  System.out.println(frameRate);
  frameRate(30);
 
  myMovie = new Movie(this, "lizzy.mp4");
  
  System.out.println(myMovie.width);
  System.out.println(myMovie.height);
  myMovie.frameRate(60);
  myMovie.loop();
  System.out.println(myMovie.width);
  System.out.println(myMovie.height);
  
    
    
      
  
 
  
  

  
}

void draw() {
  if (myMovie.available()) {

    myMovie.read();
      pgFrame = createGraphics(myMovie.width, myMovie.height);
      pgConvolution = createGraphics(myMovie.width, myMovie.height);
    System.out.println(frameRate);
  }
 //grayscale(myMovie, pgFrame, 30);
 
   apply_convolution_mask(myMovie, kernel, pgConvolution);
  image(myMovie, 0, 0);
}
