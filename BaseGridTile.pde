//***************************************************************
// mother of all tiles
//***************************************************************
class BaseGridTile implements XMLLoadable
{
  //the origin coordinates on the grid at which this tile lives
  int[] position = {0,0};
  
  //***************************************************************
  //origin construtor
  //***************************************************************
  public BaseGridTile(int x, int y)
  {
    position = new int[]{x,y};
  }
  
  //***************************************************************
  // XML constructor
  //***************************************************************
  public BaseGridTile(XML xml)
  {
    loadWithXML(xml);
  }
  
  //***************************************************************
  // actually draw this tile - do nothing base call
  //***************************************************************
  public void draw()
  {
    
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
    println("XML: Initializing " + this.getClass().getName());
    position[0] = xml.getInt("x");
    position[1] = xml.getInt("y");
    println("position: " + position[0] + ", " + position[1]);
  }
}
