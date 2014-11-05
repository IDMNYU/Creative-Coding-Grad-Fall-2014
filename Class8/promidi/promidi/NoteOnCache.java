/*
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

import java.util.Vector;

import javax.sound.midi.MidiMessage;
import javax.sound.midi.ShortMessage;

/**
 * A cache object to keep hold of notes that are currently on.
 */
class NoteOnCache{

	private Vector pendingNoteOffs = new Vector();

	NoteOnCache(){
		pendingNoteOffs.ensureCapacity(256);
	}

	void interceptMessage(MidiMessage msg){
		try{
			ShortMessage shm = (ShortMessage) msg;
			if (shm.getCommand() == ShortMessage.NOTE_ON){
				if (shm.getData2() == 0){
					pendingNoteOffs.remove(new Integer(shm.getChannel() << 8 | shm.getData1()));
				}else
					pendingNoteOffs.add(new Integer(shm.getChannel() << 8 | shm.getData1()));
			}
		}catch (Exception e){
		}
	}

	Vector getPendingNoteOffs(){
		return pendingNoteOffs;
	}

	void releasePendingNoteOffs(){
		pendingNoteOffs.clear();
	}
}
