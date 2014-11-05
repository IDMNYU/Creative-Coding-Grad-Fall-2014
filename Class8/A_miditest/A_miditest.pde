// midi stuff
import promidi.*; // import command for the library

MidiIO midiIO; // this is the MIDI engine in process
MidiOut midiOut; // this represents a MIDI output
Note note; // this represent a MIDI note

void setup()
{
  size(128, 128);
  frameRate(8); // ???

  // do the MIDI setup stuff
  midiIO = MidiIO.getInstance(this); // this starts the engine
  midiIO.printDevices(); // what have i got in MIDI world?

  // this is saying which MIDI inputs and outputs to use:
  midiOut = midiIO.getMidiOut(0, 0); 
  midiOut.sendProgramChange(
  new ProgramChange(88) // acoustic grand piano
  );
}

void draw()
{
}

void keyPressed()
{
  note = new Note(60, 100, 1000); // pitch, velocity, duration
  midiOut.sendNote(note);
  note = new Note(67, 100, 1000); // pitch, velocity, duration
  midiOut.sendNote(note);
  note = new Note(74, 100, 1000); // pitch, velocity, duration
  midiOut.sendNote(note);
}

