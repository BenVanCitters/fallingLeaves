class AnimatedGridTile extends BaseGridTile
{
  public AnimatedGridTile(int x, int y)
  {
    super(x,y);
  }
  
  public void draw()
  {
    //TODO
  }
  
  public void update(float dt)
  {
    //TODO
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
