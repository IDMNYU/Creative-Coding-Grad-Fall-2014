import processing.opengl.*;
import promidi.*;

MidiIO midiIO;
MidiOut midiOut;
Bowl[] bowl;

void setup(){
  size(128*5,128*5);
  background(0);
  smooth();

  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  
  //print a list with all available devices
  midiIO.printDevices();
  
  //open an midiout using the first device and the first channel
  midiOut = midiIO.getMidiOut(0,0);

  bowl = new Bowl[30];
  for(int i = 0;i < bowl.length;i++){
    bowl[i] = new Bowl(i);
  }
  noStroke();
}

void draw(){
  background(0);
  for(int i = 0;i < bowl.length;i++){
    bowl[i].move();
    bowl[i].paint();
  }

}

class Bowl{
  float xSpeed;
  float ySpeed;
  float xPos;
  float yPos;
  Note note;
  color col;
  int myNumber;

  Bowl(int number){
    xSpeed = random(2,20);
    ySpeed = random(2,20);
    note = new Note(0,0,0);
    col = color(
      random(0,255),
      random(0,255),
      random(0,255)
    );
    myNumber = number;
  }

  void move(){
    xPos += xSpeed;
    yPos += ySpeed;
    midiOut.sendController(
      new Controller(0,myNumber,int(xPos/6)+2)
    );
    
    if(xPos > width || xPos < 0){
      xSpeed = -xSpeed;
      xPos += xSpeed;

      playNote();
    }
    if(yPos > width || yPos < 0){
      ySpeed = -ySpeed;
      yPos += ySpeed;
      playNote();
      midiOut.sendProgramChange(
        new ProgramChange(0,myNumber)
      );
    }
  }

  void playNote(){
    note = new Note(int(xPos/5f),int(yPos/10f)+60,int(random(1000)));
    midiOut.sendNote(note);
  }

  void paint(){
    fill(col);
    ellipse(xPos,yPos,20,20);
  }
}
