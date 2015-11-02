
class LeafSystem {

  PGraphics pg;
  PImage img = null;
  
  float radius;

  String fileName;

  LeafSystem(float r, String fn){
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
  }
  
  
  void loadLeafSystemFile() {
    File f = new File(fileName);
    
    if (f.exists()) {
      img = loadImage(fileName);
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
  
}
