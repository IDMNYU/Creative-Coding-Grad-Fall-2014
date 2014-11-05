import promidi.*;

MidiIO midiIO;

void setup(){
  midiIO = MidiIO.getInstance(this);
  println("printPorts of midiIO");
  midiIO.printDevices();
  println();
  
  /*
   * Does the same like printDevices by 
   * printing the input and output devices
   */
  println("printDevices recoded 1");
  midiIO.printInputDevices();
  midiIO.printOutputDevices();
  println("<<<<<<<<<   >>>>>>>>>>>>>>>>>>>>>");
  println();
  
  /*
   * Does the same like printDevices by iterating
   * over the devices and print out their names
   */
  println("printDevices recoded 2");
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

