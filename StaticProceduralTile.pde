//***************************************************************
// tile with contents that are procedural but don't animate
//***************************************************************
class StaticProceduralTile extends BaseGridTile
{
  //the size in grid units 
  int size[] = {1,1};

  
  //***************************************************************
  //origin construtor
  //***************************************************************
  public StaticProceduralTile(int x, int y)
  {
    super(x,y);
  }
  
  //***************************************************************
  // XML constructor
  //***************************************************************
  public StaticProceduralTile(XML xml)
  {
    super(xml);
  }
  
  //***************************************************************
  // actually draw this tile
  //***************************************************************
  public void draw()
  {
    //Temporary
    
    float[][] bases = gridTiles.getBasisVectors();
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
  // load with XML
  //***************************************************************
  void loadWithXML(XML xml)
  {
    super.loadWithXML(xml);
    println("XML: Initializing " + this.getClass().getName());
    size = new int[2];
    size[0] = xml.getInt("w");
    size[1] = xml.getInt("h");
    println("size: " + size[0] + ", " + size[1]);
  }
}
