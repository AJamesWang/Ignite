import themidibus.*;

int channel=0;
int input=0;
int output=1;
MidiBus myBus=new MidiBus(this,input,output);

void setup(){
  size(500,500);
  background(0);
  
  
}

void draw(){
  Note myNote=new Note(channel,64,100,1000);
}