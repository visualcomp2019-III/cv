void grayscale(PImage original_image, PGraphics destination){
    
    int average;
    destination.beginDraw();
    destination.loadPixels();

    
    for(int i = 0; i < original_image.pixels.length; i++){
      average = ((int) red(original_image.pixels[i]) + (int) green(original_image.pixels[i]) + (int) blue(original_image.pixels[i]))/3;
      destination.pixels[i] = color(average,average,average);
    }
  destination.updatePixels();
  destination.endDraw();
  
}



int getLocationOfPixel(int x, int y, int input_width) {    
  return x + (y * input_width);
}

int applyLumaInPixel(int pixel) {
  float redP = red(pixel);
  float greenP = green(pixel);
  float blueP = blue(pixel);
  return color(0.2126 * redP + 0.7152 * greenP + 0.0722 * blueP);
}

void applyLuma(PImage initialImg, PImage destionationImg) {
  destionationImg.loadPixels();
  for (int i = 0; i < initialImg.pixels.length; i++) {
    destionationImg.pixels[i] = applyLumaInPixel(initialImg.pixels[i]);
  }
  destionationImg.updatePixels();
}

void applyAverageGrayScale(PImage initialImg, PImage destionationImg) {
  destionationImg.loadPixels();
  int average;
  for (int i = 0; i < initialImg.pixels.length; i++) {
    average = ((int) red(initialImg.pixels[i]) + (int) green(initialImg.pixels[i]) + (int) blue(initialImg.pixels[i]))/3;
    destionationImg.pixels[i] = color(average, average, average);
  }
  destionationImg.updatePixels();
}

void segmentateByBrightnessThreshold(PImage initialImg, PImage destinationImg, int[] histogram) {
  float interval = max(histogram) / 4;
  destinationImg.loadPixels();
  initialImg.loadPixels();

  for (int i = 0; i < initialImg.width; i++) {
    for (int j = 0; j < initialImg.height; j++) {
      int bright = int(brightness(initialImg.get(i, j)));
      if (histogram[bright] > interval && histogram[bright] < interval * 3) {
        destinationImg.pixels[getLocationOfPixel(i, j, initialImg.width)] = initialImg.get(i, j);
      } else {
        destinationImg.pixels[getLocationOfPixel(i, j, initialImg.width)] = color(255);
      }
    }
  }
  destinationImg.updatePixels();
}
