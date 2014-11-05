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

import promidi.Controller;
import promidi.Note;

abstract class MidiEventProcessor{

	long startTick;

	long endTick;

	boolean[] channels = new boolean[16];

	abstract void processNoteEvent(Note event);

	abstract void processControllerEvent(Controller event);

	/**
	 * Set channels that may pass through the filter
	 * @param channels Array of integers containing channel numbers
	 */
	void setChannels(int[] channels){
		for (int n = 0; n < 16; n++)
			this.channels[n] = false;
		for (int i = 0; i < channels.length; i++)
			this.channels[i] = true;
	}

	boolean canProcessChannel(int channel){
		return channels[channel];
	}

	long getStartTick(){
		return startTick;
	}

	void setStartTick(long startTick){
		this.startTick = startTick;
	}

	long getEndTick(){
		return endTick;
	}

	void setEndTick(long endTick){
		this.endTick = endTick;
	}

}
