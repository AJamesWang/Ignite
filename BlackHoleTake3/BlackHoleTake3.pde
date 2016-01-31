PImage myImage;

int width=500;
int height=500;
int holeX=width/2;
int holeY=height/2;

int moveAmountScalar=50;

void setup() {
  size(500, 500);
  myImage=new PImage(width, height, ARGB);
  initializePImage();
}

void initializePImage() {
  for (int x=0; x<myImage.width; x++) {
    for (int y=0; y<myImage.height; y++) {
      int index=y*myImage.width+x;

      int r=(int)random(0, 256);
      int g=(int)random(0, 256);
      int b=(int)random(0, 256);

      myImage.pixels[index]=color(r, g, b);
    }
  }
}

void draw() {
  renderImage(myImage);
  myImage.updatePixels();
  image(myImage, 0, 0);
}

void renderImage(PImage myImage) {
  PImage newImage=myImage.copy();

  for (int y=0; y<myImage.height; y++) {
   for (int x=0; x<myImage.width; x++) {
     //println(myImage.height);
     //println(myImage.width);
     int index=y*myImage.width+x;
     for (int shift=0; shift<=16; shift+=8) {
       move(myImage, newImage, index, shift);
     }
   }
  }
  myImage=newImage;
}

void move(PImage currentImage, PImage newImage, int startIndex, int colorShift) {
  int targetIndex=getTargetIndex(currentImage, startIndex);
  
  int startColorAmount=currentImage.pixels[startIndex]>>colorShift&0xff;
  int targetColorAmount=currentImage.pixels[targetIndex]>>colorShift&0xff;
  
  int moveAmount=Math.min(moveAmountScalar,Math.min(256-targetColorAmount-1,startColorAmount));
  
  /*startColorAmount-=moveAmount;
  targetColorAmount+=moveAmount;
  
  //note: does <<-8 equal >>8?
  int eraser=0xffffffff>>(colorShift+8)<<(colorShift+8)+0xff<<(colorShift-8);
  startColorAmount=startColorAmount<<colorShift;
  targetColorAmount=targetColorAmount<<colorShift;*/
  moveAmount=moveAmount<<colorShift; //<>//
  
  newImage.pixels[startIndex]-=moveAmount;//&eraser+startColorAmount;
  newImage.pixels[targetIndex]+=moveAmount;//&eraser+targetColorAmount;
}

int getTargetIndex(PImage image, int startIndex) {
  int startY=startIndex/image.width;
  int startX=startIndex%image.width;
  int dY=holeY-startY;
  int dX=holeX-startX;
  
  char[] possibleDirs=getPossibleDirections(dY,dX);
  char dir=possibleDirs[(int)random(0,possibleDirs.length)];
  
  int targetY=startY;
  int targetX=startX;
  switch(dir){
    case('u'):
      targetY--;
      break;
    case('d'):
      targetY++;
      break;
    case('l'):
      targetX--;
      break;
    case('r'):
      targetX++;
      break;
  }
  
  return targetY*image.width+targetX;
}

char[] getPossibleDirections(int dY, int dX){
  char yDir;
  if(dY<0){
    yDir='u';
  }
  else{
    yDir='d';
  }
  
  char xDir;
  if(dX<0){
    xDir='l';
  }
  else{
    xDir='r';
  }
  
  return new char[]{yDir,xDir};
}