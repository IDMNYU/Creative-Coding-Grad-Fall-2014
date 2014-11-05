import promidi.*;

void setup(){
Sequencer sequencer = new Sequencer();
MidiIO midiIO = MidiIO.getInstance();
midiIO.closeOutput(1);
MidiOut test = midiIO.openOutput(1);

Track track = new Track("one",test);
track.addEvent(new Note(0,36,127,Conts._1_4*0));
track.addEvent(new Note(0,46,0,Conts._1_4*0));
track.addEvent(new Note(0,36,0,Conts._1_4*1));
track.addEvent(new Note(0,41,127,Conts._1_4*1));
track.addEvent(new Note(0,41,0,Conts._1_4*2));
track.addEvent(new Note(0,46,127,Conts._1_4*2));
track.addEvent(new Note(0,41,0,Conts._1_4*3));
track.addEvent(new Note(0,46,127,Conts._1_4*3));

Song song = new Song("test",120);
song.addTrack(track);
sequencer.setSong(song);
sequencer.setLoopStartPoint(0);
sequencer.setLoopEndPoint(1000);
sequencer.setLoopCount(-1);
sequencer.start();
}

public void draw(){

}

