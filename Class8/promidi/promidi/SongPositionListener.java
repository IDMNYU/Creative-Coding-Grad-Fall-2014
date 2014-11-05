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
 * Use this interface to implement any component that depend on the song position.
 * This could be a metronome, a graphical song position indicator etc.
 */
interface SongPositionListener {
    /**
     * This method is called each time a new tick is played by the sequencer. Note
     * that this method should return as soon as possible (immediately).
     * @param tick
     */
    void notifyTickPosition(long tick);
}
