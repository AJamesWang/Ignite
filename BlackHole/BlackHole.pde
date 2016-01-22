//@author James Wang, last modified 22/1/2016

int holeRow=height/2;
int holeCol=width/2;
int moveAmount=1;

PImage myImage;
void setup() {
  size(255, 255);
  myImage=createImage(width, height, ARGB);
  randomizePixels(myImage);
}

void randomizePixels(PImage image){
  for(int row=0;row<height;row++){
    for(int col=0;col<width;col++){
      int index=row*width+col;
      int r=int(random(0,256));
      int g=int(random(0,256));
      int b=int(random(0,256));
      image.pixels[index]=color(r,g,b,255);
    }
  }
}

void draw() {
  renderImage(myImage);
  myImage.updatePixels();
  image(myImage, 0, 0);
}

void renderImage(PImage image) {
  PImage newImage=image.copy();
  for(int row=0;row<height;row++){
    for(int col=0;col<width;col++){
      moveColors(image,newImage,row,col);
    }
  }
}

void moveColors(PImage image, PImage newImage, int row, int col){
  int dRow=holeRow-row;
  int dCol=holeCol-col;
  char dominantDirection=getDominantDirection(dRow,dCol);
  int targetRow=row;
  int targetCol=col;
  switch(dominantDirection){
    case('u'):
      targetRow++;
      break;
    case('d'):
      targetRow--;
      break;
    case('l'):
      targetCol--;
      break;
    case('r'):
      targetCol++;
      break;
    default:
      throw new RuntimeException("invalid direction");
  }
  
  int index=row*width+col;
  int newIndex=targetRow*width+targetCol;
  
  for(int colour=0;colour<3;colour++){
    moveColor(image,newImage,index,newIndex,colour);
  }
    
}

char getDominantDirection(int dRow, int dCol){
  if(Math.abs(dRow)>Math.abs(dCol)){
    if(dRow<0){
      return 'd';
    }
    else{
      return 'u';
    }
  }
  else{
    if(dCol<0){
      return 'l';
    }
    else{
      return 'r';
    }
  }
}

//colour: 0==red, 1==green, 2==blue
void moveColor(PImage oldImage, PImage newImage, int oldIndex, int newIndex, int colour){
  int oldRed=int(red(oldImage.pixels[oldIndex]));
  int oldGreen=int(green(oldImage.pixels[oldIndex]));
  int oldBlue=int(blue(oldImage.pixels[oldIndex]));
  
  int newRed=int(red(oldImage.pixels[newIndex]));
  int newGreen=int(green(oldImage.pixels[newIndex]));
  int newBlue=int(blue(oldImage.pixels[newIndex]));
  
  switch(colour){
    case(0):
      oldRed-=moveAmount;
      oldRed=Math.min(0,oldRed);
      newRed+=moveAmount;
      newRed=Math.max(155,newRed);
      break;
    case(2):
      oldGreen-=moveAmount;
      oldGreen=Math.min(0,oldRed);
      newGreen+=moveAmount;
      newGreen=Math.max(155,newRed);
      break;
    case(3):
      oldBlue-=moveAmount;
      oldBlue=Math.min(0,oldRed);
      newBlue+=moveAmount;
      newBlue=Math.max(155,newRed);
      break;
  }
  
  newImage.pixels[oldIndex]=color(oldRed,oldGreen,oldBlue);
  newImage.pixels[newIndex]=color(newRed,newGreen,newBlue);
}