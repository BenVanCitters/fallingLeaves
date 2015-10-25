//***************************************************************
// uses a static png to render a tile
//***************************************************************
class PNGGridTile extends BaseGridTile
{
  //offset to line png up with grid
  float offset[] = {0,0};
  PImage img;
  //***************************************************************
  //origin construtor
  //***************************************************************
  public PNGGridTile(int x, int y)
  {
    super(x,y);
  }
  
  //***************************************************************
  // XML constructor
  //***************************************************************
  public PNGGridTile(XML xml)
  {
    super(xml);
  }
  
  //***************************************************************
  // actually draw a PNG tile
  //***************************************************************
  public void draw()
  {
    //fill me in
  }
  
  //***************************************************************
  // load with XML
  //***************************************************************
  void loadWithXML(XML xml)
  {
    super.loadWithXML(xml);
    println("XML: Initializing " + this.getClass().getName());
  }
}
