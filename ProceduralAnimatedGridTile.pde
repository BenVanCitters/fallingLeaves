class ProceduralAnimatedGridTile extends AnimatedGridTile
{
  public ProceduralAnimatedGridTile()
  {
    //fill me in
  }
  
  public void draw()
  {
    //fill me in
  }
  
  public void update(float dt)
  {
    //fill me in
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
