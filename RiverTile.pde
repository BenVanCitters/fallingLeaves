class RiverTile extends ProceduralAnimatedGridTile
{
  float[] inDirection;
  float[] outDirection;
  
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
    //fill me in
    float[][] bases = gridTool.getBasisVectors();
    pushStyle();
      fill(255,0,0);
      noStroke();
      beginShape(TRIANGLE_STRIP);
      vertex(0,0);
      vertex(bases[0][0]*size[0],
             bases[0][1]*size[0]);       
             
      vertex(bases[1][0]*size[1],
             bases[1][1]*size[1]);
      vertex(bases[0][0]*size[0] + bases[1][0]*size[1],
             bases[0][1]*size[0] + bases[1][1]*size[1]); 
      endShape();
    popStyle();
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
    inDirection = new float[]{1,0};
    outDirection = new float[]{0,1};
    println("XML: Initializing " + this.getClass().getName());
  }
}
