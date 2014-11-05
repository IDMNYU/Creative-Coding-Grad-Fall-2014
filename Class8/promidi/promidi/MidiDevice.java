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

abstract class MidiDevice{

	/**
	 * the MidiDevice for this input
	 */
	final javax.sound.midi.MidiDevice midiDevice;
	
	/**
	 * the number of the midiDevice
	 */
	final int deviceNumber;

	/**
	 * Initializes a new MidiIn.
	 * @param libContext
	 * @param midiDevice
	 * @throws MidiUnavailableException
	 */
	MidiDevice(
		final javax.sound.midi.MidiDevice midiDevice, 
		final int deviceNumber
	){
		this.midiDevice = midiDevice;
		this.deviceNumber = deviceNumber;
	}
	
	String getName(){
		return midiDevice.getDeviceInfo().getName();
	}
	
	void open(){
		try{
			if(!midiDevice.isOpen()){
				midiDevice.open();
			}
			}catch (Exception e){
				throw new RuntimeException(
					"You wanted to open an unavailable output device: "+deviceNumber + " "+getName()
				);
			}
	}

	/**
	 * Closes this device
	 */
	public void close(){
		if(midiDevice.isOpen())midiDevice.close();
	}

}
