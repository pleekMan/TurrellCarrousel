import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam camera;
PVector center;
float rotationVel;
float rotDirection;

//WallGraphic graphic1;
Room room1;
int activeWall;

float galleryRadius;
float galleryHeight;

boolean doRotate;

void setup() {
  size(1024, 768, P3D);
  frameRate(30);

  camera = new PeasyCam(this, 500);
  camera.setMinimumDistance(10);
  camera.setMaximumDistance(1000);

  center = new PVector(0, 0, 0);
  rotationVel = 0.02;
  //graphic1 = new WallGraphic();

  galleryRadius = 100;
  galleryHeight = 50;

  room1 = new Room(0);
  room1.setDirection(1);
  room1.setWalls(center, galleryRadius, galleryHeight, 5, 0);
  room1.setRotationVelocity(rotationVel);

  activeWall = 0;
  doRotate = true;
  rotDirection = 1;
}

void draw() {
  background(25);


  //graphic1.update();
  drawTops();
  room1.update();
  room1.render();

  //drawWalls(center, 100, 50, 5);
  drawAxisGizmo(0, 0, 0, 50);

  //text(nf(carrouselRotation  % TWO_PI,0,2),0, -60);
  //image(graphic1.getGraphic(), 0, -100);

}


void drawWalls(PVector pos, float radius, float wallHeight, float wallWidth) {

  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  rotateY(rotationVel);

  // WALL 0
  pushMatrix();
  translate(radius * 0.5, -(wallHeight * 0.5), 0); // CUZ BOX IS CONSTRUCTED FROM CENTER

  noFill();
  stroke(255, 255, 0);
  box(radius, wallHeight, wallWidth);
  text("0", radius * 0.5, -(wallHeight * 0.5));

  popMatrix();

  // WALL 1
  pushMatrix();
  rotateY(HALF_PI);
  translate(radius * 0.5, -(wallHeight * 0.5), 0);

  noFill();
  stroke(255, 255, 0);
  box(radius, wallHeight, wallWidth);
  text("1", radius * 0.5, -(wallHeight * 0.5));

  popMatrix();

  // WALL 2  
  pushMatrix();
  rotateY(PI);
  translate(radius * 0.5, -(wallHeight * 0.5), 0);

  noFill();
  stroke(255, 255, 0);
  box(radius, wallHeight, wallWidth);
  text("2", radius * 0.5, -(wallHeight * 0.5));

  popMatrix();

  // WALL 3  
  pushMatrix();
  rotateY(PI + HALF_PI);
  translate(radius * 0.5, -(wallHeight * 0.5), 0);

  noFill();
  stroke(255, 255, 0);
  box(radius, wallHeight, wallWidth);
  text("3", radius * 0.5, -(wallHeight * 0.5));

  popMatrix();

  popMatrix();

  // DRAW BASE
  pushMatrix();
  translate(0, 1, 0); // NUDGE IT DOWN A LITTLE BIT
  rotateX(HALF_PI);
  stroke(127);
  fill(0);
  ellipse(pos.x, pos.y, radius * 2, radius * 2);
  popMatrix();

  // DRAW TOP PACMAN
  pushMatrix();
  translate(0, -1, 0); // NUDGE IT UP A LITTLE BIT
  translate(0, -wallHeight);
  rotateX(HALF_PI);
  stroke(127);
  fill(0);
  arc(pos.x, pos.y, radius * 2, radius * 2, HALF_PI + QUARTER_PI, TWO_PI + QUARTER_PI, PIE);
  popMatrix();

  /*
  int cylinderRes = 20;
   beginShape(TRIANGLE_FAN);
   vertex(0,0,0);
   for(int i=0; i<cylinderRes;i++){
   vertex()
   }
   endShape(CLOSE);
   */
}

void drawTops() {
  // DRAW BASE
  pushMatrix();
  translate(0, 1, 0); // NUDGE IT DOWN A LITTLE BIT
  rotateX(HALF_PI);
  stroke(127);
  fill(0);
  ellipse(center.x, center.y, galleryRadius * 2, galleryRadius * 2);
  popMatrix();

  // DRAW TOP PACMAN
  pushMatrix();
  translate(0, -1, 0); // NUDGE IT UP A LITTLE BIT
  translate(0, -galleryHeight);
  rotateX(HALF_PI);
  stroke(127);
  fill(0);
  arc(center.x, center.y, galleryRadius * 2, galleryRadius * 2, HALF_PI + QUARTER_PI, TWO_PI + QUARTER_PI, PIE);
  popMatrix();
}

public void drawAxisGizmo(float x, float y, float z, float gizmoSize) {
  pushMatrix();
  translate(x, y, z);

  // X
  fill(255, 0, 0);
  stroke(255, 0, 0);
  line(0, 0, 0, gizmoSize, 0, 0);
  box(gizmoSize * 0.2);

  // Y
  stroke(0, 255, 0);
  line(0, 0, 0, 0, gizmoSize, 0);

  // Z
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, gizmoSize);

  popMatrix();
} 




void keyPressed() {
  if (key == ' ') {
    doRotate = !doRotate;
    if (doRotate) {
      room1.setRotationVelocity(rotationVel);
    } else {
      room1.setRotationVelocity(0);
    }
  }

  if (key == 'i') {
    rotDirection *= -1;
  }
}

void mousePressed() {
}

void mouseReleased() {
}

void mouseClicked() {
}

void mouseDragged() {
}

void mouseWheel(MouseEvent event) {
  //float e = event.getAmount();
  //println(e);
}
