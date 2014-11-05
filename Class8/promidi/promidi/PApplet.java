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
/**
 * Note this class is only needed for building the documentation of 
 * the methods that can be implemented in the processing app.
 */


/**
 * PApplet is your processing application. You can implement different 
 * methods to react on incoming midi messages. proMIDI is calling these 
 * methods on incoming midi data.<br>
 * You also use the plug function to forward midiInformation of your
 * choice to the desired object and method.
 * @example promidi_reflection
 * @related MidiIO
 * @related Note
 * @related Controller
 * @related ProgramChange 
 */
public class PApplet{
	
	/**
	 * The noteOn() function is called everytime a note on command comes through one 
	 * of your opened midi inputs. 
	 * @param note Note: the incoming note on
	 * @param deviceNumber int: the number of the device the note was send through
	 * @param midiChannel int: the midi channel the note was send through
	 * @related Note
	 * @related noteOff ( )
	 * @related controllerIn ( )
	 * @related programChange ( )
	 * @example promidi_reflection
	 */
	public void noteOn(
		final Note note,
		final int deviceNumber,
		final int midiChannel
	){
		
	}
	
	/**
	 * The noteOff() function is called everytime a note off command comes through one 
	 * of your opened midi inputs. 
	 * @param note Note, the incoming note off
	 * @param deviceNumber int: the number of the device the note was send through
	 * @param midiChannel int: the midi channel the note was send through
	 * @related Note
	 * @related noteOn ( )
	 * @related controllerIn ( )
	 * @related programChange ( )
	 * @example promidi_reflection
	 */
	public void noteOff(
		final Note note,
		final int deviceNumber,
		final int midiChannel
	){
		
	}
	
	/**
	 * The controllerIn() function is called everytime a control change command comes through one 
	 * of your opened midi inputs. 
	 * @param controller Controller, the incoming control change
	 * @param deviceNumber int: the number of the device the note was send through
	 * @param midiChannel int: the midi channel the note was send through
	 * @related Note
	 * @related noteOn ( )
	 * @related noteOff ( )
	 * @related programChange ( )
	 * @example promidi_reflection
	 */
	public void controllerIn(
		final Controller controller,
		final int deviceNumber,
		final int midiChannel
	){
		
	}
	
	/**
	 * The programChange() function is called everytime a program change command comes through one 
	 * of your opened midi inputs. 
	 * @param programChange ProgramChange: the incoming program change
	 * @param deviceNumber int: the number of the device the note was send through
	 * @param midiChannel int: the midi channel the note was send through
	 * @related Note
	 * @related noteOn ( )
	 * @related noteOff ( )
	 * @related controllerIn ( )
	 * @example promidi_reflection
	 */
	public void programChange(
		final ProgramChange programChange,
		final int deviceNumber,
		final int midiChannel
	){
		
	}
}
