/**
 * Code taken from https://blog.startingelectronics.com/a-simple-button-for-processing-language-code/
 */
class Button {
  private String label;
  private float xPosition;    // top left corner xPosition position
  private float yPosition;    // top left corner yPosition position
  private float widthButton;    // width of button
  private float heightButton;    // height of button

  Button(String label, float xPosition, float yPosition, float widthButton, float heightButton) {
    this.label = label;
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    this.widthButton = widthButton;
    this.heightButton = heightButton;
  }

  void drawButton() {
    fill(218);
    stroke(141);
    rect(xPosition, yPosition, widthButton, heightButton, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, xPosition + (widthButton / 2), yPosition + (heightButton / 2));
  }

  boolean mouseIsOver() {
    if (mouseX > xPosition && mouseX < (xPosition + widthButton) 
      && mouseY > yPosition && mouseY < (yPosition + heightButton)) {
      
      return true;
    }
    return false;
  }
}
