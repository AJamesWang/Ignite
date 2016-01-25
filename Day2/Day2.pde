int counter;
int beatFreq;

int ballX, ballY;
int ballDX, ballDY;
int radius;
int ballColor;

int[][] childDirections;
ArrayList<ArrayList<Integer>>children;
int childRadius;

int backgroundColor;

int leftBound,rightBound,topBound,bottomBound;


void setup(){
  size(500,600);
  counter=0;
  beatFreq=200;
  
  leftBound=0;
  rightBound=width;
  topBound=0;
  bottomBound=height;
  
  backgroundColor=color(0,0,200);
  ballColor=color(200,200,0);
  background(backgroundColor);
  
  ballX=100;
  ballY=100;
  ballDX=10;
  ballDY=10;
  radius=40;
  
  children=new ArrayList();
  childDirections=new int[8][2];
  childDirections[0]=new int[]{-10,0};
  childDirections[1]=new int[]{0,-10};
  childDirections[2]=new int[]{10,0};
  childDirections[3]=new int[]{0,10};
  childDirections[4]=new int[]{-7,-7};
  childDirections[5]=new int[]{7,7};
  childDirections[6]=new int[]{-7,7};
  childDirections[7]=new int[]{7,-7};
  childRadius=radius/2;
  
  frameRate(10);
}

void draw(){
  background(backgroundColor);
  fill(ballColor);
  drawMain();
  drawChildren();
  doPhysics();
  
  if(counter%beatFreq==0){
    change();
  }
  counter++;
}

void drawMain(){
  ellipse(ballX,ballY,radius,radius);
}

void drawChildren(){
  println   (children.size());
 for(ArrayList<Integer> childPos:children){
   println("draw");
   int x=childPos.get(0);
   int y=childPos.get(1);
   ellipse(x,y,childRadius,childRadius);
 }
}

void doPhysics(){
  doMainPhysics();
  doChildPhysics();
}

void doMainPhysics(){
  ballX+=ballDX;
  ballY+=ballDY;
  
  if(isOutOfBoundsX(ballX, radius)){
    ballDX*=-1;
  }
  if(isOutOfBoundsY(ballY,radius)){
    ballDY*=-1;
  }
}

void doChildPhysics(){
  for(ArrayList<Integer> childData:children){
    println("physics");   
    int x=childData.get(0);
    int y=childData.get(1);
    int dX=childData.get(2);
    int dY=childData.get(3);
    
    //println("x:" + x);
    //println("y:" + y);
    
    childData.set(0,x+dX); //<>//
    childData.set(1,y+dY);
    
    x=childData.get(0);
    y=childData.get(1);
    
    println("new x: "+childData.get(0));
    println("new y: "+childData.get(1));
    
    if(isOutOfBoundsX(x,childRadius)){
      childData.set(2,-dX);
   //   println("x: " + x);
    }
    if(isOutOfBoundsY(y,childRadius)){
      childData.set(3,-dY);
    //  println("y: " + y);
    }
    
    for(ArrayList<Integer> childData2:children){
      if(childData2!=childData){
        int x2=childData2.get(0);
        int y2=childData2.get(1);
        int dx=x2-x;
        int dy=y2-y;
        
        int distance=(int)Math.sqrt(Math.pow(dx,2)+Math.pow(dy,2));
        
        if(distance<2*childRadius){
          int[] newV=collide(dX,dY,childData2.get(2),childData2.get(3),childRadius,childRadius);
          childData.set(2,newV[0]);
          childData.set(3,newV[1]);
        }
      }
    }
  }
  

}

boolean isOutOfBoundsX(int x, int radius){
  return (x-radius)<leftBound||(x+radius)>rightBound;
}

boolean isOutOfBoundsY(int y, int radius){
  return (y-radius)<topBound||(y+radius)>bottomBound;
}

int[] collide(int vx1, int vy1, int vx2, int vy2, int r1, int r2){
  int outvx=(int)(vx1*Math.pow(r1,2)+vx2*Math.pow(r2,2)/(vx2*Math.pow(r2,2)));
  int outvy=(int)(vy1*Math.pow(r1,2)+vy2*Math.pow(r2,2)/(vy2*Math.pow(r2,2)));
  return new int[]{outvx,outvy};
}

void change(){
  backgroundColor=~backgroundColor;
  ballColor=~(ballColor&0x00ffffff);
  ballDX=(int)random(0,30);
  ballDY=(int)random(0,30);
  makeChildren();
  println(children.size());
}

void makeChildren(){
  //children.clear();
  for(int[] direction:childDirections){
    ArrayList<Integer> childData=new ArrayList();
    childData.add(ballX+5*direction[0]);
    childData.add(ballY+5*direction[1]);
    childData.add(direction[0]);
    childData.add(direction[1]);
    children.add(childData);
  }
}