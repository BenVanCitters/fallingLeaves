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
    pushStyle();
    

      fill(255,0,0);
      float[] pos = {random(1),random(1)};
      
//      beginShape(TRIANGLE_STRIP);
//      vertex(0,0);
//      vertex(bases[0][0]*size[0],
//             bases[0][1]*size[0]);       
//             
//      vertex(bases[1][0]*size[1],
//             bases[1][1]*size[1]);
//      vertex(bases[0][0]*size[0] + bases[1][0]*size[1],
//             bases[0][1]*size[0] + bases[1][1]*size[1]); 
//      endShape();
    popStyle();
  }
  
  float[] getDirectionForNormalizedPosition(float[] pos)
  {
    float[][] bases = gridTool.getBasisVectors();
    inDirection ;
    outDirection
    float[] aX = {0,0};
    float[] aY = {0,0}; 
    if(inDirection[0] == 1 && inDirection[1] == 0)
    {
      if(outDirection[0] == 1 && outDirection[0] == 0)
      {
      }
      else if(outDirection[0] == 1 && outDirection[0] == 1)
      {
      } 
      else if(outDirection[0] == 0 && outDirection[0] == 1)
      {
      } 
      aX = new float[]{pos[0]*bases[0][0],pos[1]*bases[0][1]};      
      aY = new float[]{pos[0]*bases[0][0],pos[1]*bases[0][1]};
    }
    

    
    
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
    inDirection = new int[]{1,0};
    outDirection = new int[]{0,1};
    println("XML: Initializing " + this.getClass().getName());
  }
}
