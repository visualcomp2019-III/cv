import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
//2D Vectors for the triangle
Vector v1, v2, v3, point;
//3D Vectors for the coloring of the triangle
Vector c1, c2, c3;
float opacity = 1.0;
float squareSide = 1.0;
// timing
TimingTask spinningTask;

float factor = 1.0;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean shadeHint = false;
boolean antialiasing = false;
int low = -width/2;
int high = width/2;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P2D;

// 4. Window dimension
int dim = 10;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  rectMode(CENTER);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask(scene) {
    @Override
      public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);

  stroke(0, 255, 0);

  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  push();
  scene.applyTransformation(node);
  //scene.drawAxes();
  triangleRaster();
  pop();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
void triangleRaster() {
  boolean clockwise = true;

  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  if (debug) {
    //push();
    //noStroke();
    //fill(255, 0, 0, 125);

    //square(round(node.location(v1).x()), round(node.location(v1).y()), 1);
    //pop();

    float proportion = 1.0;
    for (int x = round(min(v1.x(), v2.x(), v3.x())); x < round(max(v1.x(), v2.x(), v3.x())); ) {
      for (int y = round(min(v1.y(), v2.y(), v3.y())); y < round(max(v1.y(), v2.y(), v3.y())); ) {

        point = new Vector(x, y);
        float[] currentColor = getColorByBarycentricCoordinates(v1, v2, v3, point);
        //println("Curr " + currentColor[1]);
        if (checkIfInside(v1, v2, v3, point, clockwise)) {
          push();
          noStroke();
          if (antialiasing)
          {
            applyAntiAliasing(point, node.magnitude(), clockwise);
            proportion = applyAntiAliasing(point, node.magnitude(), !clockwise);
            fill(color(proportion*currentColor[0], proportion*currentColor[1], proportion*currentColor[2]));
          } else {

            fill(color(currentColor[0], currentColor[1], currentColor[2]));
          }

          square(round(node.location(point).x()), round(node.location(point).y()), squareSide);
          pop();
        }
        if (checkIfInside(v1, v2, v3, point, !clockwise)) {
          push();
          noStroke();
          if (antialiasing)
          {
            proportion = applyAntiAliasing(point, node.magnitude(), !clockwise);
            fill(color(proportion*currentColor[0], proportion*currentColor[1], proportion*currentColor[2]));
          } else {

            fill(color(currentColor[0], currentColor[1], currentColor[2]));
          }
          square(round(node.location(point).x()), round(node.location(point).y()), squareSide);
          pop();
          //println(x + " // " + y);
        }

        y += node.magnitude();
      }
      x += node.magnitude();
    }
  }
}

boolean checkIfSquareInside(Vector point, float squareSide, boolean clockwise) {
  boolean squareTotallyInside = true;
  Vector corner1, corner2, corner3, corner4;
  corner1 = new Vector(point.x() - squareSide / 2.0, point.y() - squareSide / 2.0);
  corner2 = new Vector(point.x() - squareSide / 2.0, point.y() + squareSide / 2.0);
  corner3 = new Vector(point.x() + squareSide / 2.0, point.y() - squareSide / 2.0);
  corner4 = new Vector(point.x() + squareSide / 2.0, point.y() + squareSide / 2.0);
  if (!checkIfInside(v1, v2, v3, corner1, clockwise)) squareTotallyInside = false;
  if (!checkIfInside(v1, v2, v3, corner2, clockwise)) squareTotallyInside = false;
  if (!checkIfInside(v1, v2, v3, corner3, clockwise)) squareTotallyInside = false;
  if (!checkIfInside(v1, v2, v3, corner4, clockwise)) squareTotallyInside = false;


  return squareTotallyInside;
}

