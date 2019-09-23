PImage img;  // Declare variable "a" of type PImage
PGraphics pg, pg2;


void fill_pg(PGraphics pg, PImage original){
  
   pg.loadPixels();
   for(int i = 0; i < pg.pixels.length; i++){
     pg.pixels[i] = original.pixels[i];
   }
}
//int[][] transpose_matrix(int[][] matrix){
// int[][] transposed;
//  for(int i = 0; i < matrix.length; i++){
//       for(int j = 0; i < matrix[0].length; j++){
//         transposed
//       }
//    }
//}
int get_location_pixel(int x, int y, int input_width){
    
  return x + (y * input_width);
}


void convolution_in_pixel(int[][] kernel, int initial_x, int initial_y, PGraphics pg){
   
   int sum = 0;
   for(int i = 0; i < kernel.length; i++){
     for(int j = 0; j < kernel[0].length; j++){
        sum += pg.pixels[get_location_pixel(initial_x + i, initial_y + j, pg.width)] * kernel[j][i];
     }
   }
   pg.pixels[get_location_pixel(initial_x, initial_y, pg.width)] = sum;

  
}
void apply_convolution_mask(PGraphics pg, int[][] kernel){
   int sum = 0;
   for(int x = 0; x < pg.width - kernel.length-10; x++){
     for(int y = 0; y < pg.height - kernel[0].length-10; y++){
       System.out.println(x);
       System.out.println(y);
        convolution_in_pixel(kernel, x, y, pg);
     }
   }
 
}


int[][] kernel_identity = {  {1,0,-1},
                             {0,0,0},
                             {-1,0,1}};


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


  pg2.beginDraw();

  int average;
  pg2.loadPixels();
  fill_pg(pg2, img);
  apply_convolution_mask(pg2, kernel_identity);
  pg2.updatePixels();
  pg2.endDraw();
  image(pg2, 0, img.height+10);
}

void draw() {
  // Displays the image at its actual size at point (0,0)
  
  //pg.beginDraw();
   
  //pg.endDraw();
  image(img, 0, 0);
  //image(pg, 0, 0);
  //pg = createGraphics(500, 500);.
    


  
}
