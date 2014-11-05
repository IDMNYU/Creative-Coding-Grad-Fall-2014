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

import javax.sound.midi.ShortMessage;

/**
 * ProgramChange represents a midi program change. It has a midi port, a midi channel, 
 * and a number. You can receive program changes from midi inputs and send 
 * them to midi outputs. 
 * @nosuperclasses
 * @example promidi_midiout
 * @related MidiIO
 * @related Note
 * @related Controller
 */
public class ProgramChange extends MidiEvent{
	
	/**
	 * Inititalizes a new ProgramChange object.
	 * @param midiChannel int: midi channel a program change comes from or is send to
	 * @param i_number int, number of the program change
	 */
	public ProgramChange(final int i_number){
		super(ShortMessage.PROGRAM_CHANGE,i_number,-1);
	}
	
	/**
	 * Use this method to get the program change number.
	 * @return int, the program change number
	 * @example promidi
	 */
	public int getNumber(){
		return getData1();
	}
}
