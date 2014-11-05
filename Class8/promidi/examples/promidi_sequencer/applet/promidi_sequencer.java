package examples.promidi_sequencer.applet;

import processing.core.PApplet;
import promidi.Q;
import promidi.MidiIO;
import promidi.MidiOut;
import promidi.Note;
import promidi.Sequencer;
import promidi.Song;
import promidi.Track;

public class promidi_sequencer extends PApplet{

	public void setup(){
		Sequencer sequencer = new Sequencer();
		
		MidiIO midiIO = MidiIO.getInstance();
		midiIO.printDevices();
		midiIO.closeOutput(1);
		MidiOut test = midiIO.getMidiOut(1,1);

		Track track = new Track("one", test);
		track.setQuantization(Q._1_4);
		track.addEvent(new Note(36, 127,40), 0);
		track.addEvent(new Note(46, 127,40), 0);
		track.addEvent(new Note(36, 127,40), 1);
		track.addEvent(new Note(41, 127,40), 1);
		track.addEvent(new Note(41, 127,40), 2);
		track.addEvent(new Note(46, 127,40), 2);
		track.addEvent(new Note(41, 127,40), 3);
		track.addEvent(new Note(46, 127,40), 3);

		Song song = new Song("test", 120);
		song.addTrack(track);
		sequencer.setSong(song);
		sequencer.setLoopStartPoint(0);
		sequencer.setLoopEndPoint(1000);
		sequencer.setLoopCount(-1);
		sequencer.start();
	}

	public void draw(){

	}

	static public void main(String args[]){
		PApplet.main(new String[] {promidi_sequencer.class.getName()});
	}
}