PImage img;
PGraphics pg;

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
      redTotal += red(pixel) * kernel[i][j] / (-256);
      greenTotal += green(pixel) * kernel[i][j] / (-256);
      blueTotal += blue(pixel) * kernel[i][j] / (-256);
    }
  }
  return color(redTotal, greenTotal, blueTotal);
}

void apply_convolution_mask(PImage img, int[][] kernel) {
  int imgHeight = img.height;
  int imgWidth = img.width;
  int lengthToEdge = kernel.length / 2;
  for (int x = lengthToEdge; x < imgHeight - lengthToEdge; x++) {
    for (int y = lengthToEdge; y < imgWidth - lengthToEdge; y++) {
      pg.pixels[get_location_pixel(x, y, imgWidth)] = convolution_in_pixel(kernel, x - lengthToEdge, y - lengthToEdge, img);
    }
  }
}

// Gaussian blur kernel
int[][] kernel = {  
  {1, 4, 6, 4, 1},
  {4, 16, 24, 16, 4},
  {6, 24, -476, 24, 6},
  {4, 16, 24, 16, 4},
  {1, 4, 6, 4, 1},
};

void setup() {
  size(800, 800);
  img = loadImage("../data/lizzy.jpeg");

  pg = createGraphics(img.width, img.height);

  image(img, 0, 0);

  pg.beginDraw();
  pg.loadPixels();
  apply_convolution_mask(img, kernel);
  pg.updatePixels();
  pg.endDraw();
  image(pg, 0, img.height+10);
}
