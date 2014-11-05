/*
Part of the proMIDI lib - http://texone.org/promidi

Copyright (c) 2005 Christian Riekoff

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General
Public License along with this library; if not, write to the
Free Software Foundation, Inc., 59 Temple Place, Suite 330,
Boston, MA  02111-1307  USA
*/

package promidi;

import java.util.Comparator;
import java.util.TreeSet;

/**
 * The MidiOut class is for sending midi events. An MidiOut is
 * defined by a port and a midichannel. To get a MidiOut you have to use 
 * the getMidiOut() method of the MidiIO class.
 * @related MidiIO
 * @related Note
 * @related Controller
 * @related ProgramChange
 */
public class MidiOut{
	/**
	 * The midichannel of the midiout
	 */
	final int midiChannel;

	/**
	 * The midioutput port of the midiout
	 */
	final MidiOutDevice midiOutDevice;
	
	static private NoteBuffer noteBuffer;
	
	/**
	 * Initializes a new MidiOutput.
	 * @related MidiOut
	 * @example promidi_midiout
	 * @param midiChannel int, the midiChannel of the midiout
	 * @param midiOutDevice MidiOutPort, the midi port of the midiout
	 */
	MidiOut(final int midiChannel, final MidiOutDevice midiOutDevice){
		if(noteBuffer == null){
			noteBuffer = new NoteBuffer();
		}
		this.midiChannel = midiChannel;
		this.midiOutDevice = midiOutDevice;
	}

	/**
	 * Looks if two MidiOuts are equal. This is the case if they have
	 * the same midiChannel and port.
	 * @return true, if the given object is equal to the MidiOut
	 * @shortdesc Looks if two MidiOuts are equal.
	 */
	public boolean equals(final Object object){
		if(!(object instanceof MidiOutDevice))return false;
		final MidiOut midiOut = (MidiOut)object;
		if(midiChannel != midiOut.midiChannel) return false;
		if(!(midiOutDevice.equals(midiOut.midiOutDevice))) return false;
		return true;
	}
	
	/**
	 * @invisible
	 * @param i_event
	 * @throws InvalidMidiDataException
	 */
	public void sendEvent(final MidiEvent i_event){
		if (i_event.getChannel() > 15 || i_event.getChannel() < 0){
			throw new InvalidMidiDataException("You tried to send to midi channel" + i_event.getChannel() + ". With midi you only have the channels 0 - 15 available.");
		}
		i_event.setChannel(midiChannel);
		midiOutDevice.sendEvent(i_event);
	}
	
	/**
	 * Packs the given data to a midi event and sends it to the tracks midi out.
	 * @param i_command
	 * @param i_data1
	 * @param i_data2
	 */
	void sendEvent(final int i_command, final int i_data1, final int i_data2){
		final MidiEvent event = new MidiEvent(i_command, i_data1, i_data2);
		sendEvent(event);
	}

	/**
	 * Use this method to send a control change to the midioutput. You can send 
	 * control changes to change the sound on midi sound sources for example.
	 * @param controller Controller, the controller you want to send.
	 * @example promidi_midiout
	 * @shortdesc Use this method to send a control change to the midioutput.
	 * @related MidiOut
	 * @related Controller
	 * @related sendNote ( )
	 * @related sendProgramChange ( )
	 */
	public void sendController(Controller controller){
		try{
			sendEvent(controller);
		}catch (InvalidMidiDataException e){
			if (controller.getNumber() > 127 || controller.getNumber() < 0){
				throw new RuntimeException("You tried to send the controller number " + controller.getNumber()
					+ ". With midi you only have the controller numbers 0 - 127 available.");
			}
			if (controller.getValue() > 127 || controller.getValue() < 0){
				throw new RuntimeException("You tried to send the controller value " + controller.getValue()
					+ ". With midi you only have the controller values 0 - 127 available.");
			}
		}
	}

