Position mainPos;
int ribbonAmount;
Position[] ribbons;

void setup(){
  size(1000,1000);
  mainPos=new Position(500,500);
  ribbons=new Position[ribbonAmount];
}

class Position {
  int xPos;
  int yPos;

  Position(int xPos, int yPos) {
    this.xPos=xPos;
    this.yPos=yPos;
  }

  void moveRandom(int maxMoveDistance) {
    int dX=(int)random(-maxMoveDistance, maxMoveDistance);
    int dY=(int)random(-maxMoveDistance, maxMoveDistance);

    xPos+=dX;
    yPos+=dY;
    checkLegal();
  }

  private void checkLegal() {
    xPos=Math.max(0, Math.min(xPos, width-1));
    yPos=Math.max(0, Math.min(yPos, height-1));
  }

  void move(int dX, int dY) {
    xPos+=dX;
    yPos+=dY;
    checkLegal();
  }
  
  void move(int targetX, int targetY, int moveAmount){
    double dX=targetX-this.xPos;
    double dY=targetY-this.yPos;
    
    double mag=Math.sqrt(Math.pow(dX,2)+Math.pow(dY,2))/moveAmount;
    
    dX/=mag;
    dY/=mag;
    
    xPos+=(int)dX;
    yPos+=(int)dY;
  }

  void set(int xPos, int yPos) {
    this.xPos=xPos;
    this.yPos=yPos;
    checkLegal();
  }

  int getDistance(Position otherPos) {
    int otherXPos=otherPos.getXPos();
    int otherYPos=otherPos.getYPos();

    int dX=otherXPos-xPos;
    int dY=otherYPos-yPos;

    int distance=(int)Math.sqrt(Math.pow(dX, 2)+Math.pow(dY, 2));
    return distance;
  }

  int getXPos() {
    return this.xPos;
  }

  int getYPos() {
    return this.yPos;
  }
}