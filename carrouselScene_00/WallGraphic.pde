class WallGraphic{
  
  PGraphics drawBuffer;
  
  WallGraphic(){
    drawBuffer = createGraphics(300,300,P2D);
  }
  
  
  void update(){
    drawBuffer.beginDraw();
    drawBuffer.background(50);
    
    drawBuffer.translate(0,drawBuffer.height);
    drawBuffer.rotate(((sin(frameCount * 0.01) + 1) * 0.5) * TWO_PI);
    drawBuffer.translate(-100,-100);
    drawBuffer.rect(0,0,200,200); // BOTTOM LEFT CORNER
    drawBuffer.endDraw();

  }
  
  PImage getGraphic(){
   return drawBuffer; 
  }
    
  
  void render(){
    
  }
}
