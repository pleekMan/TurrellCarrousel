class Room {

  PGraphics drawBuffer;
  //PGraphics floorBuffer;

  float rotation;
  float rotationVel;
  int id;

  PVector pos;
  PVector size;

  boolean isActive;
  boolean paused = false;
  boolean changedGraphics = false;

  Room(int _roomID) {

    id = _roomID;

    pos = new PVector();
    size = new PVector();

    drawBuffer = createGraphics((int)galleryRadius * 4, (int)galleryRadius * 4, P2D);
    //floorBuffer = createGraphics(drawBuffer.width, drawBuffer.width, P2D);
  }

  void update() {

    if (!paused)rotation += rotationVel;

    checkActive();
  }
  
  void step(int direction){
    rotationVel = abs(rotationVel) * direction;
    rotation += rotationVel;
  }

  boolean checkActive() {

    if ( (  abs((rotation % TWO_PI)) < abs((slitStart + HALF_PI % TWO_PI)) && abs((rotation % TWO_PI)) > abs((slitEnd % TWO_PI)) )) {
      isActive = true;
      if (!changedGraphics) {
        changeGraphics();
      }
    } else {
      isActive = false;    
      changedGraphics = false;
    }

    return isActive;
  }

  void changeGraphics() {
    drawBuffer.beginDraw();
    drawBuffer.background(0);

    int shapePoints = floor(random(5));
    int limit = int(drawBuffer.width * 0.5);
    drawBuffer.noStroke();
    drawBuffer.fill(random(255), random(255), random(255));

    drawBuffer.rectMode(CENTER);
    drawBuffer.rect(drawBuffer.width * 0.5, drawBuffer.height * 0.5, 100, 100);
    drawBuffer.rectMode(CORNER);

    /*
    drawBuffer.beginShape();
     
     for (int i=0; i < shapePoints; i++) {
     drawBuffer.vertex(drawBuffer.width * 0.5 + random(-limit, limit), drawBuffer.height * 0.5 + random(-limit, limit));
     }
     
     drawBuffer.endShape();
     */


    drawBuffer.endDraw();
    changedGraphics = true;

    println("ARTWORK ON ROOM " + id + " CHANGED");
  }

  void render() {
    fill(0);
    
    pushMatrix();
    //translate(pos.x, pos.y, pos.z);
    rotateY(rotation);

    float wallHalfWidthOffset = (size.z * 0.5) + 0.1;
    // FIRST WALL
    // BOX
    pushMatrix();
    translate(size.x * 0.5, -(size.y * 0.5), 0); // CUZ BOX IS CONSTRUCTED FROM CENTER

    //noFill();
    if(calibrateMode)stroke(255, 255, 0); else{noStroke();}
    box(size.x, size.y, size.z);
    text(id + " | " + nf(abs((rotation % TWO_PI)), 0, 2), size.x * 0.5, -(size.y * 0.5));

    popMatrix();

    // GRAPHICS
    pushMatrix();
    //translate(0, -size.y, (- size.z * 0.5) - 0.1);
    //image(drawBuffer, 0, 0, size.x, size.y);
    PVector topOut = new PVector(size.x, -size.y, -wallHalfWidthOffset); // 0.1 = little off the wall
    PVector topIn = new PVector(wallHalfWidthOffset, -size.y, -wallHalfWidthOffset);
    PVector bottomIn = new PVector(wallHalfWidthOffset, 0, -wallHalfWidthOffset);
    PVector bottomOut = new PVector(size.x, 0, -wallHalfWidthOffset);
    beginShape();
    texture(drawBuffer);
    //vertex(topOut.x, topOut.y, topOut.z, 0, map(mouseY,0,height, 1,0));
    //vertex(topIn.x, topIn.y, topIn.z, 0.5, 0);

    vertex(topOut.x, topOut.y, topOut.z, 0, 0);
    vertex(topIn.x, topIn.y, topIn.z, 0.5, 0);
    vertex(bottomIn.x, bottomIn.y, bottomIn.z, 0.5, 0.5);
    vertex(bottomOut.x, bottomOut.y, bottomOut.z, 0, 1);


    endShape();

    popMatrix();
    // END FIRST WALL

    // SECOND WALL
    //BOX
    pushMatrix();
    rotateY(HALF_PI);

    pushMatrix();
    translate(size.x * 0.5, -(size.y * 0.5), 0); // CUZ BOX IS CONSTRUCTED FROM CENTER

    //noFill();
    //stroke(255, 255, 0);
    box(size.x, size.y, size.z);
    popMatrix();

    // GRAPHICS
    pushMatrix();
    //translate(0, -size.y, (size.z * 0.5) + 0.1);
    //image(drawBuffer, 0, 0, size.x, size.y);

    //float newWallZ = (size.z * 0.5) + 0.1;
    beginShape();
    texture(drawBuffer);
    vertex(topOut.x, topOut.y, wallHalfWidthOffset, 0, 0);
    vertex(topIn.x, topIn.y, wallHalfWidthOffset, 0.5, 0);
    vertex(bottomIn.x, bottomIn.y, wallHalfWidthOffset, 0.5, 0.5);
    vertex(bottomOut.x, bottomOut.y, wallHalfWidthOffset, 0, 1);
    endShape();

    popMatrix();

    popMatrix(); // END SECOND WALL (NEEDS AN ADDITIONAL PUSH/POP)

    // FLOOR
    PVector corner = new PVector(0 + wallHalfWidthOffset, 0, 0 + -wallHalfWidthOffset);
    PVector wall1 = new PVector(size.x, 0, 0 + -wallHalfWidthOffset);
    PVector wall2 = new PVector(0 + wallHalfWidthOffset, 0, -size.x);
    /*
    if (isActive) {
      fill(0, 200, 200);
    } else {
      fill(127);
    }
    */
    beginShape();
    texture(drawBuffer);
    vertex(corner.x, corner.y, corner.z, 0.5, 0.5);
    vertex(wall2.x, wall2.y, wall2.z, 1, 1);
    vertex(wall1.x, wall1.y, wall1.z, 0, 1);
    endShape();


    popMatrix(); // ENDS GLOBAL WALL TRANSFORMS
  }

  void setDirection(int dir) {
    rotationVel *= dir;
  }

  void setRotationVelocity(float vel) {
    rotationVel = vel;
  }

  float getRotationVelocity() {
    return rotationVel;
  }

  void invertRotation() {
    rotationVel *= -1;
  }

  void setWalls(PVector _pos, float radius, float wallHeight, float wallWidth, float initRotation) {
    pos.set(_pos);
    rotation = initRotation;
    size.set(radius, wallHeight, wallWidth);
  }

  PImage getArtWork() {
    return drawBuffer;
  }
}
