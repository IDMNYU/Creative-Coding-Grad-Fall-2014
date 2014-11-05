import promidi.*;

MidiIO midiIO;

void setup(){
  size(128*5,128*5);
  smooth();
  background(0);
  
  midiIO = MidiIO.getInstance(this);
  println("printPorts of midiIO");
  midiIO.printPorts();
  midiIO.openInput(8);
}

void draw(){

}

int r,g,b,a;
int x,y;
void noteOn(Note note){
  r = 255;
  g = note.getVelocity()*2;
  b = note.getPitch()*2;
  a = note.getVelocity()*2;
  fill(r,g,b,a);
  stroke(255,a);
  
  x = 
  y =
  ellipse(note.getVelocity()*5,note.getPitch()*5,30,30);
}

void noteOff(Note note){
  r = 255;
  g = 
  b = 
  a =
  fill(note.getPitch()*2,note.getPitch()*2,255,note.getPitch()*2);
  stroke(255,note.getPitch());
  
  x = 
  y =
  ellipse(note.getPitch()*5,note.getPitch()*5,30,30);
}

void controllerIn(Controller controller){
  r = 255;
  g = 
  b = 
  a =
  fill(controller.getValue()*2,255,controller.getNumber()*2,controller.getValue()*2);
  stroke(255,controller.getValue());
  
  x = 
  y =
  ellipse(controller.getValue()*5,controller.getNumber()*5,30,30);
}

void programChange(ProgramChange programChange){
  r = 255;
  g = 
  b = 
  a =
  fill(programChange.getNumber()*2,255,programChange.getNumber()*2,programChange.getNumber()*2);
  stroke(255,programChange.getNumber());
  
  x = 
  y =
  ellipse(programChange.getNumber()*5,programChange.getNumber()*5,30,30);
}

