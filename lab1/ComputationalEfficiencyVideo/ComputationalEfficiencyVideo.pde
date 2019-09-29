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

void applyGrayScale(PImage originalImage, PGraphics destination, int j) {
  int average = 0;
  destination.beginDraw();
  destination.loadPixels();
  int[] imgPixels = originalImage.pixels;
  for (int i = 0; i < imgPixels.length; i++) {
    average = ((int) red(imgPixels[i]) + (int) green(imgPixels[i]) + (int) blue(imgPixels[i])) / 3;
    destination.pixels[i] = color(average, average, average);
  }
  destination.updatePixels();
  destination.endDraw();
  image(pgFrame, 0, originalImage.height + 5);
}

int getLocationPixel(int x, int y, int input_width) {    
  return y + (x * input_width);
}

int applyConvolutionToPixel(int[][] kernel, int initialX, int initialY, PImage originalImage) {   
  int redTotal = 0;
  int greenTotal = 0;
  int blueTotal = 0;
  int pixel = 0;
  for (int i = 0; i < kernel.length; i++) {
    for (int j = 0; j < kernel[0].length; j++) {
      pixel = originalImage.pixels[getLocationPixel(initialX + i, initialY + j, originalImage.width)];
      redTotal += red(pixel) * kernel[i][j];
      greenTotal += green(pixel) * kernel[i][j];
      blueTotal += blue(pixel) * kernel[i][j];
    }
  }
  return color(redTotal, greenTotal, blueTotal);
}

void applyConvolutionMask(PImage originalImage, int[][] kernel, PGraphics pg) {
  int imgHeight = originalImage.height;
  int imgWidth = originalImage.width;
  int lengthToEdge = kernel.length / 2;
  pg.beginDraw();
  pg.loadPixels();
  for (int x = lengthToEdge; x < imgHeight - lengthToEdge; x++) {
    for (int y = lengthToEdge; y < imgWidth - lengthToEdge; y++) {
      pg.pixels[getLocationPixel(x, y, imgWidth)] = applyConvolutionToPixel(kernel, x - lengthToEdge, y - lengthToEdge, originalImage);
    }
  }
  pg.updatePixels();
  pg.endDraw();
  image(pg, 0, imgHeight + 5);
}

// Edge detection kernel
int[][] kernel = {  
  {-1, -1, -1}, 
  {-1, 9, -1}, 
  {-1, -1, -1}
};

void setup() {
  size(1000, 800);
  frameRate(60);

  myMovie = new Movie(this, "transit.mov");
  myMovie.frameRate(60);
  myMovie.loop();
}

void draw() {
  if (myMovie.available()) {
    myMovie.read();
    pgFrame = createGraphics(myMovie.width, myMovie.height);
    pgConvolution = createGraphics(myMovie.width, myMovie.height);
    System.out.println(myMovie.frameRate/30*100);
    System.out.println(frameRate);
  }
  //applyGrayScale(myMovie, pgFrame, 30);
  String frameRateText = "Eficiencia Computacional "+ frameRate/30*100 + "%";
  fill(0);
  textSize(12);
  text(frameRateText, myMovie.width, 60);

  image(myMovie, 0, 0);  
  applyConvolutionMask(myMovie, kernel, pgConvolution);
}
