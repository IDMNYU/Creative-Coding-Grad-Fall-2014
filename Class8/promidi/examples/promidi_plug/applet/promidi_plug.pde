import promidi.*;

MidiIO midiIO;

void setup(){
  size(128*5,128*5);
  smooth();
  background(0);
  
  midiIO = MidiIO.getInstance(this);
  println("printPorts of midiIO");
  midiIO.printDevices();
  
  midiIO.plug(this,"noteOn",0,0);
  midiIO.plug(this,"noteOff",0,0);
  midiIO.plug(this,"controllerIn",0,0);
  midiIO.plug(this,"programChange",0,0);
}

void draw(){

}

void noteOn(
  Note note,
  int deviceNumber,
  int midiChannel
){
  int vel = note.getVelocity();
  int pit = note.getPitch();
  
  fill(255,vel*2,pit*2,vel*2);
  stroke(255,vel);
  ellipse(vel*5,pit*5,30,30);
}

void noteOff(
  Note note,
  int deviceNumber,
  int midiChannel
){
  int pit = note.getPitch();
  
  fill(255,pit*2,pit*2,pit*2);
  stroke(255,pit);
  ellipse(pit*5,pit*5,30,30);
}

void controllerIn(
  Controller controller,
  int deviceNumber,
  int midiChannel
){
  int num = controller.getNumber();
  int val = controller.getValue();
  
  fill(255,num*2,val*2,num*2);
  stroke(255,num);
  ellipse(num*5,val*5,30,30);
}

void programChange(
  ProgramChange programChange,
  int deviceNumber,
  int midiChannel
){
  int num = programChange.getNumber();
  
  fill(255,num*2,num*2,num*2);
  stroke(255,num);
  ellipse(num*5,num*5,30,30);
}
