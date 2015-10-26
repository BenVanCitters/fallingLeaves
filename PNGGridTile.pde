static HashMap<String, PImage> imageFileCache = new HashMap<String, PImage>();

//***************************************************************
// helper function, checks if the image file has been loaded,
// uses already loaded object iff it has.  Loads file and stores
// it in the hash map if not, and returns it.
//***************************************************************
PImage loadCachedPNGFile(String filename) {
  PImage imageFile;
  if(imageFileCache.containsKey(filename)) {
    imageFile = imageFileCache.get(filename);
  } else {
    imageFile = loadImage(filename);
    imageFileCache.put(filename, imageFile);
  }

  return imageFile;
}

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
    image(img, 0, 0);
  }
  
 
  // <PNGGridTile
 //  file=""
 // >
 // </PNGGridTile>
  //***************************************************************
  // load with XML
  //***************************************************************
  void loadWithXML(XML xml)
  {
    String filename = null;
    super.loadWithXML(xml);
    println("XML: Initializing " + this.getClass().getName());
    filename = xml.getString("file");
    if (null == filename) {
      println("XML: loadWithXML file attribute not found in xml!");
    } else {
      img = loadCachedPNGFile(filename);
    }
  }
}
