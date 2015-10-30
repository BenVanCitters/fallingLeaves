
class LeafSystem {
  class Pair {
    int x;
    int y;
    
    Pair(int ix, int iy) {
      x = ix;
      y = iy;
    }
  }

  ArrayList<Pair> leafSpawnPts;

  float radius;

  LeafSystem(float r){
    leafSpawnPts = new ArrayList<Pair>();
    radius = r;
  }
  
  void addSpawnPoint(int x, int y) {
    Pair ptSpwn = new Pair(x,y);
    
    leafSpawnPts.add(ptSpwn);
  }
  
  void displaySpawnData(){
    color c = color(255, 255, 0, 64);
    fill(c);
    noStroke();
    for (Pair p : leafSpawnPts) {
      ellipse(p.x,p.y,radius,radius);
    }
  }
}
