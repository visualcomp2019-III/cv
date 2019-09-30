class Histogram {

  private PImage image;
  private int[] generatedHistogram;

  Histogram(PImage image) {
    this.image = image;
  }

  int[] getHistogram() {
    return generatedHistogram;
  }

  /**
   * Calculate the histogram and return 255 size array
   */
  void generateHistogram() {
    int[] newHistogram = new int[256];  
    for (int i = 0; i < image.width; i++) {
      for (int j = 0; j < image.height; j++) {
        int bright = int(brightness(image.get(i, j)));
        newHistogram[bright]++;
      }
    }
    generatedHistogram = newHistogram;
  }

  void drawHistogramInPg(PGraphics pgHistogram) {
    // Find the largest value in the histogram
    int histMax = max(generatedHistogram);
    for (int i = 0; i < pgHistogram.width; i++) {
      int location = int(map(i, 0, pgHistogram.width, 0, 255));
      // Convert the histogram value to a location between 
      // the bottom and the top of the picture
      int y = int(map(generatedHistogram[location], 0, histMax, pgHistogram.height, 0));
      pgHistogram.line(i, pgHistogram.height, i, y);
    }
  }
}
