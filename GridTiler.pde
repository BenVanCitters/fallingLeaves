class GridTiler
{
  protected float[] xAxis = {20,5};
  protected float[] yAxis = {5,20};
  protected float[] origin = {0,0};
  ArrayList<BaseGridTile> tiles;

  public GridTiler(float graphScale, float xAxisTheta, float yAxisTheta)
  {
    this(new float[]{width/2.f,height/2.f}, graphScale, xAxisTheta, yAxisTheta);
  }
  
  public GridTiler(float[] origin, float graphScale, float xAxisTheta, float yAxisTheta)
  {
    this.origin = origin;
    xAxis = new float[]{graphScale*cos(xAxisTheta),
                        graphScale*sin(xAxisTheta)};
  
    yAxis = new float[]{graphScale*cos(yAxisTheta),
                        graphScale*sin(yAxisTheta)}; 
  }
  

  void update(float dt)
  {
    
  }

  void draw()
  {
//    background(255,0,0);
    
  }
  
  public void loadFromXML(XML xml)
  {
    XML[] children = xml.getChildren();

  for (int i = 0; i < children.length; i++) {
    int id = children[i].getInt("id");
    String coloring = children[i].getString("species");
    String name = children[i].getContent();
    println(id + ", " + coloring + ", " + name);
  }
    
   //this.getClass().getName(); 
  }

}



