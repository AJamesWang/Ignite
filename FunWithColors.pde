PImage myImage;

void setup(){
  size(300,300);
  background(0,0,0);
  
  myImage=createImage(width,height,ARGB);
}

void draw(){
  renderImage(myImage);
  myImage.updatePixels();
  image(myImage,0,0);
  noLoop();
}

void renderImage(PImage image){
  for(int row=0;row<height;row++){
    for(int col=0;col<width;col++){
      int pixelIndex=row*width+col;
      image.pixels[pixelIndex]=evaluateImageFunction(col,row);
    }
  }
}

color evaluateImageFunction(float x, float y){
  int red=(int)x;
  int green=(int)y;
  int blue = (int)(x/((y+1)/255.0));
  return color(red,green,blue,255);
}