float applyAntiAliasing(Vector point, float squareSide, boolean clockwise) {
  boolean inside = checkIfSquareInside(point, squareSide, clockwise);


  //float oldScale = node.magnitude();

  int minX = (int) (point.x() - squareSide / 2.0);
  int maxX = (int) (minX + node.magnitude()*2);
  int minY = (int) (point.y() - squareSide / 2.0);
  int maxY = (int) (minY + node.magnitude()*2);

  int total = 0;
  int counterInside = 0;
  // if (!inside) {
  for (int x = minX; x < maxX; ) {
    // println("x: "  + x + " from  " + minX + " to " + maxX + " factor: " + factor + " counter " + counterInside );
    for (int y = minY; y < maxY; ) {
      // println("y: "  + y + " from  " + minY + " to " + minY + " factor: " + factor + " counter " + counterInside );
      point = new Vector(x, y);
      float[] currentColor = getColorByBarycentricCoordinates(v1, v2, v3, point);
      if (checkIfInside(v1, v2, v3, point, clockwise)) {
        //push();
        //noStroke();
        //fill(color(currentColor[0], currentColor[1], currentColor[2]));
        //square(round(node.location(point).x()), round(node.location(point).y()), 1);
        //pop();
        counterInside++;
      }
      if (checkIfInside(v1, v2, v3, point, !clockwise)) {
        //push();
        //noStroke();
        //fill(color(currentColor[0], currentColor[1], currentColor[2]));
        //square(round(node.location(point).x()), round(node.location(point).y()), 1);
        //pop();
        counterInside++;
      }

      y += (node.magnitude()/factor);
      total++;
    }
    x += (node.magnitude()/factor);
  }
  //println("inside " + counterInside + " total " + total + " proportion " + ((float) counterInside/ (float) total));
  return ((float) counterInside/ (float) total);
  //}
  //return 1.0;
  //node.setScaling(oldScale);
}




float [] getColorByBarycentricCoordinates(Vector v1, Vector v2, Vector v3, Vector point) {
  float areaTriangleV1V2;
  float areaTriangleV2V3;
  float areaTriangleV3V1;

  float lambda1 = 0.0;
  float lambda2 = 0.0;
  float lambda3 = 0.0;

  areaTriangleV1V2 = edgeFunction(node.location(v1), node.location(v2), node.location(point)) ;
  areaTriangleV2V3 = edgeFunction(node.location(v2), node.location(v3), node.location(point)) ;
  areaTriangleV3V1 = edgeFunction(node.location(v3), node.location(v1), node.location(point)) ; 

  float m = (areaTriangleV1V2 + areaTriangleV2V3 + areaTriangleV3V1) / opacity;
  //println("v1v2 " + areaTriangleV1V2 + " v2v0 " + areaTriangleV2V3 + " v0v1 " + areaTriangleV3V1 + " area " + (areaTriangleV1V2 + areaTriangleV2V3 + areaTriangleV3V1) );
  //if(areaTriangleV1V2 >= 0 && areaTriangleV2V3 >= 0 && areaTriangleV3V1 >= 0){
  //if((areaTriangleV1V2 + areaTriangleV2V3 + areaTriangleV3V1) != abs(edgeFunction(v1, v2, v3) / 2.0)) println("Wrong");
  float areaTriangle = abs(edgeFunction(v1, v2, v3) / 2.0);// *2?
  lambda1 = (areaTriangleV1V2) / (areaTriangle);
  lambda2 = (areaTriangleV2V3) / (areaTriangle);
  lambda3 = (areaTriangleV3V1) / (areaTriangle);
  // }


  //  println("lambda1 " + lambda1);
  //  println("lambda2 " + lambda2);
  //  println("lambda3 " + lambda3);
  float r = lambda1 * c1.x() + lambda2 * c2.x() + lambda3 * c3.x(); 
  float g = lambda1 * c1.y() + lambda2 * c2.y() + lambda3 * c3.y(); 
  float b = lambda1 * c1.z() + lambda2 * c2.z() + lambda3 * c3.z(); 

  //println("[ " + (r * 255) + " , " + (g * 255) + ", " + (b * 255) +  "]");

  float [] colorToSet = {(areaTriangleV2V3/m)*255, (areaTriangleV3V1/m)*255, (areaTriangleV1V2/m)*255};
  return colorToSet;
}



