import peasy.test.*; //<>//
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam camera;
PVector center;
float rotationVel;
int rotDirection;

//WallGraphic graphic1;
Room[] rooms;
int activeWall;

float galleryRadius;
float galleryHeight;
float slitStart;
float slitEnd;

boolean doRotate;

void setup() {
  size(1024, 768, P3D);
  frameRate(30);
  textureMode(NORMAL);

  camera = new PeasyCam(this, 500);
  camera.setMinimumDistance(10);
  camera.setMaximumDistance(1000);

  center = new PVector(0, 0, 0);
  rotationVel = 0.01;
  activeWall = 0;
  doRotate = true;
  rotDirection = -1;

  galleryRadius = 100;
  galleryHeight = 50;
  slitStart = HALF_PI + QUARTER_PI;
  slitEnd = TWO_PI + QUARTER_PI;

  rooms = new Room[4];
  for (int i=0; i<rooms.length; i++) {
    rooms[i] = new Room(i); 
    rooms[i].setWalls(center, galleryRadius, galleryHeight, 5, HALF_PI*i);
    rooms[i].setRotationVelocity(rotationVel);
    rooms[i].setDirection(rotDirection);
  }
}

void draw() {
  background(25);


  drawCasing();
  
  for (int i=0; i<rooms.length; i++) {
    rooms[i].update();
    rooms[i].render();
  }
  
  drawAxisGizmo(0, -150, 0, 50);

  text(nf(slitStart, 0, 2) + " | " + nf(slitEnd, 0, 2), 0, -60);

  // SHOWING ROOM ARTWORK
  hint(DISABLE_DEPTH_TEST);
  
  for (int i=0; i<rooms.length; i++) {
    image(rooms[i].getArtWork(), -300 + (i * 100),- 200, 100,100);
  }  
  hint(ENABLE_DEPTH_TEST);
}

void drawCasing() {
  // DRAW BASE
  pushMatrix();
  translate(0, 0.5, 0); // NUDGE IT DOWN A LITTLE BIT
  rotateX(HALF_PI);
  stroke(127);
  fill(0);
  ellipse(center.x, center.y, galleryRadius * 2, galleryRadius * 2);
  popMatrix();

  // DRAW TOP PACMAN / SLIT
  pushMatrix();
  translate(0, -0.5, 0); // NUDGE IT UP A LITTLE BIT
  translate(0, -galleryHeight);
  rotateX(HALF_PI);
  stroke(127);
  fill(0);
  arc(center.x, center.y, galleryRadius * 2, galleryRadius * 2, slitStart, slitEnd, PIE);
  popMatrix();


  // DRAW CYLINDER SIDES
  int resolution = 40;
  fill(255, 0, 255);
  stroke(255);
  beginShape(QUAD_STRIP);
  for (int i=0; i<=resolution; i++) {
    float angle = map(i, 0, resolution, slitStart, slitEnd);
    float x = galleryRadius * cos(angle);
    float z = galleryRadius * sin(angle);
    vertex(x, -galleryHeight, z);
    vertex(x, 0, z);
  }
  endShape();
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
    for (int i=0; i<rooms.length; i++) {
      rooms[i].paused = doRotate;
    }
  }

  if (key == 'i') {
    rotDirection *= -1;
    for (int i=0; i<rooms.length; i++) {
      rooms[i].invertRotation();
      //rooms[i].setDirection(rotDirection);
    }
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
