//***************************************************************
//falling leaves app
//***************************************************************

GridTool gridTool;
float lastEndTick = 0;

//***************************************************************
// called to set everything up
//***************************************************************
void setup()
{
//  size(displayWidth,displayHeight);
  size(1024,768,P2D); //we will probably be dealing with a 1024x768 native res projector - that's what most are
  
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
  float xRad = mouseX*TWO_PI/width;
  float yRad = mouseY*TWO_PI/height;
  
  gridTool.rebuildGrid(50, xRad, yRad);
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
  gridTool.generateCutouts();
}
