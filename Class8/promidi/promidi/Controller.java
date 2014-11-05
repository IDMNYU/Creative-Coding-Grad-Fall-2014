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
 * Controller represents a midi controller. It has a number and a value. You can
 * receive Controller values from midi ins and send them to midi outs.
 * @nosuperclasses
 * @example promidi_midiout
 * @related MidiIO
 * @related Note
 * @related ProgramChange
 */
public class Controller extends MidiEvent{

	/**
	 * Inititalizes a new Controller object.
	 * @param i_number int: number of a controller
	 * @param i_value  int: value of a controller
	 */
	public Controller(final int i_number, final int i_value){
		super(CONTROL_CHANGE, i_number, i_value);
	}
	
	/**
	 * Initialises a new Note from a java ShortMessage
	 * @param shortMessage
	 * @invisible
	 */
	Controller(ShortMessage shortMessage){
		super(shortMessage);
	}

	/**
	 * Use this method to get the number of a controller.
	 * @return int: the number of a note
	 * @example promidi
	 * @related Controller
	 * @related setNumber ( )
	 * @related getValue ( )
	 * @related setValue ( )
	 */
	public int getNumber(){
		return getData1();
	}

	/**
	 * Use this method to set the number of a controller.
	 * @return int: the number of a note
	 * @example promidi
	 * @related Controller
	 * @related getNumber ( )
	 * @related getValue ( )
	 * @related setValue ( )
	 */
	public void setNumber(final int i_number){
		setData1(i_number);
	}

	/**
	 * Use this method to get the value of a controller.
	 * @return int: the value of a note
	 * @example promidi
	 * @related Controller
	 * @related setValue ( )
	 * @related getNumber ( )
	 * @related setNumber ( )
	 */
	public int getValue(){
		return getData2();
	}

	/**
	 * Use this method to set the value of a controller.
	 * @return int, the value of a note
	 * @example promidi
	 * @related Controller
	 * @related getValue ( )
	 * @related setValue ( )
	 * @related getNumber ( )
	 */
	public void setValue(final int i_value){
		setData2(i_value);
	}
}
