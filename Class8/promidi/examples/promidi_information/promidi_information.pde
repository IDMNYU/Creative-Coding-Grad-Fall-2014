import promidi.*;

MidiIO midiIO;

void setup(){
  // get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  
  //print a list with all available devices
  midiIO.printDevices();
  println();
  
  //printDevices recoded 
  midiIO.printInputDevices();
  midiIO.printOutputDevices();
  println("<<<<<<<<<   >>>>>>>>>>>>>>>>>>>>>");
  println();
  
  println("printPorts recoded 2");
  println("<< inputs: >>>>>>>>>>>>>>>>>>>>>>");
  for(int i = 0; i < midiIO.numberOfInputDevices();i++){
    println("input  "+nf(i,2)+": "+midiIO.getInputDeviceName(i));
  }
  println("<< outputs: >>>>>>>>>>>>>>>>>>>>>");
  for(int i = 0; i < midiIO.numberOfOutputDevices();i++){
    println("output "+nf(i,2)+": "+midiIO.getOutputDeviceName(i));
  }
  println("<<<<<<<<<   >>>>>>>>>>>>>>>>>>>>>");
}