	/**
	 * With this method you can send a note on to your midi output. You can send note on commands
	 * to trigger midi soundsources. Be aware that you have to take care to send note off commands
	 * to release the notes otherwise you get midi hang ons.
	 * @param i_note Note, the note you want to send the note on for
	 * @example promidi_midiout
	 * @shortdesc With this method you can send a note on to your midi output.
	 * @related MidiOut
	 * @related Note
	 * @related sendController ( )
	 * @related sendProgramChange ( )
	 */
	public void sendNote(final Note i_note){
		try{
			sendEvent(i_note);
			noteBuffer.addNote(this,i_note);
		}catch (InvalidMidiDataException e){
			if (i_note.getPitch() > 127 || i_note.getPitch() < 0){
				throw new RuntimeException("You tried to send a note with the pitch " + i_note.getPitch() + ". With midi you only have pitch values from 0 - 127 available.");
			}
			if (i_note.getVelocity() > 127 || i_note.getVelocity() < 0){
				throw new RuntimeException("You tried to send a note with the velocity " + i_note.getVelocity()
					+ ". With midi you only have velocities values from 0 - 127 available.");
			}
		}
	}

	/**
	 * With this method you can send program changes to your midi output. Program changes are used 
	 * to change the preset on a midi sound source.
	 * @param i_programChange ProgramChange, program change you want to send
	 * @example promidi_midiout
	 * @shortdesc With this method you can send program changes to your midi output.
	 * @related MidiOut
	 * @related ProgramChange
	 * @related sendController ( )
	 * @related sendNote ( )
	 */
	public void sendProgramChange(final ProgramChange i_programChange){
		try{
			sendEvent(i_programChange);
		}catch (InvalidMidiDataException e){
			if (i_programChange.getNumber() > 127 || i_programChange.getNumber() < 0){
				throw new RuntimeException("You tried to send the program number " + i_programChange.getNumber()
					+ ". With midi you only have the program numbers 0 - 127 available.");
			}
		}
	}
	
	/**
	 * A Comparator defining how CueNote objects have to be sorted. According
	 * to there length
	 * @author christianr
	 *
	 */
	private static class NoteComparator implements Comparator{
		public int compare(final Object i_obj1, final Object i_obj2){
			final CueNote note1 = (CueNote)i_obj1;
			final CueNote note2 = (CueNote)i_obj2;
			return (int)(note1.offTime - note2.offTime);
		}
	}
	
	/**
	 * Class for saving all necessary information for buffering and
	 * and sending a note off command coressponding to a send note on.
	 * @author christianr
	 *
	 */
	private static class CueNote extends MidiEvent{
		/**
		 * The midiout the note has to be send out
		 */
		final MidiOut midiOut;
		
		/**
		 * the time the note off event has to be send
		 */
		final long offTime;
		
		CueNote(final MidiOut i_midiOut,final Note note, final long i_offTime){
			super(NOTE_OFF,note.getPitch(),note.getVelocity());
			midiOut = i_midiOut;
			offTime =i_offTime;
		}
		
		/**
		 * triggers the note off
		 *
		 */
		void trigger(){
			try{
				midiOut.sendEvent(this);
			}catch (InvalidMidiDataException e){
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * NoteBuffer is a simultaniously running thread buffering all
	 * note off events. All events are events are buffered and send
	 * according to the note length.
	 * @author christianr
	 *
	 */
	private static class NoteBuffer extends Thread{
		
		/**
		 * number of times the thread has been looped
		 */
		private long numberOfLoops = 0;
		
		/**
		 * Set that automatically sort all incoming notes according
		 * there length
		 */
		private final TreeSet notes = new TreeSet(new NoteComparator());
		
		/**
		 * Initializes a new NoteBuffer by starting the thread
		 */
		NoteBuffer(){
			this.start();
		}
		
		/**
		 * Here all current note off events are send and deleted afterwards
		 */
		public void run(){
			while (true){
				numberOfLoops++;
				try{
					Thread.sleep(1);

					final Object[] cueNotes = notes.toArray();
					int counter = 0;

						while (
							counter < cueNotes.length && 
							cueNotes.length > 0 && 
							((CueNote) cueNotes[counter]).offTime <= numberOfLoops
						){
							CueNote note = ((CueNote) cueNotes[counter]);
							note.trigger();
							notes.remove(note);
							counter++;
						}
					
				}catch (InterruptedException e){
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		/**
		 * Adds an note off event to the buffer
		 * @param i_midiOut
		 * @param i_note
		 */
		void addNote(final MidiOut i_midiOut, final Note i_note){
			notes.add(new CueNote(i_midiOut, i_note, i_note.getNoteLength()+numberOfLoops));
		}
	}
}
