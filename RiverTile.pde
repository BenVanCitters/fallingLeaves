static final float jumpHalfLife = 60.0;
static final float fishJumpTime = 1.5;

static final float fishRotationStart = PI/2;
static final float fishRotationEnd = -PI/2;

static int bufX;
static int bufY;


static int bufOffsetX;
static int bufOffsetY;

static int wFishImg;
static int hFishImg;

static int xJumpStart;
static int yJumpStart;

PImage imgMask;
PImage imgFish;

static boolean river_tiles_setup = false;

//***************************************************************
// This function sets up the constants used by the river
//***************************************************************
void setupRiverTiles() {
  println("Initializing river tile constants");
  float[][] bases = gridTiles.getBasisVectors();
  float[][] corners = { {0,0},
                        {bases[0][0], bases[0][1]},
                        {bases[1][0], bases[1][1]},
                        {bases[0][0] + bases[1][0], bases[0][1] + bases[1][1]}
                      };
  float[] bndBox;
    
  float w,h;

  bndBox = getBoundingBox(corners[0], corners[1], corners[2], corners[3]);
  
  bufX = int(bndBox[3]-bndBox[1]);
  bufY = int(bndBox[2]-bndBox[0]);
  

  bufOffsetX = int(bndBox[1]);
  bufOffsetY = int(bndBox[0]);
    
  imgMask = createImage(bufX, bufY, RGB);
  
  for (int y = 0; y < bufY/2; y++) {
    for (int x = 0; x < bufX; x++) {
      imgMask.set(x,y,color(#FFFFFF));
    }  
  }
  
  for (int y = bufY/2; y < bufY; y++) {
    for (int x = 0; x < bufX; x++) {
      imgMask.set(x,y,color(#000000));
    }
  }
  
  imgFish = loadCachedPNGFile("salmongong.png");
  
  w = imgFish.width;
  h = imgFish.height;

  // scale the fish image so it fits under the mask;
  hFishImg = bufX/2;
  wFishImg = int((hFishImg/h)*w);
  
  xJumpStart = bufX/2;
  yJumpStart = 3*bufY/4;
  println("Done initializing river tile constants.");
  river_tiles_setup = true;
}


//***************************************************************
// directional river tiles!
//***************************************************************
class RiverTile extends ProceduralAnimatedGridTile
{
  class Fish {
    
    boolean jumping;
    float t;
    float x;
    float y;
    float rad;
    
    float jumpHeight;
    float jumpDuration;
  
    PGraphics pg;
    PGraphics pgDisplay;
  
    Fish() {
      jumping = false;
      t = 0;
      pg = createGraphics(bufX, bufY);
      pg.imageMode(CENTER);
      pgDisplay = createGraphics(bufX, bufY/2);
    }
    
    void draw() {
      if (true == jumping) {
        pg.beginDraw();
          pg.clear();
          pg.pushMatrix();
            pg.translate(x,y);
            pg.rotate(rad);
            pg.image(imgFish,0,0,wFishImg,hFishImg);
          pg.popMatrix();
        pg.endDraw();
        pgDisplay.beginDraw();
          pgDisplay.clear();
          pgDisplay.copy(pg, 0, 0, bufX, bufY/2, 0, 0, bufX, bufY/2);
        pgDisplay.endDraw();
        image(pgDisplay, 0, 0);
      }
    }
    
    void update(float dt) {
      if (jumping) {
        t += dt;
        y = yJumpStart-(jumpHeight)*sin(PI*t/jumpDuration);
        rad += dt*(fishRotationEnd - fishRotationStart)/jumpDuration;
        if (fishJumpTime <= t) {
          jumping = false;
        }
      } else {
        float p = dt/(2*jumpHalfLife);
        float r = random(1);
        if (r < p) {
          jumping = true;
          t = 0;
          x = xJumpStart;
          y = yJumpStart;
          rad = fishRotationStart;
          float scl = random(0.25,1);
          jumpDuration = scl*fishJumpTime;
          jumpHeight = scl*(bufY/2);
        }        
      }
    }
  }

  protected int[] inDirection;
  protected int[] outDirection;

  Fish fish;
  
  //***************************************************************
  //origin construtor
  //***************************************************************
  public RiverTile(int x, int y)
  {
    super(x,y);
  }
  
  //***************************************************************
  // XML constructor
  //***************************************************************
  public RiverTile(XML xml)
  {
    super(xml);
  }
  
  //***************************************************************
  // actually draw this tile
  //***************************************************************
  public void draw()
  {

    float[][] bases = gridTiles.getBasisVectors();
    pushStyle();
      noStroke();
      fill(100,100,255);
      beginShape(TRIANGLE_STRIP);
      vertex(0,0);
      vertex(bases[0][0],
             bases[0][1]);       
             
      vertex(bases[1][0],
             bases[1][1]);
      vertex(bases[0][0] + bases[1][0],
             bases[0][1] + bases[1][1]); 
      endShape();
      pushMatrix();
        rotate(-PI/2);
        translate(bufOffsetX,bufOffsetY);
        fish.draw();
      popMatrix();      
    popStyle();

    /*
    float[][] bases = gridTiles.getBasisVectors();
    pushStyle();
      noStroke();
      fill(100,100,255);
      beginShape(TRIANGLE_STRIP);
      vertex(0,0);
      vertex(bases[0][0],
             bases[0][1]);       
             
      vertex(bases[1][0],
             bases[1][1]);
      vertex(bases[0][0] + bases[1][0],
             bases[0][1] + bases[1][1]); 
      endShape();
      
      stroke(200,200,255);
      fill(255,0,0);
      
//    println("bases: <" + bases[0][0] + "," + bases[0][1] + "> <" + bases[1][0] + "," + bases[1][1] + ">");
      for(int i = 0; i < 55; i++)
      {      
        float[] pos = {random(1),random(1)};
        float[] dir = getDirectionForNormalizedPosition(pos,bases);
//        println("dir: <" + dir[0] + "," + dir[1] + ">");
        float[] grdSpc = {pos[0]*bases[0][0] + pos[1]*bases[1][0],
                          pos[0]*bases[0][1] + pos[1]*bases[1][1]};
                  
        float factor = .2; dir[0] *= factor; dir[1] *= factor;
        line(grdSpc[0]-dir[0],
             grdSpc[1]-dir[1],
             grdSpc[0]+dir[0],
             grdSpc[1]+dir[1]);
      }

    popStyle();
    */
  }
  
  float[] getDirectionForNormalizedPosition(float[] pos, float[][] bases)
  {
    float[] aX = {0,0};
    float[] aY = {0,0}; 
//    println("inDir: <"+ inDirection[0]+ "," + inDirection[1] + ">");
//    println("outDir: <"+ outDirection[0]+ "," + outDirection[1] + ">");

  if(inDirection[0] == 1 && inDirection[1] == 0)
  {//done!
    aX = new float[]{(1-pos[0])*bases[0][0],(1-pos[0])*bases[0][1]}; 
    if(outDirection[0] == 0 && outDirection[1] == -1){ 
      aY = new float[]{(1-pos[1])*-bases[1][0],(1-pos[1])*-bases[1][1]};
    }
    else if(outDirection[0] == 0 && outDirection[1] == 1){
      aY = new float[]{(pos[1])*bases[1][0],(pos[1])*bases[1][1]};
    }
    else if(outDirection[0] == 1 && outDirection[1] == 0){
      aY = new float[]{0,0};aX = new float[]{bases[0][0],bases[0][1]}; 
    }
    else//degenerate case - same entry and exit
    { 
      aX = new float[]{0,0}; aY = new float[]{0,0};
    }
  }//
  else if(inDirection[0] == -1 && inDirection[1] == 0)
  {//
    aX = new float[]{pos[0]*-bases[0][0],pos[0]*-bases[0][1]}; 
    if(outDirection[0] == 0 && outDirection[1] == -1){
      aY = new float[]{(1-pos[1])*-bases[1][0],(1-pos[1])*-bases[1][1]};
    }//
    else if(outDirection[0] == 0 && outDirection[1] == 1){
      aY = new float[]{(pos[1])*bases[1][0],(pos[1])*bases[1][1]};
    }
    else if(outDirection[0] == -1 && outDirection[1] == 0){
      aY = new float[]{0,0};aX = new float[]{bases[0][0],bases[0][1]};
    }
    else//degenerate case - same entry and exit
    { 
      aX = new float[]{0,0}; aY = new float[]{0,0};
    }
  }//
  else if(inDirection[0] == 0 && inDirection[1] == 1)
  {//
    aY = new float[]{(1-pos[1])*bases[1][0],(1-pos[1])*bases[1][1]};
    if(outDirection[0] == 0 && outDirection[1] == 1){
      aX = new float[]{0,0}; aY = new float[]{bases[1][0],bases[1][1]};
    }
    else if(outDirection[0] == -1 && outDirection[1] == 0){
      aX = new float[]{(1-pos[0])*-bases[0][0],(1-pos[0])*-bases[0][1]};
    }
    else if(outDirection[0] == 1 && outDirection[1] == 0){
      aX = new float[]{(pos[0])*bases[0][0],(pos[0])*bases[0][1]};
    }
    else//degenerate case - same entry and exit
    { 
      aX = new float[]{0,0}; aY = new float[]{0,0};
    }
  }//
  else if(inDirection[0] == 0 && inDirection[1] == -1)
  {//
    aY = new float[]{pos[1]*-bases[1][0],pos[1]*-bases[1][1]};
    if(outDirection[0] == 0 && outDirection[1] == -1){
      aX = new float[]{0,0}; aY = new float[]{bases[1][0],bases[1][1]};
    }
    else if(outDirection[0] == -1 && outDirection[1] == 0){
      aX = new float[]{(1-pos[0])*-bases[0][0],(1-pos[0])*-bases[0][1]};
    }
    else if(outDirection[0] == 1 && outDirection[1] == 0){
      aX = new float[]{pos[0]*bases[0][0],pos[1]*bases[0][1]};
    }
    else{//degenerate case - same entry and exit
     
      aX = new float[]{0,0}; aY = new float[]{0,0};
    }
  }
    //should this be normalized?
    return new float[]{aX[0]+aY[0], aX[1]+aY[1]};
  }
  
  //***************************************************************
  // update tick
  //***************************************************************
  public void update(float dt)
  {
    if (!river_tiles_setup) {
      setupRiverTiles();
    }
    if (null == fish) {
      fish = new Fish();
    }
    fish.update(dt);
  }
  
  //***************************************************************
  // load with XML
  //***************************************************************
  void loadWithXML(XML xml)
  {
    super.loadWithXML(xml);
    
    String from = xml.getString("from");
    println("from: " + from);
    String to = xml.getString("to");
    println("to: " + to);
    if(from.equals("UL")){
      inDirection = new int[]{0,1};
    }else if(from.equals("LL")){
      inDirection = new int[]{-1,0};
    }else if(from.equals("UR")){
      inDirection = new int[]{1,0};
    }else if(from.equals("LR")){
      inDirection = new int[]{0,-1};
    }
      
    if(to.equals("UL")){
      outDirection = new int[]{0,-1};
    }else if(to.equals("LL")){
      outDirection = new int[]{1,0};
    }else if(to.equals("UR")){
      outDirection = new int[]{-1,0};
    }else if(to.equals("LR")){
      outDirection = new int[]{0,1};
    }
    
//    int inX = xml.getInt("inX");
//    int inY = xml.getInt("inY");
//    inDirection = new int[]{inX,inY};
    println("inDirection: " + inDirection[0] + ", " + inDirection[1]);
    
//    int outX = xml.getInt("outX");
//    int outY = xml.getInt("outY");
//    outDirection = new int[]{outX,outY};
    println("outDirection: " + outDirection[0] + ", " + outDirection[1]);
    
    println("XML: Initializing " + this.getClass().getName());
  }
}
