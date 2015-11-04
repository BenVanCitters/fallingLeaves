import java.util.Hashtable;
//***************************************************************
// grid responsible for managing, drawingm and updating all of the
// animated an non animated tiles
//***************************************************************
class GridTiler implements XMLLoadable
{
  protected float[] xAxis = {20,5};
  protected float[] yAxis = {5,20};
  protected float[] origin = {0,0};
  
  //  table of tiles that come from xml
  Hashtable<int[],BaseGridTile> xmlTiles = new Hashtable<int[],BaseGridTile>();
  //table of tile that we generate ourselves
  Hashtable<int[],BaseGridTile> genTiles = new Hashtable<int[],BaseGridTile>();
  //***************************************************************
  // xml - xml object containing serialized object
  //***************************************************************
  public GridTiler(XML xml)
  {
    loadWithXML(xml);
    populateNearbyTiles();
  }
  //***************************************************************
  // graphscale: scale of unit vectors
  // xAxisTheta: radian measurement of the xaxis
  // yAxisTheta: radian measurement of the yaxis
  //***************************************************************
  public GridTiler(float graphScale, float xAxisTheta, float yAxisTheta)
  {
    this(new float[]{width/2.f,height/2.f}, graphScale, xAxisTheta, yAxisTheta);
  }
  
  //***************************************************************
  // origin: 2d vector screen space offset
  // graphscale: scale of unit vectors
  // xAxisTheta: radian measurement of the xaxis
  // yAxisTheta: radian measurement of the yaxis
  //***************************************************************
  public GridTiler(float[] origin, float graphScale, float xAxisTheta, float yAxisTheta)
  {
    this.origin = origin;
    xAxis = new float[]{graphScale*cos(xAxisTheta),
                        graphScale*sin(xAxisTheta)};
  
    yAxis = new float[]{graphScale*cos(yAxisTheta),
                        graphScale*sin(yAxisTheta)}; 
  }

  //***************************************************************
  // populate nearby tiles
  //***************************************************************
  private void populateNearbyTiles()
  {
    int[] dims = {-10,10};
    for(int i = dims[0]; i < dims[1]; i++)
    {
      for(int j = dims[0]; j < dims[1]; j++)
      {
        int[] currentPos={i,j};
        BaseGridTile tmp = xmlTiles.get(currentPos);
        if(tmp == null)
        {
            StaticProceduralTile spt = new StaticProceduralTile(i,j);
            genTiles.put(currentPos,spt);
        } 
        
      }
    }
  }


  //***************************************************************
  // updates all tiles and the grid itself
  //***************************************************************
  void update(float dt)
  { 
    for(BaseGridTile tile : xmlTiles.values())
    {
      tile.update(dt);
    }
    for(BaseGridTile tile : genTiles.values())
    {
      tile.update(dt);
    }
  }

  //***************************************************************
  // draws all tiles and the grid itself
  //***************************************************************
  void draw()
  {
    pushMatrix();
    translate(origin[0],origin[1]);
//    background(255,0,0);
    for(BaseGridTile tile : xmlTiles.values())
    {
      pushMatrix();
      translate(tile.position[0]*xAxis[0] + tile.position[1]*yAxis[0], 
                tile.position[0]*xAxis[1] + tile.position[1]*yAxis[1]);
      tile.draw();
//println("tile.position: " + tile.position[0] + ", " + tile.position[1]);
      popMatrix();
    }
    
    for(BaseGridTile tile : genTiles.values())
    {
      pushMatrix();
      translate(tile.position[0]*xAxis[0] + tile.position[1]*yAxis[0], 
                tile.position[0]*xAxis[1] + tile.position[1]*yAxis[1]);
      tile.draw();
//println("tile.position: " + tile.position[0] + ", " + tile.position[1]);
      popMatrix();
    }
    popMatrix();
  }
 

  //***************************************************************
  // grabs the basis vectors from us
  //***************************************************************
  float[][] getBasisVectors()
  {
    return new float[][]{{xAxis[0],xAxis[1]},{yAxis[0],yAxis[1]}};
  }
  
  //***************************************************************
  // load fresh from disk
  //***************************************************************
  void loadWithXML(XML xml)
  {
    //init properties
    println("XML: Initializing " + this.getClass().getName());
    
    float graphScale = xml.getFloat("scale");
    println("graphScale: " + graphScale);
    
    XML xAxisElem = xml.getChild("xAxis");
    xAxis[0] = xAxisElem.getFloat("x");
    xAxis[1] = xAxisElem.getFloat("y");
    println("xaxis: " + xAxis[0] + ", " + xAxis[1]);

    XML yAxisElem = xml.getChild("yAxis");
    yAxis[0] = yAxisElem.getFloat("x");
    yAxis[1] = yAxisElem.getFloat("y");
    println("yaxis: " + yAxis[0] + ", " + yAxis[1]);

    // apply scaling
    xAxis[0] *= graphScale; xAxis[1] *= graphScale;
    yAxis[0] *= graphScale; yAxis[1] *= graphScale;

    
    XML originElem = xml.getChild("origin");
    origin[0] = originElem.getFloat("x");
    origin[1] = originElem.getFloat("y");
    println("origin: " + origin[0] + ", " + origin[1]);
    
    //create babies!!!
    XML tileXML = xml.getChild("Tiles");
    XML[] tileElems = tileXML.getChildren();
    for(int i = 0; i < tileElems.length; i++)
    {
      XML currentTileXML = tileElems[i];
      String className = currentTileXML.getName();
      BaseGridTile tile = null;
      if(className == "BaseGridTile")
      {  tile = new BaseGridTile(currentTileXML); }
      else if(className == "AnimatedGridTile")
      {  tile = new AnimatedGridTile(currentTileXML); }
      else if(className == "PNGGridTile")
      {  tile = new PNGGridTile(currentTileXML); }
      else if(className == "PNGSequenceGridTile")
      {  tile = new PNGSequenceGridTile(currentTileXML); }
      else if(className == "ProceduralAnimatedGridTile")
      {  tile = new ProceduralAnimatedGridTile(currentTileXML); }
      else if(className == "StaticProceduralTile")
      {  tile = new StaticProceduralTile(currentTileXML); }
      else if(className == "AnimatedGridTile")
      {  tile = new AnimatedGridTile(currentTileXML); }
      else if(className == "RiverTile")
      {  tile = new RiverTile(currentTileXML); }
      else if (className == "#text")
      { /*do nothing empty whitespace nodes.*/}
      else
      {
        println("XML: Error! Encountered unknown tile with class: " + className);
        println("XML: CONTENTS:\n    " + currentTileXML.format(0) + ":ENDCONTENTS");
      }
      if(tile != null)
      {
         xmlTiles.put(new int[]{tile.position[0],tile.position[0]},tile);
      }
    }
  }
}



