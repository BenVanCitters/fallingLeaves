GridTool gridTool;

float lastEndTick = 0;
void setup()
{
//  size(displayWidth,displayHeight);
  size(1024,768,P2D);
  XML xml = loadXML("w");
  
  gridTool = new GridTool(new float[]{},50, PI/3, 2*PI/3.f);
//  initGrid();

}

void draw()
{
  background(50);
  float xRad = mouseX*TWO_PI/width;
  float yRad = mouseY*TWO_PI/height;
  
  gridTool.rebuildGrid(50, xRad, yRad);
  gridTool.update(millis()-lastEndTick);
  gridTool.draw();
  lastEndTick = millis()/1000.f;
}
void mouseClicked()
{
  gridTool.generateCutouts();
}
