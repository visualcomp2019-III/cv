
import processing.video.*; //<>//
Movie video;


void chargeMedia(boolean media, PGraphics canvas) {
  canvas.beginDraw();
  if (media) {
    video = new Movie(this, "0321_presentschristmasclose_720p.mov");
    canvas.image(video, 0, 0, video.height, video.width);
    video.play();
    video.loop();
  } 
  canvas.endDraw();
  image(canvas, 50, 50);
}
void setup() {
chargeMedia(showVideo, canvas_initial);

}

void draw(){
  
  
}
