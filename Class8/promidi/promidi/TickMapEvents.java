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

import java.util.HashMap;
import java.util.Vector;


/**
 * This class is for the mapping of the midievents of a sequence to the different ticks.
 *
 */
class TickMapEvents{
	/**
	 * HashMap for the mapping of the ticks and the MidiEvents
	 */
	private HashMap tickMap = new HashMap();
	
	/**
	 * Method to check if the TickMap does already contain the given tick.
	 * @param tick, tick to check
	 * @return true, if the TickMap does contain this tick
	 */
	boolean containsTick(final long i_tick){
		return tickMap.containsKey(new Long(i_tick));
	}
	
	/**
	 * Method to add a tick to the TickMap.
	 * @param tick, tick to add to the TickMap
	 */
	void addTick(final long i_tick){
		tickMap.put(new Long(i_tick),new Vector());
	}
	
	/**
	 * Method to get all MidiEvents set on a tick
	 * @param i_tick 
	 * @return EventList containing all the MidiEvents for the given tick
	 */
	Vector getEventsForTick(final long i_tick){
		return (Vector)tickMap.get(new Long(i_tick));
	}
	
	/**
	 * Method to add an Event to the TickMap
	 * @param event, event to be added
	 */
	void addEvent(
		final MidiEvent i_event,
		final long i_tick
	){
		if (!containsTick(i_tick)){
			addTick(i_tick);
		}
		getEventsForTick(i_tick).add(i_event);
	}
	
	/**
	 * Removes a MidiEvent from the TickMap.
	 * @param event, MidiEvent that has to be removed
	 */
	void removeEvent(
		final MidiEvent i_event,
		final long i_tick
	){
		getEventsForTick(i_tick).remove(i_event);
	}
	
	long getMaxTick(){
		long result = 0;
		Object[] ticks = tickMap.keySet().toArray();
		for(int i = 0; i < ticks.length; i++){
			result = Math.max(result,((Long)ticks[i]).longValue());
		}
		return result;
	}
}
