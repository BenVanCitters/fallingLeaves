//***************************************************************
// directional river tiles!
//***************************************************************
class RiverTile extends ProceduralAnimatedGridTile
{
  protected int[] inDirection;
  protected int[] outDirection;
  
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

  }
  
  //***************************************************************
  // load with XML
  //***************************************************************
  void loadWithXML(XML xml)
  {
    super.loadWithXML(xml);
    int inX = xml.getInt("inX");
    int inY = xml.getInt("inY");
    inDirection = new int[]{inX,inY};
    println("inDirection: " + inX + ", " + inY);
    
    int outX = xml.getInt("outX");
    int outY = xml.getInt("outY");
    outDirection = new int[]{outX,outY};
    println("outDirection: " + outX + ", " + outY);
    
    println("XML: Initializing " + this.getClass().getName());
  }
}
