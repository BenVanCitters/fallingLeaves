//***************************************************************
//falling leaves app
//***************************************************************

static GridTiler gridTool;
float lastEndTick = 0;

//***************************************************************
// called to set everything up
//***************************************************************
void setup()
{
//  size(displayWidth,displayHeight);
  size(800,600,P2D); //we are dealing with a 800x600 native res projector 
  
  gridTool = new GridTool(new float[]{width/2,height/2},50, PI/3, 2*PI/3.f);
  XML xml = loadXML("GridTiler.xml");
  gridTool.loadWithXML(xml);
}

//***************************************************************
// our looping function called once per tick
// resposible for drawing AND updating... everything
//***************************************************************
void draw()
{
  background(50);
  float xRad = PI/6.f;//mouseX*TWO_PI/width;
  float yRad = -PI/6.f;//mouseY*TWO_PI/height;
  
  ((GridTool)gridTool).rebuildGrid(50, xRad, yRad);
  float secondsSinceLastUpdate = (millis()-lastEndTick)/1000.f;
  gridTool.update(secondsSinceLastUpdate);
  gridTool.draw();
  lastEndTick = millis();
}

//***************************************************************
// super basic input
//***************************************************************
void mouseClicked()
{
  ((GridTool)gridTool).generateCutouts();
}
