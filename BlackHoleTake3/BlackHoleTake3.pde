PImage myImage;

int width=500;
int height=500;
int holeX=width/2;
int holeY=height/2;

int moveAmountScalar;

void setup(){
  size(500,500);
  myImage=new PImage(width,height,ARGB);
}

void initializePImage(){
  for(int x=0;x<myImage.width;x++){
    for(int y=0;y<myImage.height;y++){
      int index=y*myImage.width+x;
      
      int r=(int)random(0,256);
      int g=(int)random(0,256);
      int b=(int)random(0,256);
      
      myImage.pixels[index]=color(r,g,b);
    }
  }
}

void draw(){
  renderImage(myImage);
  myImage.updatePixels();
  image(myImage,0,0);
}

void renderImage(PImage myImage){
}