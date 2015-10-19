float[] xAxis = {20,5};
float[] yAxis = {5,20};

void setup()
{
//  size(displayWidth,displayHeight);
  size(1024,768,P2D);
//  initGrid(50, PI/3, 2*PI/3.f);
}

void draw()
{
  background(50);
  float xRad = mouseX*TWO_PI/width;
  float yRad = mouseY*TWO_PI/height;
  initGrid(50, xRad, yRad);
//  generateCutouts();
}

void initGrid(float graphScale, float xAxisTheta, float yAxisTheta)
{
  xAxis = new float[]{graphScale*cos(xAxisTheta),
                      graphScale*sin(xAxisTheta)};

  yAxis = new float[]{graphScale*cos(yAxisTheta),
                      graphScale*sin(yAxisTheta)}; 
  renderGrid();
}

void renderGrid()
{
  int graphRange[] = {-20,20};
   pushMatrix();
   translate(width/2,height/2);
  //draw x axis markers
  stroke(0,255,0);
  for(int i = graphRange[0]; i < graphRange[1]+1; i++)
  {
    beginShape();
      vertex( yAxis[0] * i + graphRange[0] * xAxis[0], 
              yAxis[1] * i + graphRange[0] * xAxis[1]);
              
      vertex( yAxis[0] * i + graphRange[1] * xAxis[0], 
              yAxis[1] * i + graphRange[1] * xAxis[1]);
    endShape();
  }
  //draw y axis markers
  stroke(255,0,0);
  for(int i = graphRange[0]; i < graphRange[1]+1; i++)
  {
    beginShape();
      vertex( xAxis[0] * i + graphRange[0] * yAxis[0], 
              xAxis[1] * i + graphRange[0] * yAxis[1]);
              
      vertex( xAxis[0] * i + graphRange[1] * yAxis[0], 
              xAxis[1] * i + graphRange[1] * yAxis[1]);
    endShape();
  }
  
  //draw Labels
  stroke(0);
  fill(0);
  textSize(10);
  for(int i = graphRange[0]; i < graphRange[1]+1; i++)
  {
//    translate(xAxis[0]*i,xAxis[1]*i);
    for(int j = graphRange[0]; j < graphRange[1]+1; j++)
    {
      String posString = ""+ i + "," + j; 
      text(posString, (i+.5)*xAxis[0]+(j+.5)*yAxis[0], 
                   (i+.5)*xAxis[1]+(j+.5)*yAxis[1]); 
    }
  }
  popMatrix();
}

ArrayList<PGraphics> buffers = new ArrayList<PGraphics>();
void generateCutouts()
{
  buffers.clear();
  for(int x = 1; x  <= 3; x++)
  {
    for(int y = 1; y <= 3; y++)
    {
      // c    d
      // 
      // a    b
      float[] a = new float[]{ 0 * xAxis[0] + 0 * yAxis[0], 
                               0 * xAxis[1] + 0 * yAxis[1]};
                               
      float[] b = new float[]{ x * xAxis[0] + 0 * yAxis[0], 
                               x * xAxis[1] + 0 * yAxis[1]};
                               
      float[] c = new float[]{ 0 * xAxis[0] + y * yAxis[0], 
                               0 * xAxis[1] + y * yAxis[1]};
                               
      float[] d = new float[]{ x * xAxis[0] + y * yAxis[0], 
                               x * xAxis[1] + y * yAxis[1]};
      float[] boundingBox = getBoundingBox(a,b,c,d);
//      println("boundingBox: [" +  boundingBox[0] + ", " + boundingBox[1] + ", " + boundingBox[2] + ", " + boundingBox[3] + "]");
      int[] bufferDims = {(int)(boundingBox[2]-boundingBox[0] + .5),
                            (int)(boundingBox[3]-boundingBox[1] + .5)};

      PGraphics buffer = createGraphics(bufferDims[0],bufferDims[1],P2D);    
                                        
      //calls to 'buffer' will crash if the dims are less than or equal to 0                                        
      if(bufferDims[0] > 0 && bufferDims[1] > 0)
      {
        buffer.beginDraw();
        buffer.clear();
        buffer.noStroke();
        buffer.fill(255);
        buffer.translate(-boundingBox[0],-boundingBox[1]);
        buffer.beginShape(TRIANGLE_STRIP);
          buffer.vertex(a[0],a[1]);
          buffer.vertex(b[0],b[1]);
          buffer.vertex(c[0],c[1]);
          buffer.vertex(d[0],d[1]);
        buffer.endShape();
        buffer.endDraw();
//        buffer.save("sakdjha.png");
        buffer.save("sizes/"+x+"x"+y+".png");
        buffers.add(buffer);
        image(buffer,random(width),random(height));
      }
    }  
  }
}

//takes four xy coords (float arrays) and returns the axis aligned 
//bounding box {left,top,right,bottom} (also a float array...
float[] getBoundingBox(float[] a,float[] b,float[] c,float[] d)
{
  float minX = min(a[0],min(b[0],min(c[0],d[0])));
  float minY = min(a[1],min(b[1],min(c[1],d[1])));
  float maxX = max(a[0],max(b[0],max(c[0],d[0])));
  float maxY = max(a[1],max(b[1],max(c[1],d[1])));
  return new float[]{minX,minY,maxX,maxY};
}

void mouseClicked()
{
  generateCutouts();
}
