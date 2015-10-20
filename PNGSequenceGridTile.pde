class PNGSequenceGridTile extends AnimatedGridTile
{
  public PNGSequenceGridTile(int x, int y)
  {
    super(x,y);
  }
  //image sequence
  public void draw()
  {
    //fill me in
  }
  
  //update
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
