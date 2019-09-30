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

  for (int i = 0; i < initialImg.width; i++) {
    for (int j = 0; j < initialImg.height; j++) {
      int bright = int(brightness(initialImg.get(i, j)));
      int colorToApply;
      if (histogram[bright] >= 0 && histogram[bright] < interval) {
        colorToApply = color(255, 0,0);
      } else if (histogram[bright] >= interval && histogram[bright] < interval * 2) {
        colorToApply = color(0, 255,0);
      } else if (histogram[bright] >= interval * 2 && histogram[bright] < interval * 3) {
        colorToApply = color(0, 0, 255);
      } else {
        colorToApply = initialImg.get(i, j);
      }
      
      //if (histogram[bright] > interval && histogram[bright] < interval * 3) {
      //  colorToApply = initialImg.get(i, j);
      //} else {
      //  colorToApply = color(255);
      //}
      
      destinationImg.pixels[getLocationOfPixel(i, j, initialImg.width)] = colorToApply;
    }
  }
  destinationImg.updatePixels();
}

int applyKernelInPixel(PImage initialImg, int[][] kernel, int initialX, int initialY, int divisor) {   
  int redTotal = 0;
  int greenTotal = 0;
  int blueTotal = 0;
  int pixel = 0;
  for (int i = 0; i < kernel.length; i++) {
    for (int j = 0; j < kernel[0].length; j++) {
      pixel = initialImg.pixels[getLocationOfPixel(initialY + j, initialX + i, initialImg.width)];
      redTotal += (red(pixel) * kernel[i][j]) / divisor;
      greenTotal += (green(pixel) * kernel[i][j]) / divisor;
      blueTotal += (blue(pixel) * kernel[i][j]) / divisor;
    }
  }
  return color(redTotal, greenTotal, blueTotal);
}

void convoluteImage(PImage initialImg, PImage destinationImg, int[][] kernel, int divisor) {
  int imgHeight = initialImg.height;
  int imgWidth = initialImg.width;
  int lengthToEdge = kernel.length / 2;

  destinationImg.loadPixels();
  for (int x = lengthToEdge; x < imgHeight - lengthToEdge; x++) {
    for (int y = lengthToEdge; y < imgWidth - lengthToEdge; y++) {
      destinationImg.pixels[getLocationOfPixel(y, x, imgWidth)] = applyKernelInPixel(initialImg, kernel, x - lengthToEdge, y - lengthToEdge, divisor);
    }
  }
  destinationImg.updatePixels();
}
