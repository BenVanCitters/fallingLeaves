//***************************************************************
//falling leaves app
//***************************************************************
static final boolean DEBUG_MODE = true;
static GridTiler gridTiles;
float lastEndTick = 0;

//***************************************************************
// called to set everything up
//***************************************************************
void setup()
{
  if(DEBUG_MODE)
  { size(600,800,P2D); }
  else
  { size(800,600,P2D); }//we are dealing with a 800x600 native res projector
  
  XML xml = loadXML("GridTiler.xml");
  if(DEBUG_MODE)
  { gridTiles = new GridTool(xml);}//new float[]{width/2,height/2},50, PI/3, 2*PI/3.f);
  else
  { gridTiles = new GridTiler(xml); }
 
  gridTiles.loadWithXML(xml);
}

//***************************************************************
// our looping function called once per tick
// resposible for drawing AND updating... everything
//***************************************************************
void draw()
{
  if(DEBUG_MODE)
  { 
    translate(width,0);
    rotate(PI/2);
  }
  background(50);

  float secondsSinceLastUpdate = (millis()-lastEndTick)/1000.f;
  gridTiles.update(secondsSinceLastUpdate);
  gridTiles.draw();
  lastEndTick = millis();
}

//***************************************************************
// super basic input
//***************************************************************
void mouseClicked()
{
  if(DEBUG_MODE)
    ((GridTool)gridTiles).generateCutouts();
}