Vector sortVectors(Vector v1, Vector v2) {


  float x1 = v1.x();
  float x2 = v2.x();

  float y1 = v1.y();
  float y2 = v2.y();


  if (x2<x1) return v2;
  else if ( x1 == x2) {
    if (y2<y1) return v2;
  }
  return v1;
}
void randomizeTriangle() {
  low = -width/2;
  high = width/2;

  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
  //v1 = new Vector(0, 0);
  //v2 = new Vector(0, -100);
  //v3 = new Vector(100, 0);
  c1 = new Vector(1.0, 0, 0);
  c2 = new Vector(0, 1.0, 0);
  c3 = new Vector(0, 0, 1.0);
  //println(v1);
  //println(v2);
  //println(v3);

  Vector tmp1 = (sortVectors (sortVectors(v1, v2), v3));

  //v1 = new Vector(0, 0);
  //v2 = new Vector(100, 0);
  //v3 = new Vector(0, -100);
  Vector pointTest = new Vector(50, -1);
  //edgeFucntion(v0,v1,p);



  //  System.out.println(v1);
  //  System.out.println(v2);
  //  System.out.println(v3);
}

void drawTriangleHint() {
  push();

  if (shadeHint)
    noStroke();
  else {
    strokeWeight(2);
    noFill();
  }
  beginShape(TRIANGLES);
  if (shadeHint)
    fill(255, 0, 0);
  else
    stroke(255, 0, 0);
  vertex(v1.x(), v1.y());
  if (shadeHint)
    fill(0, 255, 0);
  else
    stroke(0, 255, 0);
  vertex(v2.x(), v2.y());
  if (shadeHint)
    fill(0, 0, 255);
  else
    stroke(0, 0, 255);
  vertex(v3.x(), v3.y());
  endShape();

  strokeWeight(5);
  stroke(255, 0, 0);
  point(v1.x(), v1.y());
  stroke(0, 255, 0);
  point(v2.x(), v2.y());
  stroke(0, 0, 255);
  point(v3.x(), v3.y());

  pop();
}



boolean checkEdgeFunctionCounterClockWise(Vector V0, Vector V1, Vector P) 
{ 
  return (boolean) ((P.x() - V0.x()) * (V1.y() - V0.y()) - (P.y() - V0.y()) * (V1.x() - V0.x()) >= 0);
} 

boolean checkEdgeFunctionClockWise(Vector V0, Vector V1, Vector P) 
{ 
  return (boolean) ((P.x() - V0.x()) * (V1.y() - V0.y()) - (P.y() - V0.y()) * (V1.x() - V0.x()) <= 0);
} 


float edgeFunction(Vector V0, Vector V1, Vector P) 
{ 
  return (P.x() - V0.x()) * (V1.y() - V0.y()) - (P.y() - V0.y()) * (V1.x() - V0.x());
} 

float edgeFunctionII(Vector a, Vector b, Vector c) 
{ 
  return abs(((b.x() - a.x()) * (c.y() - a.y())) - ((c.y() - a.x()) * (b.y() - a.y())));
} 





boolean checkIfInside(Vector V0, Vector V1, Vector V2, Vector P, boolean counterClockWise) {
  if (counterClockWise)
    if (checkEdgeFunctionCounterClockWise(V0, V1, P) && checkEdgeFunctionCounterClockWise(V1, V2, P) && checkEdgeFunctionCounterClockWise(V2, V0, P)) return true;
    else if (checkEdgeFunctionClockWise(V0, V1, P) && checkEdgeFunctionClockWise(V1, V2, P) && checkEdgeFunctionClockWise(V2, V0, P)) return true;
    else return false;
  else return false;
}
void keyPressed() {
  //println(key);
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 's')
    shadeHint = !shadeHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run();
  if (key == 'y')
    yDirection = !yDirection;
  if (key == 'p') {
    System.out.println(point);
    point = new Vector(random(low, high), random(low, high));
    System.out.println(checkIfInside(v1, v2, v3, point, true));
  }
  if (key == 'u') opacity -= 0.1;
  if (key == 'd') opacity += 0.1;
  if (key == 'a') antialiasing = !antialiasing;
  if (key == 'f') factor *= 2.0;
}
