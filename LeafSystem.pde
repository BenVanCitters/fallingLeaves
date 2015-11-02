
class LeafSystem {

  class Point {    
    float x;
    float y;
    
    Point(float ix, float iy) {
      x = ix;
      y = iy;
    }
  }
  
  class Leaf {
    Point pt;
    PImage img;
    
    Leaf(Point ipt, PImage iimg) {
      pt = ipt;
      img = iimg;
    }
    
    void draw() {
      image(img, pt.x, pt.y, 50, 50);
    }
  }
  
  ArrayList<Point> leafSpawnPts;
  
  PGraphics pg;
  PImage img = null;
  
  PImage[] leafImages;
  
  Leaf[] leaves;
  
  float radius;

  String fileName;

  LeafSystem(float r, String fn, int cntLeaves){

    leafSpawnPts = new ArrayList<Point>();

    fileName = dataPath(fn);
    loadLeafSystemFile();
    
    pg = createGraphics(width, height);
    pg.beginDraw();
    if (null == img) {
      pg.background(color(0),0);
    } else {
      pg.background(img);
    }
    pg.fill(color(255,255,0));
    pg.noStroke();
    pg.endDraw();
    radius = r;
    
    leaves = new Leaf[cntLeaves];
    loadLeafImages();
  }
  
  void ingestLeafData() {
    img.loadPixels();
    for (int i = 0; i < img.width; i++) {
      for (int j = 0; j < img.height; j++) {
        if (0 != img.pixels[i *img.width + j]) {
          //println("adding spawnpoint " + i + "," + j);
          leafSpawnPts.add(new Point(j, i)); // I don't know why these are reveresed...
        }
      }
    }
  }
  
  void loadLeafSystemFile() {
    File f = new File(fileName);
    
    if (f.exists()) {
      // here we don't use the image cache,
      // because this file can be saved and reloaded.
      img = loadImage(fileName);
      ingestLeafData();
    }
  }

  void saveLeafSystemFile() {
    pg.save(fileName);
    loadLeafSystemFile();
    pg.beginDraw();
    pg.clear();
    pg.background(img);    
    pg.endDraw();
  }

  void loadLeafImages() {
    leafImages = new PImage[4];
    leafImages[0] = loadCachedPNGFile("leaf1.png");
    leafImages[1] = loadCachedPNGFile("leaf2.png");
    leafImages[2] = loadCachedPNGFile("leaf3.png");
    leafImages[3] = loadCachedPNGFile("leaf4.png");
  }

  void addSpawnPoint(int x, int y) {
    pg.beginDraw();
    pg.ellipse(x, y, radius, radius);
    pg.endDraw();
  }
  
  void finishSpawnMask() {
    pg.beginDraw();
    for (int i = 0; i < pg.width; i++) {
      for (int j = 0; j < pg.height; j++) {
        color c = pg.get(i,j);
        if (0 != alpha(c)) {
          pg.set(i,j, color(red(c),green(c),blue(c),64));
        }
      }
    }
    pg.endDraw();
    saveLeafSystemFile();
  }
  
  void displaySpawnData(){
    image(pg, 0, 0);
  }
  
  void spawn() {
    for (int i = 0; i < leaves.length; i++) {
      Point p = leafSpawnPts.get(int(random(leafSpawnPts.size())));
      PImage leafImg = leafImages[int(random(leafImages.length))];
      leaves[i] = new Leaf(p, leafImg);
    }
  }
  
  void draw() {
    //println("drawing leaves.");
    imageMode(CENTER);
    for (Leaf l : leaves) {
      l.draw();
    }
    imageMode(CORNER);
  }
  
  void update(float dt) {
    
  }
}
