//@author James Wang, last modified 23/1/2016

int holeRow=250;
int holeCol=250;
double moveAmountScalar=1.0;
int count=0;

void setup() {
  size(500, 500);
  //background(random(0,0),random(0,0),random(0,0));
  randomizePixels();
  smooth();
}

void randomizePixels(){
  for(int row=0;row<=500;row++){
    for(int col=0;col<=500;col++){
      int r=int(random(0,256));
      int g=int(random(0,256));
      int b=int(random(0,256));
      set(col,row,color(r,g,b,255));
    }
  }
}

void draw() {
  //println(count);
  count++;
  for(int row=0;row<=height;row++){
    for(int col=0;col<=width;col++){
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
      targetRow--;
      targetRow=Math.max(0,targetRow);
      break;
    case('d'):
      targetRow++;
      targetRow=Math.min(height,targetRow);
      break;
    case('l'):
      targetCol--;
      targetCol=Math.max(0,targetCol);
      break;
    case('r'):
      targetCol++;
      targetCol=Math.min(width,targetCol);
      break;
    default:
      throw new RuntimeException("invalid direction");
  }
  
  //println(dominantDirection);
  
  int moveAmount=(int)(Math.sqrt(Math.pow(dRow,2)+Math.pow(dCol,2))*moveAmountScalar);
  
  for(int colour=0;colour<3;colour++){
    moveColor(row,col,targetRow,targetCol, colour, moveAmount);
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
  /*if(Math.abs(dRow)>Math.abs(dCol)){
    if(dRow<0){
      return 'u';
    }
    else{
      return 'd';
    }
  }
  else{
    if(dCol<0){
      return 'l';
    }
    else{
      return 'r';
    }
  }*/
}

//colour: 0==red, 1==green, 2==blue
void moveColor(int startRow, int startCol, int targetRow, int targetCol, int colour, int moveAmount){
  int oldRed=get(startCol,startRow)>>16&0xFF;
  int oldGreen=get(startCol,startRow)>>8&0xFF;
  int oldBlue=get(startCol,startRow)>>0&0xFF;
  
  int newRed=get(targetCol,targetRow)>>16&0xFF;
  int newGreen=get(targetCol,targetRow)>>8&0xFF;
  int newBlue=get(targetCol,targetRow)>>0&0xFF;
  
  int actualMoveAmount;
  
  switch(colour){
    case(0):
      actualMoveAmount=oldRed-clamp(oldRed-moveAmount);
      oldRed-=actualMoveAmount;
      //newRed=clamp(newRed+moveAmount);
      newRed+=actualMoveAmount;
      break;
    case(1):
      actualMoveAmount=oldGreen-clamp(oldGreen-moveAmount);
      oldGreen-=actualMoveAmount;
      newGreen+=actualMoveAmount;
      break;
    case(2):
      actualMoveAmount=oldBlue-clamp(oldBlue-moveAmount);
      oldBlue-=actualMoveAmount;
      newBlue+=actualMoveAmount;
      break;
    default:
      throw new RuntimeException("invalid colour");
  }
  
  set(startCol,startRow,color(oldRed,oldGreen,oldBlue));
  set(targetCol,targetRow,color(newRed,newGreen,newBlue));
}

int clamp(int i){
  return Math.min(255,Math.max(0,i));
}

int loop(int i){
  return i%256;
}