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

import javax.sound.midi.InvalidMidiDataException;
import javax.sound.midi.ShortMessage;

/**
 * Note represents a midi note. It has a midi port, a midi channel, 
 * a pitch and a velocity. You can receive Notes from midi inputs and send 
 * them to midi outputs. 
 * @example promidi_midiout
 * @nosuperclasses
 * @related Controller
 * @related ProgramChange
 * @related MidiIO
 */
public class Note extends MidiEvent{
	private int command = ShortMessage.NOTE_ON;
	
	/**
	 * the length of the note in milliSeconds
	 */
	private int length;
	
	/**
	 * Inititalizes a new Note object. You can build a Note to send it to 
	 * a midi output. Be aware that different from the old promidi version
	 * you do not have to send the note off seperatly, instead you provide a
	 * length on initializing the node and promidi automatically sends the
	 * according note off.<br>
	 * @example promidi_midiout;
	 * @param i_pitch int, pitch of a note
	 * @param i_velocity int, velocity of a note
	 * @param i_length int, length of the note in milliseconds
	 */
	public Note(final int i_pitch, final int i_velocity, final int i_length){
		super(NOTE_ON,i_pitch,i_velocity);
		length = i_length;
	}
	
	Note(final int i_pitch, final int i_velocity){
		this(i_pitch, i_velocity,0);
	}
	
	/**
	 * Initialises a new Note from a java ShortMessage
	 * @param shortMessage
	 * @invisible
	 */
	Note(final ShortMessage shortMessage){
		super(shortMessage);
		length = 0;
	}
	
	/**
	 * Use this method to get the pitch of a note.
	 * @return int, the pitch of a note
	 * @example promidi
	 * @related Note
	 * @related setPitch ( )
	 * @related getVelocity ( )
	 * @related setVelocity ( )
	 */
	public int getPitch(){
		return getData1();
	}
	
	/**
	 * Use this method to set the pitch of a note
	 * @param pitch int, new pitch for the note
	 * @related Note
	 * @related getPitch ( )
	 * @related getVelocity ( )
	 * @related setVelocity ( )
	 */
    public void setPitch(final int i_pitch){
		setData1(i_pitch);
    }
    
	/**
	 * Use this method to get the velocity of a note.
	 * @return int, the velocity of a note
	 * @example promidi
	 * @related Note
	 * @related setVelocity ( )
	 * @related getPitch ( )
	 * @related setPitch ( )
	 */
	public int getVelocity(){
		return getData2();
	}
	
	/**
	 * Use this method to set the velocity of a note.
	 * @param velocity int, new velocity for the note
	 * @related Note
	 * @related getVelocity ( )
	 * @related getPitch ( )
	 * @related setPitch ( )
	 */
    public void setVelocity(final int i_velocity){
		setData2(i_velocity);
    }
    
    /**
     * Returns the length of the note in milliseconds
     * @return int: the length of the note
     * @related Note
     */
    public int getNoteLength(){
   	 return length;
    }
    
    /**
     * Sets the length of the note
     * @param i_length int: new length of the note
     * @related Note
     * @related setPitch ( )
     * @related setVelocity ( )
     */
    public void setLength(final int i_length){
   	 length = i_length;
    }
	
	/**
	 * Internal Method to set this note to send the note off command
	 */
	void setToNoteOff(){
		try{
			command=ShortMessage.NOTE_OFF;
			setMessage(command,getChannel(),getData1(),getData2());
		}catch (InvalidMidiDataException e){
			e.printStackTrace();
		}
	}
}
