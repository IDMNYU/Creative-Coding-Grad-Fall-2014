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

import javax.sound.midi.MidiUnavailableException;
import javax.sound.midi.Receiver;

/**
 * This class has no accessable contructor use MidiIO.openOutput() to get a MidiOut. 
 * MidiOut is the direct connection to one of your midi out ports. You can use different  
 * methods to send notes, control and program changes through one midi out port.
 * @example promidi_midiout
 * @related MidiIO
 * @related Note
 * @related Controller
 * @related ProgramChange
 */
class MidiOutDevice extends MidiDevice{

	private final Receiver outputReceiver;

	MidiOutDevice(
		final javax.sound.midi.MidiDevice midiDevice,
		final int deviceNumber
	) throws MidiUnavailableException{
		super(midiDevice,deviceNumber);
		outputReceiver = midiDevice.getReceiver();
	}

	/**
	 * @param event
	 * @throws InvalidMidiDataException
	 */
	public void sendEvent(final MidiEvent event){
		if (event.getChannel() > 15 || event.getChannel() < 0){
			throw new InvalidMidiDataException("You tried to send to midi channel" + event.getChannel() + ". With midi you only have the channels 0 - 15 available.");
		}
		outputReceiver.send(event, -1);
	}

	/**
	 * Use this method to send a control change to the midioutput. You can send 
	 * control changes to change the sound on midi sound sources for example.
	 * @param controller Controller, the controller you want to send.
	 * @example promidi_midiout
	 * @shortdesc Use this method to send a control change to the midioutput.
	 * @related Controller
	 * @related sendNoteOn ( )
	 * @related sendNoteOff ( )
	 * @related sendProgramChange ( )
	 */
	public void sendController(Controller controller){
		try{
			sendEvent(controller);
		}catch (InvalidMidiDataException e){
			if (controller.getNumber() > 127 || controller.getNumber() < 0){
				throw new InvalidMidiDataException("You tried to send the controller number " + controller.getNumber()
					+ ". With midi you only have the controller numbers 0 - 127 available.");
			}
			if (controller.getValue() > 127 || controller.getValue() < 0){
				throw new InvalidMidiDataException("You tried to send the controller value " + controller.getValue()
					+ ". With midi you only have the controller values 0 - 127 available.");
			}
		}
	}

	/**
	 * With this method you can send a note on to your midi output. You can send note on commands
	 * to trigger midi soundsources. Be aware that you have to take care to send note off commands
	 * to release the notes otherwise you get midi hang ons.
	 * @param note Note, the note you want to send the note on for
	 * @example promidi_midiout
	 * @shortdesc With this method you can send a note on to your midi output.
	 * @related Note
	 * @related sendController ( )
	 * @related sendNoteOff ( )
	 * @related sendProgramChange ( )
	 */
	public void sendNoteOn(Note note){
		try{
			sendEvent(note);
		}catch (InvalidMidiDataException e){
			if (note.getPitch() > 127 || note.getPitch() < 0){
				throw new InvalidMidiDataException("You tried to send a note with the pitch " + note.getPitch() + ". With midi you only have pitch values from 0 - 127 available.");
			}
			if (note.getVelocity() > 127 || note.getVelocity() < 0){
				throw new InvalidMidiDataException("You tried to send a note with the velocity " + note.getVelocity()
					+ ". With midi you only have velocities values from 0 - 127 available.");
			}
		}
	}

	/**
	 * Use this method to send a note off command to your midi output. You have to send note off commands 
	 * to release send note on commands.
	 * @param note Note, the note you want to send the note off for
	 * @example promidi_midiout
	 * @shortdesc Use this method to send a note off command to your midi output.
	 * @related Note
	 * @related sendController ( )
	 * @related sendNoteOn ( )
	 * @related sendProgramChange ( )
	 */
	public void sendNoteOff(Note note){
		note.setToNoteOff();
		sendNoteOn(note);
	}

	/**
	 * With this method you can send program changes to your midi output. Program changes are used 
	 * to change the preset on a midi sound source.
	 * @param programChange ProgramChange, program change you want to send
	 * @example promidi_midiout
	 * @shortdesc With this method you can send program changes to your midi output.
	 * @related Note
	 * @related sendController ( )
	 * @related sendNoteOn ( )
	 * @related sendNoteOff ( )
	 */
	public void sendProgramChange(ProgramChange programChange){
		try{
			sendEvent(programChange);
		}catch (InvalidMidiDataException e){
			if (programChange.getNumber() > 127 || programChange.getNumber() < 0){
				throw new InvalidMidiDataException("You tried to send the program number " + programChange.getNumber()
					+ ". With midi you only have the program numbers 0 - 127 available.");
			}
		}
	}
}
