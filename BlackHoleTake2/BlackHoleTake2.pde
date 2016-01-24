//@author James Wang, last modified 23/1/2016

PImage myImage;

int holeRow=250;
int holeCol=250;
double moveAmountScalar=1;
int count=0;

void setup() {
  size(500, 500);
  myImage=new PImage(width,height,ARGB);
  //background(random(0,0),random(0,0),random(0,0));
  randomizePixels();
  smooth();
  
}

void randomizePixels(){
  for(int row=0;row<height;row++){
    for(int col=0;col<width;col++){
      int r=int(random(255,256));
      int g=int(random(255,256));
      int b=int(random(255,256));
      
      int index=row*width+col;
      
      myImage.pixels[index]=color(r,g,b);
    }
  }
  
}

void draw() {
  renderImage();
  myImage.updatePixels();
  image(myImage,0,0);
}

void renderImage(){
  PImage nextImage=new PImage(width,height,ARGB);
  //println(count);
  count++;
  for(int row=0;row<height;row++){
    for(int col=0;col<width;col++){
      moveColors(myImage,nextImage,row,col);
    }
  }
  
  myImage=nextImage;
}

void moveColors(PImage currentImage, PImage nextImage,int startRow, int startCol){  
  int dRow=holeRow-startRow;
  int dCol=holeCol-startCol;
  char dominantDirection=getDominantDirection(dRow,dCol);
  
  int targetRow=startRow;
  int targetCol=startCol;
  switch(dominantDirection){
    case('u'):
      targetRow--;
      //targetRow=Math.max(0,targetRow);
      break;
    case('d'):
      targetRow++;
      //targetRow=Math.min(height,targetRow);
      break;
    case('l'):
      targetCol--;
      //targetCol=Math.max(0,targetCol);
      break;
    case('r'):
      targetCol++;
      //targetCol=Math.min(width,targetCol);
      break;
    default:
      throw new RuntimeException("invalid direction");
  }
  
  //println(dominantDirection);
  
  int moveAmount=(int)(Math.sqrt(Math.pow(dRow,2)+Math.pow(dCol,2))*moveAmountScalar);
  
  if(dominantDirection=='u'||dominantDirection=='l'){
    //print("here!"); //<>//
  }
  
  int startIndex=startRow*width+startCol;
  int targetIndex=targetRow*width+targetCol;
  for(int colour=0;colour<3;colour++){
    moveColor(currentImage,nextImage,startIndex,targetIndex, colour, moveAmount);
  }
    
}

char getDominantDirection(int dRow, int dCol){
  char[] possibleDirections=new char[2];
  if(dRow<0){
   possibleDirections[0]='u';
  }
  else{
   possibleDirections[0]='d';
  }
  if(dCol<0){
   possibleDirections[1]='l';
  }
  else{
   possibleDirections[1]='r';
  }
  return possibleDirections[int(random(0,2))];
  //if(Math.abs(dRow)>Math.abs(dCol)){
  // if(dRow<0){
  //   return 'u';
  // }
  // else{
  //   return 'd';
  // }
  //}
  //else{
  // if(dCol<0){
  //   return 'l';
  // }
  // else{
  //   return 'r';
  // }
  //}
}

//colour: 0==red, 1==green, 2==blue
void moveColor(PImage currentImage, PImage nextImage, int startIndex, int targetIndex, int colour, int moveAmount){
  
  int startRed=currentImage.pixels[startIndex]>>16&0xFF;
  int startGreen=currentImage.pixels[startIndex]>>8&0xFF;
  int startBlue=currentImage.pixels[startIndex]>>0&0xFF;
  
  int targetRed=currentImage.pixels[targetIndex]>>16&0xFF;
  int targetGreen=currentImage.pixels[targetIndex]>>8&0xFF;
  int targetBlue=currentImage.pixels[targetIndex]>>0&0xFF;
  
  int actualMoveAmount;
  
  switch(colour){
    case(0):
      actualMoveAmount=startRed-clamp(startRed-moveAmount);
      startRed-=actualMoveAmount;
      targetRed=clamp(targetRed+actualMoveAmount);
      break;
    case(1):
      //print("here");
      actualMoveAmount=startGreen-clamp(startGreen-moveAmount);
      startGreen-=actualMoveAmount;
      targetGreen=clamp(targetGreen+actualMoveAmount);
      break; //<>//
    case(2):
      actualMoveAmount=startBlue-clamp(startBlue-moveAmount);
      startBlue-=actualMoveAmount;
      targetBlue=clamp(targetBlue+actualMoveAmount);
      break; //<>//
    default:
      throw new RuntimeException("invalid colour");
  }
  
  nextImage.pixels[startIndex]=color(startRed,startGreen,startBlue);
  nextImage.pixels[targetIndex]=color(targetRed,targetGreen,targetBlue);
}

int clamp(int i){
  return Math.min(255,Math.max(0,i));
}

int loop(int i){
  return i%256;
}