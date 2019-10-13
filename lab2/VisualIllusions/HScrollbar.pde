/**
 * Class taken from https://processing.org/examples/scrollbar.html
 */

class HScrollbar {
  float initialXPosition;
  int barWidth, barHeight;    // width and height of bar
  float barXPosition, barYPosition;       // x and y position of bar
  float sliderPosition, newSliderPosition;    // x position of slider
  float sliderPositionMin, sliderPositionMax; // max and min values of slider
  int heaviness;              // how heaviness/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float barXPosition, float barYPosition, int barWidth, int barHeight, int heaviness) {
    this.barWidth = barWidth;
    this.barHeight = barHeight;
    int widthtoheight = barWidth - barHeight;
    ratio = (float) barWidth / (float) widthtoheight;
    this.barXPosition = barXPosition;
    this.barYPosition = barYPosition - barHeight / 2;
    sliderPosition = barXPosition;
    initialXPosition = barXPosition;
    newSliderPosition = sliderPosition;
    sliderPositionMin = barXPosition;
    sliderPositionMax = barXPosition + barWidth - barHeight;
    this.heaviness = heaviness;
  }

  void update() {
    if (isOver()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newSliderPosition = constrain(mouseX - barHeight / 2, sliderPositionMin, sliderPositionMax);
    }
    if (abs(newSliderPosition - sliderPosition) > 1) {
      sliderPosition = sliderPosition + (newSliderPosition - sliderPosition) / heaviness;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean isOver() {
    if (mouseX > barXPosition && mouseX < barXPosition + barWidth &&
      mouseY > barYPosition && mouseY < barYPosition + barHeight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    //pg.beginDraw();
    fill(204);
    rect(barXPosition, barYPosition, barWidth, barHeight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(sliderPosition, barYPosition, barHeight, barHeight);
    //pg.endDraw();
  }

  float getPos() {
    // Convert sliderPosition to be values between
    // 0 and the total width of the scrollbar
    return (sliderPosition - initialXPosition) * ratio;
  }
}
