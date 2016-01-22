//@author James Wang, last modified 22/1/2016

int holeRow=500;
int holeCol=0;
int moveAmount=1;
int count=0;

void setup() {
  size(500, 500);
  randomizePixels();
  frameRate(1);
}

void randomizePixels(){
  for(int row=0;row<50;row++){
    for(int col=0;col<50;col++){
      int r=int(random(0,256));
      int g=int(random(0,256));
      int b=int(random(0,256));
      set(col,row,color(r,g,b,255));
    }
  }
}

void draw() {
  println(count);
  count++;
  for(int row=0;row<height;row++){
    for(int col=0;col<width;col++){
      moveColors(row,col);
    }
  }
}

void moveColors(int row, int col){
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
  
  //println(dominantDirection);
  
  for(int colour=0;colour<3;colour++){
    moveColor(row,col,targetRow,targetCol,colour);
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
void moveColor(int startRow, int startCol, int targetRow, int targetCol, int colour){
  int oldRed=get(startCol,startRow)>>16&0xFF;
  int oldGreen=get(startCol,startRow)>>8&0xFF;
  int oldBlue=get(startCol,startRow)>>0&0xFF;
  
  int newRed=get(targetCol,targetRow)>>16&0xFF;
  int newGreen=get(targetCol,targetRow)>>8&0xFF;
  int newBlue=get(targetCol,targetRow)>>0&0xFF;
  
  switch(colour){
    case(0):
      oldRed-=moveAmount;
      oldRed=Math.min(0,oldRed);
      newRed+=moveAmount;
      newRed=Math.max(255,newRed);
      break;
    case(2):
      oldGreen-=moveAmount;
      oldGreen=Math.min(0,oldRed);
      newGreen+=moveAmount;
      newGreen=Math.max(255,newRed);
      break;
    case(3):
      oldBlue-=moveAmount;
      oldBlue=Math.min(0,oldRed);
      newBlue+=moveAmount;
      newBlue=Math.max(155,newRed);
      break;
  }
  
  set(startRow,startCol,color(oldRed,oldGreen,oldBlue));
  set(targetRow,targetCol,color(newRed,newGreen,newBlue));
}