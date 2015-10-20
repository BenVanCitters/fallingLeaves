//***************************************************************
// kewl computer graphics!
//***************************************************************
class ProceduralAnimatedGridTile extends AnimatedGridTile
{
  //***************************************************************
  //origin construtor
  //***************************************************************
  public ProceduralAnimatedGridTile(int x, int y)
  {
    super(x,y);
  }
  
  //***************************************************************
  // XML constructor
  //***************************************************************
  public ProceduralAnimatedGridTile(XML xml)
  {
    super(xml);
    loadWithXML(xml);
  }
  
  //***************************************************************
  // actually draw this tile
  //***************************************************************
  public void draw()
  {
    //fill me in
  }
  
  //***************************************************************
  // update tick
  //***************************************************************
  public void update(float dt)
  {
    //fill me in
  }
  
  //***************************************************************
  // load with XML
  //***************************************************************
  void loadWithXML(XML xml)
  {
    println("XML: Initializing " + this.getClass().getName());
  }
}
