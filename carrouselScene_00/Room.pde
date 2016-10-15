class Room {

  PGraphics drawBuffer;
  //PGraphics floorBuffer;
  
  float rotation;
  float rotationVel;
  int id;

  PVector pos;
  PVector size;

  Room(int _roomID) {

    id = _roomID;

    pos = new PVector();
    size = new PVector();

    drawBuffer = createGraphics((int)galleryRadius * 4, (int)galleryRadius * 4, P2D);
    //floorBuffer = createGraphics(drawBuffer.width, drawBuffer.width, P2D);
  }

  void update() {
    // WALLS BUFFER
    drawBuffer.beginDraw();
    drawBuffer.background(50);

    /* ROTATING SQUARE
    drawBuffer.translate(drawBuffer.width * 0.5, drawBuffer.height * 0.5);
    drawBuffer.rotate(((sin(frameCount * 0.01) + 1) * 0.5) * TWO_PI);
    drawBuffer.translate(-50, -50);
    drawBuffer.rect(0, 0, 100,100); // BOTTOM LEFT CORNER
    */

    drawBuffer.endDraw();
    
    
  }

  void render() {

    pushMatrix();
    //translate(pos.x, pos.y, pos.z);
    rotateY(rotation);

    float wallHalfWidthOffset = (size.z * 0.5) + 0.1;
    // FIRST WALL
    // BOX
    pushMatrix();
    translate(size.x * 0.5, -(size.y * 0.5), 0); // CUZ BOX IS CONSTRUCTED FROM CENTER

    noFill();
    stroke(255, 255, 0);
    box(size.x, size.y, size.z);
    text(id, size.x * 0.5, -(size.y * 0.5));

    popMatrix();
    
    // GRAPHICS
    pushMatrix();
    //translate(0, -size.y, (- size.z * 0.5) - 0.1);
    //image(drawBuffer, 0, 0, size.x, size.y);
    PVector topOut = new PVector(size.x,-size.y,-wallHalfWidthOffset); // 0.1 = little off the wall
    PVector topIn = new PVector(wallHalfWidthOffset,-size.y,-wallHalfWidthOffset);
    PVector bottomIn = new PVector(wallHalfWidthOffset,0,-wallHalfWidthOffset);
    PVector bottomOut = new PVector(size.x, 0, -wallHalfWidthOffset);
    beginShape();
    texture(drawBuffer);
    vertex(topOut.x, topOut.y,topOut.z,0,0);
    vertex(topIn.x, topIn.y,topIn.z, 0.5,0);
    vertex(bottomIn.x, bottomIn.y, bottomIn.z, 0.5,0.5);
    vertex(bottomOut.x, bottomOut.y, bottomOut.z,0,1);
    endShape();
    
    popMatrix();
    // END FIRST WALL

    // SECOND WALL
    //BOX
    pushMatrix();
    rotateY(HALF_PI);
    
    pushMatrix();
    translate(size.x * 0.5, -(size.y * 0.5), 0); // CUZ BOX IS CONSTRUCTED FROM CENTER

    noFill();
    stroke(255, 255, 0);
    box(size.x, size.y, size.z);
    popMatrix();
    
    // GRAPHICS
    pushMatrix();
    //translate(0, -size.y, (size.z * 0.5) + 0.1);
    //image(drawBuffer, 0, 0, size.x, size.y);
    
    float newWallZ = (size.z * 0.5) + 0.1;
    beginShape();
    texture(drawBuffer);
    vertex(topOut.x, topOut.y,wallHalfWidthOffset,0,0);
    vertex(topIn.x, topIn.y,wallHalfWidthOffset, 0.5,0);
    vertex(bottomIn.x, bottomIn.y, wallHalfWidthOffset, 0.5,0.5);
    vertex(bottomOut.x, bottomOut.y, wallHalfWidthOffset,0,1);
    endShape();
    
    popMatrix();
    
    popMatrix(); // END SECOND WALL (NEEDS AN ADDITIONAL PUSH/POP)
    
    // FLOOR
    PVector corner = new PVector(0 + wallHalfWidthOffset,0,0 + -wallHalfWidthOffset);
    PVector wall1 = new PVector(size.x, 0, 0 + -wallHalfWidthOffset);
    PVector wall2 = new PVector(0 + wallHalfWidthOffset,0, -size.x);
    fill(0,200,200);
    beginShape();
    texture(drawBuffer);
    vertex(corner.x,corner.y,corner.z,0.5,0.5);
    vertex(wall2.x,wall2.y, wall2.z,1,1);
    vertex(wall1.x, wall1.y, wall1.z,0,1);
    endShape();
    

    popMatrix(); // ENDS GLOBAL WALL TRANSFORMS
    
    rotation += rotationVel;
  }

  void setDirection(int dir) {
    rotationVel *= dir;
  }

  void setRotationVelocity(float vel) {
    rotationVel = vel;
  }

  void setWalls(PVector _pos, float radius, float wallHeight, float wallWidth, float initRotation) {
    pos.set(_pos);
    rotation = initRotation;
    size.set(radius, wallHeight, wallWidth);
  }
}
