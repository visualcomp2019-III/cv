import processing.video.*;

Movie movie_to_process;
PGraphics pgDestination, pgConvolution;
PImage piFrame;
Button[] buttons = new Button[6];
int inputFrameRate = 30, x_position = 10, position_original = 100, offset_destination = 10;
int width_button_0 = 120, width_button_1 = 150, width_button_2 = 180, width_button_3 = 180, width_button_4 = 180, width_button_5 = 180, accumulated = 0, separation_buttons = 10;







// Edge detection kernel


float[][] sharpenKernel = { { -1, -1, -1 }, 
  { -1, 9, -1 }, 
  { -1, -1, -1 } };
float k = 1.0/9;
float[][] blurKernel = { { k, k, k }, 
  { k, k, k }, 
  { k, k, k } };

float [][] edgeKernel = {{-1, -1, -1}, 
  {-1, 8, -1}, 
  {-1, -1, -1}};

float[][] blurKernel5 = { { k, k, k, k, k }, 
  { k, k, k, k, k }, 
  { k, k, k, k, k}, 
  { k, k, k, k, k }, 
  { k, k, k, k, k }, };


void setup() {

  size(1180, 1080);
  smooth();
  accumulated = 10;
  buttons[0] = new Button("Luma gray scale", accumulated, 5, width_button_0, 50);
  accumulated += separation_buttons + width_button_0;
  buttons[1] = new Button("Average gray scale", accumulated, 5, width_button_1, 50);
  accumulated += separation_buttons + width_button_1;
  buttons[2] = new Button("Sharpen kernel convolution", accumulated, 5, width_button_2, 50);
  accumulated += separation_buttons + width_button_2;
  buttons[3] = new Button("Blur kernel convolution", accumulated, 5, width_button_3, 50);
  accumulated += separation_buttons + width_button_3;
  buttons[4] = new Button("Blur kernel 5  Convolution", accumulated, 5, width_button_4, 50);
  accumulated += separation_buttons + width_button_4;
  buttons[5] = new Button("Edge detection Convolution", accumulated, 5, width_button_5, 50);
  accumulated += separation_buttons + width_button_5;

  for (int i = 0; i < buttons.length; i++) {
    buttons[i].drawButton();
  }
  String s = "Click on the filter to capture a frame";


  textSize(32);

  fill(0, 102, 153);
  text(s, 870, 500);
  fill(0, 102, 153, 51);

  System.out.println(frameRate);
  frameRate(inputFrameRate);
  movie_to_process = new Movie(this, "launch2.mp4");
  movie_to_process.frameRate(inputFrameRate);
}



int position_destination = 50;
void draw() {


  clearPgs();
  if (mousePressed==true) {
    System.out.println("j");
  }
  movie_to_process.loop();
  if (movie_to_process.available()) {
    movie_to_process.read();
    pgDestination = createGraphics(movie_to_process.width, movie_to_process.height);
  }


  if (buttons[0].mouseIsOver()) {
    applyLuma(movie_to_process, pgDestination);
    image(pgDestination, x_position, pgDestination.width + offset_destination);
  } else if (buttons[1].mouseIsOver()) {
    applyAverageGrayScale(movie_to_process, pgDestination);
    image(pgDestination, x_position, pgDestination.width + offset_destination);
  } else if (buttons[2].mouseIsOver()) {
    apply_convolution_mask(movie_to_process, sharpenKernel, pgDestination);
    image(pgDestination, x_position, pgDestination.width + offset_destination);
  } else if (buttons[3].mouseIsOver()) {
    apply_convolution_mask(movie_to_process, blurKernel, pgDestination);
    image(pgDestination, x_position, pgDestination.width + offset_destination);
  } else if (buttons[4].mouseIsOver()) {
    apply_convolution_mask(movie_to_process, blurKernel5, pgDestination);
    image(pgDestination, x_position, pgDestination.width + offset_destination);
  } else if (buttons[5].mouseIsOver()) {
    apply_convolution_mask(movie_to_process, edgeKernel, pgDestination);
    image(pgDestination, x_position, pgDestination.width + offset_destination);
  }

  image(movie_to_process, x_position, position_original);
}





void mouseClicked() {
  clearPgs();

  if (buttons[0].mouseIsOver()) {
    applyLuma(movie_to_process, pgDestination);
    image(pgDestination, pgDestination.width + x_position + offset_destination, pgDestination.width + offset_destination);
  } else if (buttons[1].mouseIsOver()) {
    applyAverageGrayScale(movie_to_process, pgDestination);
    image(pgDestination, pgDestination.width + x_position + offset_destination, pgDestination.width + offset_destination);
  } else if (buttons[2].mouseIsOver()) {
    apply_convolution_mask(movie_to_process, sharpenKernel, pgDestination);
    image(pgDestination, pgDestination.width + x_position + offset_destination, pgDestination.width + offset_destination);
  } else if (buttons[3].mouseIsOver()) {
    apply_convolution_mask(movie_to_process, blurKernel, pgDestination);
    image(pgDestination, pgDestination.width + x_position + offset_destination, pgDestination.width + offset_destination);
  } else if (buttons[4].mouseIsOver()) {
    apply_convolution_mask(movie_to_process, blurKernel5, pgDestination);
    image(pgDestination, pgDestination.width + x_position + offset_destination, pgDestination.width + offset_destination);
  } else if (buttons[5].mouseIsOver()) {
    apply_convolution_mask(movie_to_process, edgeKernel, pgDestination);
    image(pgDestination, pgDestination.width + x_position + offset_destination, pgDestination.width + offset_destination);
  }
}

void clearPgs() {
  //pgDestination.beginDraw();
  //pgDestination.clear();
  //pgDestination.endDraw();
  //pgConvolution.beginDraw();
  //pgConvolution.clear();
  //pgConvolution.endDraw();

  //image(pg, 10, initialImg.height + 70);
  //image(pgHistogram, initialImg.width+20, initialImg.height+70);
}
