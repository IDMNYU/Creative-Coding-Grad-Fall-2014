import promidi.*;

Sequencer sequencer;

void setup(){
  sequencer = new Sequencer();

  MidiIO midiIO = MidiIO.getInstance();
  midiIO.printDevices();
  midiIO.closeOutput(1);
  MidiOut test = midiIO.getMidiOut(1,1);

  Track track = new Track("one", test);
  track.setQuantization(Q._1_4);
  track.addEvent(new Note(36, 127,40), 0);
  track.addEvent(new Note(49, 80,40), 1); 
  track.addEvent(new Note(41, 90,40), 2);
  track.addEvent(new Note(46, 127,40), 3);

  Song song = new Song("test", 120);
  song.addTrack(track);
  sequencer.setSong(song);
  sequencer.setLoopStartPoint(0);
  sequencer.setLoopEndPoint(512);
  sequencer.setLoopCount(-1);
}

void mousePressed(){
  if(mouseButton == LEFT) sequencer.start();
  else sequencer.stop();
}

void draw(){
}
