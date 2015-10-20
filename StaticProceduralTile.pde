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
    loadWithXML(xml);
  }
  
  //***************************************************************
  // actually draw this tile
  //***************************************************************
  public void draw()
  {
    //TODO
    fill(255,0,0);
    ellipse(0,0,100,100);
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
