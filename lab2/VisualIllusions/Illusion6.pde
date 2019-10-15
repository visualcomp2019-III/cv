// Reference: https://co.pinterest.com/pin/445223113150338449/?nic=1

class Illusion6{
  
  PGraphics destination; 
  Illusion6(PGraphics destination) {
    this.destination = destination;
  }
  
  
  double getRandomIntegerBetweenRange(double min, double max){
    double x = (int)(Math.random()*((max-min)+1))+min;
    return x;
}

  void drawIllusion(){
  
    destination.beginDraw();
    destination.loadPixels();
    int sizeSide = 500;
    int sizeSideSquare = 50;
    int sizeSideLittleSquare = 13;
    int initialX = 50;
    int initialY = 100;
    int counter = 0;
    for(int i = initialX; i <= sizeSide + initialX;){
      for(int j = initialY; j <= sizeSide + initialX;){
        if(counter % 2 == 0) destination.fill(#20AF1E);
        else destination.fill(255);
        destination.square(i,j,sizeSideSquare);
        j += sizeSideSquare;
        counter++;
      }
     i += sizeSideSquare;
     counter++;
    }
    //Drawing internal squares
    for(int i = initialX; i <= sizeSide + initialX - sizeSideSquare;){
      for(int j = initialY; j <= sizeSide + initialX - sizeSideSquare;){
  
        if(getRandomIntegerBetweenRange(1,2) % 2 == 0){ 

          destination.fill(255);
          destination.quad(i + sizeSideSquare, j + sizeSideSquare - sizeSideLittleSquare, i + sizeSideSquare - (sizeSideLittleSquare / 2) , j + sizeSideSquare - (sizeSideLittleSquare / 2), i + sizeSideSquare, j + sizeSideSquare, i + sizeSideSquare + (sizeSideLittleSquare / 2) , j + sizeSideSquare - (sizeSideLittleSquare / 2));
          destination.quad(i + sizeSideSquare, j + sizeSideSquare, i + sizeSideSquare - (sizeSideLittleSquare / 2) , j + sizeSideSquare + (sizeSideLittleSquare / 2), i + sizeSideSquare, j + sizeSideSquare + sizeSideLittleSquare, i + sizeSideSquare + (sizeSideLittleSquare / 2) , j + sizeSideSquare + (sizeSideLittleSquare / 2));

          destination.fill(0);
          destination.quad(i + sizeSideSquare - (sizeSideLittleSquare / 2), j + sizeSideSquare - (sizeSideLittleSquare / 2), i + sizeSideSquare - sizeSideLittleSquare , j + sizeSideSquare, i + sizeSideSquare - (sizeSideLittleSquare / 2), j + sizeSideSquare + (sizeSideLittleSquare / 2), i + sizeSideSquare, j + sizeSideSquare);
          destination.quad(i + sizeSideSquare + (sizeSideLittleSquare / 2), j + sizeSideSquare - (sizeSideLittleSquare / 2), i + sizeSideSquare, j + sizeSideSquare, i + sizeSideSquare + (sizeSideLittleSquare / 2), j + sizeSideSquare + (sizeSideLittleSquare / 2), i + sizeSideSquare + sizeSideLittleSquare, j + sizeSideSquare);

        }  else {
        
          destination.fill(0);
          destination.quad(i + sizeSideSquare, j + sizeSideSquare - sizeSideLittleSquare, i + sizeSideSquare - (sizeSideLittleSquare / 2) , j + sizeSideSquare - (sizeSideLittleSquare / 2), i + sizeSideSquare, j + sizeSideSquare, i + sizeSideSquare + (sizeSideLittleSquare / 2) , j + sizeSideSquare - (sizeSideLittleSquare / 2));
          destination.quad(i + sizeSideSquare, j + sizeSideSquare, i + sizeSideSquare - (sizeSideLittleSquare / 2) , j + sizeSideSquare + (sizeSideLittleSquare / 2), i + sizeSideSquare, j + sizeSideSquare + sizeSideLittleSquare, i + sizeSideSquare + (sizeSideLittleSquare / 2) , j + sizeSideSquare + (sizeSideLittleSquare / 2));
   
      
          destination.fill(255);
          destination.quad(i + sizeSideSquare - (sizeSideLittleSquare / 2), j + sizeSideSquare - (sizeSideLittleSquare / 2), i + sizeSideSquare - sizeSideLittleSquare , j + sizeSideSquare, i + sizeSideSquare - (sizeSideLittleSquare / 2), j + sizeSideSquare + (sizeSideLittleSquare / 2), i + sizeSideSquare, j + sizeSideSquare);
          destination.quad(i + sizeSideSquare + (sizeSideLittleSquare / 2), j + sizeSideSquare - (sizeSideLittleSquare / 2), i + sizeSideSquare, j + sizeSideSquare, i + sizeSideSquare + (sizeSideLittleSquare / 2), j + sizeSideSquare + (sizeSideLittleSquare / 2), i + sizeSideSquare + sizeSideLittleSquare, j + sizeSideSquare);
  
          
        }
       
  
        j += sizeSideSquare;
        counter++;
      }
     i += sizeSideSquare;
     counter++;
    }
    
    
    //destination.updatePixels();
    destination.endDraw();
  
  
  }


}
