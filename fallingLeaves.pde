
//***************************************************************
//falling leaves app
//***************************************************************
static final boolean DEBUG_MODE = true;
static boolean display_background = true;
static PImage imgBackground = null;
static GridTiler gridTiles;
float lastEndTick = 0;

static boolean edit_mode = false;
static boolean display_leaf_system = true;

static LeafSystem leafs;

FluidMotionReceiver fmr;
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
  
  leafs = new LeafSystem(20, "leafSystem.png", 50);
  
  leafs.spawn();
  
  println("classname: " + super.getClass().getSuperclass());
  fmr = new FluidMotionReceiver(this,"videoFluidSyphon");
}

void drawBackground()
{
  pushMatrix();
  if(DEBUG_MODE)
  { 
    translate(0,width);
    rotate(-PI/2);
  }  
  if (null == imgBackground) {
    imgBackground = loadImage("treeoverlay.png");
  }
  image(imgBackground, 0, 0, width, height);
  
  popMatrix();
}

//***************************************************************
// our looping function called once per tick
// resposible for drawing AND updating... everything
//***************************************************************
void draw()
{
  if(DEBUG_MODE)
  { 
    pushMatrix();
    translate(width,0);
    rotate(PI/2);
  }
  background(50);

  if (display_background) {
    drawBackground();
  }

  float secondsSinceLastUpdate = (millis()-lastEndTick)/1000.f;
  gridTiles.update(secondsSinceLastUpdate);
  gridTiles.draw();
  lastEndTick = millis();
  
  if (DEBUG_MODE) {
    popMatrix();
  }
  
  leafs.draw();
  
  if (edit_mode || display_leaf_system) {
     leafs.displaySpawnData();
  }
  fmr.update();
}

//***************************************************************
// super basic input
//***************************************************************
void mousePressed() {
  int x = mouseX;
  int y = mouseY;
  if (edit_mode) {
    leafs.addSpawnPoint(x, y);
  }
}

void mouseDragged() {
  int x = mouseX;
  int y = mouseY;
  if (edit_mode) {
    leafs.addSpawnPoint(x, y);
  }
}

void saveScreenToPicture()
{
  save("screenCap/fallingLeaves-"+year()+"-"+month()+"-"+day()+":"+hour()+":"+minute()+":"+second()+":"+millis() +".png");
}

void keyPressed()
{
  if ((key == 'p') || (key == 'P')) {
    saveScreenToPicture();
  }
  if ((key == 'g') || (key == 'G')) {
    if(DEBUG_MODE)
      ((GridTool)gridTiles).generateCutouts();
  }
  if ((key == 'b') || (key == 'B')) {
    display_background ^= true;
  }
  if ((key == 'e') || (key == 'E')) {
    if (edit_mode) {
      leafs.finishSpawnMask();
      display_leaf_system = true;
    }
    edit_mode ^= true;
  }
  if ((key == 'l') || (key == 'L')) {
    display_leaf_system ^= true;
  }
}
