PImage myImage;

int variation=255;

void setup(){
  size(255,255);
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
  int red=int(x+random(-variation,variation));
  int green=int(y+random(-variation,variation));
  int blue = int((x/((y+1)/255.0)+random(-variation,variation)));
  return color(red,green,blue,255);
}