class BaseGridTile implements XMLLoadable
{
  //the origin coordinates on the grid at which this tile lives
  int[] position;
  public BaseGridTile(int x, int y)
  {
    position = new int[]{x,y};
  }
  
  public void draw()
  {
    
  }
  
  public void update(float dt)
  {
    
  }
  void loadWithXML(XML xml)
  {
    XML[] children = xml.getChildren();

    for (int i = 0; i < children.length; i++) {
      int id = children[i].getInt("id");
      String coloring = children[i].getString("species");
      String name = children[i].getContent();
      println(id + ", " + coloring + ", " + name);
    }
  }
}
