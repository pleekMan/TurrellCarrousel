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

    drawBuffer = createGraphics((int)galleryRadius * 2, (int)galleryRadius * 2, P2D);
    //floorBuffer = createGraphics(drawBuffer.width, drawBuffer.width, P2D);
  }

  void update() {
    // WALLS BUFFER
    drawBuffer.beginDraw();
    drawBuffer.background(50);

    drawBuffer.translate(drawBuffer.width * 0.5, drawBuffer.height * 0.5);
    drawBuffer.rotate(((sin(frameCount * 0.01) + 1) * 0.5) * TWO_PI);
    drawBuffer.translate(-50, -50);
    drawBuffer.rect(0, 0, drawBuffer.height, drawBuffer.height); // BOTTOM LEFT CORNER

    drawBuffer.endDraw();
    
    
  }

  void render() {

    pushMatrix();
    //translate(pos.x, pos.y, pos.z);
    rotateY(rotation);

    // FIRST WALL
    pushMatrix();
    translate(size.x * 0.5, -(size.y * 0.5), 0); // CUZ BOX IS CONSTRUCTED FROM CENTER

    noFill();
    stroke(255, 255, 0);
    box(size.x, size.y, size.z);
    text(id, size.x * 0.5, -(size.y * 0.5));

    popMatrix();
    
    // GRAPHICS
    pushMatrix();
    translate(0, -size.y, (- size.z * 0.5) - 0.1);
    image(drawBuffer, 0, 0, size.x, size.y);
    popMatrix();
    // END FIRST WALL

    // SECOND WALL
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
    translate(0, -size.y, (size.z * 0.5) + 0.1);
    image(drawBuffer, 0, 0, size.x, size.y);
    popMatrix();
    
    popMatrix(); // END SECOND WALL (NEEDS AN ADDITIONAL PUSH/POP)

    popMatrix(); // ENDS GLOBAL WALL TRANSFORMS
    
    rotation += rotationVel;
  }

  void setDirection(int dir) {
    rotationVel = dir;
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
