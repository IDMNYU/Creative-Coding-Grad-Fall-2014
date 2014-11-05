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

import javax.sound.midi.MidiMessage;
import javax.sound.midi.MidiUnavailableException;
import javax.sound.midi.Receiver;
import javax.sound.midi.ShortMessage;
import javax.sound.midi.Transmitter;

class MidiInDevice extends MidiDevice implements Receiver{

	private final Transmitter inputTrans;

	private final MidiIO promidiContext;
	
	/**
	 * Contains the states of the 16 midi channels for a device.
	 * true if open otherwise false.
	 */
	private final MidiIn[] midiIns = new MidiIn [16];

	/**
	 * Initializes a new MidiIn.
	 * @param libContext
	 * @param midiDevice
	 * @throws MidiUnavailableException
	 */
	MidiInDevice(
		final MidiIO libContext, 
		final javax.sound.midi.MidiDevice midiDevice, 
		final int deviceNumber
	){
		super(midiDevice, deviceNumber);
		this.promidiContext = libContext;
		
		try{
			inputTrans = midiDevice.getTransmitter();
		}catch (MidiUnavailableException e){
			throw new RuntimeException();
		}
	}
	
	String getName(){
		return midiDevice.getDeviceInfo().getName();
	}
	
	void open(){
		super.open();
		inputTrans.setReceiver(this);
	}
	
	void openMidiChannel(final int i_midiChannel){
		if(midiIns[i_midiChannel]==null)
			midiIns[i_midiChannel] = new MidiIn(i_midiChannel,promidiContext);
	}
	
	void closeMidiChannel(final int i_midiChannel){
		midiIns[i_midiChannel]=null;
	}
	
	void plug(
		final Object i_object, 
		final String i_methodName, 
		final int i_midiChannel
	){
		open();
		openMidiChannel(i_midiChannel);
		midiIns[i_midiChannel].plug(i_object,i_methodName);
	}

	/**
	 * Sorts the incoming MidiIO data in the different Arrays.
	 * @invisible
	 * @param message MidiMessage
	 * @param deltaTime long
	 */
	public void send(final MidiMessage message, final long deltaTime){
		final ShortMessage shortMessage = (ShortMessage) message;

		// get messageInfos
		final int midiChannel = shortMessage.getChannel();

		if (midiIns[midiChannel] == null)
			return;

		final int midiCommand = shortMessage.getCommand();
		final int midiData1 = shortMessage.getData1();
		final int midiData2 = shortMessage.getData2();

		if (midiCommand == MidiEvent.NOTE_ON && midiData2 > 0){
			final Note note = new Note(midiData1, midiData2);
			midiIns[midiChannel].sendNoteOn(note,deviceNumber,midiChannel);
		}else if (midiCommand == MidiEvent.NOTE_OFF || midiData2 == 0){
			final Note note = new Note(midiData1, midiData2);
			midiIns[midiChannel].sendNoteOff(note,deviceNumber,midiChannel);
		}else if (midiCommand == MidiEvent.CONTROL_CHANGE){
			final Controller controller = new Controller(midiData1, midiData2);
			midiIns[midiChannel].sendController(controller,deviceNumber,midiChannel);
		}else if (midiCommand == MidiEvent.PROGRAM_CHANGE){
			final ProgramChange programChange = new ProgramChange(midiData1);
			midiIns[midiChannel].sendProgramChange(programChange,deviceNumber,midiChannel);
		}
	}
}
