void applyAverageGrayScale(PImage original_image, PGraphics destination) {
  int average;
  destination.beginDraw();
  destination.loadPixels();

  for (int i = 0; i < original_image.pixels.length; i++) {
    average = ((int) red(original_image.pixels[i]) + (int) green(original_image.pixels[i]) + (int) blue(original_image.pixels[i]))/3;
    destination.pixels[i] = color(average, average, average);
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

void applyLuma(PImage initialImg, PGraphics destionationImg) {
  destionationImg.beginDraw();
  destionationImg.loadPixels();
  for (int i = 0; i < initialImg.pixels.length; i++) {
    destionationImg.pixels[i] = applyLumaInPixel(initialImg.pixels[i]);
  }
  destionationImg.updatePixels();
  destionationImg.endDraw();
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

void fill_pg(PGraphics pg, PImage original) {
  for (int i = 0; i < pg.pixels.length; i++) {
    pg.pixels[i] = original.pixels[i];
  }
}

int get_location_pixel(int x, int y, int input_width) {    
  return y + (x * input_width);
}

int convolution_in_pixel(float[][] kernel, int initial_x, int initial_y, PImage img) {   
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

void apply_convolution_mask(PImage img, float[][] kernel, PGraphics pg) {
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
}
