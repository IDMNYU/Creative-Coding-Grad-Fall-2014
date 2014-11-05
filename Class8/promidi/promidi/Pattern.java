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

/**
 * Must be in the javax.sound.midi package because the constructor is package-private
 */
package promidi;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.Vector;

import javax.sound.midi.ShortMessage;

/**
 * A track handles all midiEvents of a song for a certain midiout. You can directly 
 * add Events like Notes or ControllerChanges to it or also work with patterns.
 */
public class Pattern{

	/**
	 * Holds the MidiEvents of the track ordered to their ticks
	 */
	private TickMapEvents tickMapEvents = new TickMapEvents();

	Vector controllerStateMessages;

	/**
	 * A map with the controller data
	 */
	private HashMap controllerMap = new HashMap();

	/**
	 * use a hashset to detect duplicate events in add(MidiEvent)
	 */
	private HashSet set = new HashSet();
	
	/**
	 * To store the playing notes
	 */
	private NoteOnCache noteOnCache = new NoteOnCache();

	/**
	 * The name of the track
	 */
	private String name;
	
	/**
	 * Song the track is added to
	 */
	private Song song;
	
	/**
	 * Length of the pattern in ticks
	 */
	private long length;
	
	/**
	 * Creates a new pattern with the given name and length
	 * @param i_name String: the name of the pattern
	 * @param i_length long: the length of the pattern in ticks
	 */
	public Pattern(
		final String i_name, 
		final long i_length
	){
		name = i_name;
		length = i_length;
		controllerStateMessages = new Vector();
		controllerStateMessages.ensureCapacity(128);
	}
	
	/////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////
	//
	// MANAGING PATTERNS
	//
	/////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////
	
	private static class Key{
		long startTick;
		long endTick;
		
		Key(
			final long i_startTick,
			final long i_endTick
		){
			startTick = i_startTick;
			endTick = i_endTick;
		}
		
		boolean tickIsInRange(final long i_tick){
			return i_tick >= startTick && i_tick <= endTick;
		}
	}
	/**
	 * the patterns of the map
	 */
	private Pattern[] patterns = new Pattern[0];
	
	private Key[] keys = new Key[0];
	
	
	private int patternSize = 0;
	
	/**
    * Increases the capacity of the arrays for the patterns and keys instance, if
    * necessary, to ensure  that it can hold at least the number of elements
    * specified by the minimum capacity argument. 
    *
    * @param   minCapacity   the desired minimum capacity.
    */
   private void ensureCapacity(final int minCapacity) {
   	int oldCapacity = patterns.length;
   	
   	if (minCapacity > oldCapacity) {
   		Pattern oldPattern[] = patterns;
   		Key oldKeys[] = keys;
	    
   		int newCapacity = (oldCapacity * 3)/2 + 1;
   	    
   		if (newCapacity < minCapacity)newCapacity = minCapacity;
	    
   		patterns = new Pattern[newCapacity];
   		keys = new Key[newCapacity];
   		System.arraycopy(oldPattern, 0, patterns, 0, patternSize);
   		System.arraycopy(oldKeys, 0, keys, 0, patternSize);
   	}
   }
   
   /**
    * Checks and sets the length value for example after removing
    * or adding an event.
    *
    */
   private void checkLength(){
   	length = tickMapEvents.getMaxTick();
		
		for(int i = 0; i < keys.length; i++){
			length = Math.max(length,keys[i].endTick);
		}
   }
   
   /**
    * quantization of the pattern
    */
   private int quantization = Q.NONE;
   
   /**
    * One bar of pattern is subdevided into 512 ticks. You can set a 
    * quantization for simplified input of events. If you set the 
    * quantization to _1_4 you can add quarter notes with the values
    * 0,1,2,3 instead of 0,128,256,384.
    * @shortdesc Sets the quantization for a pattern.
    * @param i_quantization Either: _1_2,_1_4,_1_8,_1_16,_1_32,_1_64
    * @related Quantization
    * @related getQuantization ( )
    * @related addEvent ( )
    */
   public void setQuantization(final int i_quantization){
   	quantization = i_quantization;
   }
   
   /**
    * Returns the current quantization of the pattern.
    * @return int: actual quantization o the pattern
    * @related setQuantization ( )
    */
   public int getQuantization(){
   	return quantization;
   }

	
	/**
	 * Use this method to add a pattern to this pattern. A pattern builds
	 * a sequence of events that you can place several times into several tracks.
	 * Putting patterns into patterns can be used create complex strucures.
	 * Note that if you have set a quantization
	 * @param i_pattern Pattern: the pattern to be added to the track
	 * @param i_long long: the position in ticks where the pattern should be placed
	 * @shortdesc Use this method to add a pattern to the track.
	 * @related Pattern
	 * @related removePattern ( )
	 * @related setQuantization ( )
	 */
	public void addPattern(
		final Pattern i_pattern, 
		final long i_tick
	){	
		addPattern(i_pattern,i_tick,quantization);
	}
	
	/**
	 * @param i_quantization the quantization
	 */
	public void addPattern(
		final Pattern i_pattern, 
		final long i_tick,
		final int i_quantization
	){	
		final long startTick = i_quantization*i_tick;
		final long endTick = startTick + i_pattern.ticks();
		final Key key = new Key(startTick,endTick);
		length = Math.max(length,endTick);
		ensureCapacity(patternSize + 1);  // Increments modCount!!
		patterns[patternSize] = i_pattern;
		keys[patternSize] = key;
		patternSize++;
	}
	
	/**
	 * Use this method to remove a pattern from a track. A pattern builds
	 * a sequence of events that you can place several times into several tracks.
	 * Removing a pattern removes all its events from the track. Calling the method
	 * including a tick value only deletes patterns for this tick.
	 * @param i_pattern Pattern: the pattern to be removed from the pattern
	 * @param i_tick long: position of the Pattern
	 * @shortdesc Use this method to add a pattern to the track.
	 * @related Pattern
	 * @related addPattern ( )
	 */
	public void removePattern(
		final Pattern i_pattern, 
		final long i_tick
	){
		for(int i = 0; i < patternSize; i++){
			if(patterns[i].equals(i_pattern) && (keys[i].startTick == i_tick || i_tick == -1)){

				int numMoved = patterns.length - i - 1;
				if (numMoved > 0){
				    System.arraycopy(patterns, i+1, patterns, i, numMoved);
				    System.arraycopy(keys, i+1, keys, i, numMoved);
				}
				//	Let gc do its work
				patternSize--;
				patterns[patternSize] = null; 
				keys[patternSize] = null;
			}
		}
		
		checkLength();
	}
	
	/**
	 * 
	 * @param i_pattern Pattern: the pattern to be removed from the pattern
	 */
	public void removePattern(final Pattern i_pattern){
		removePattern(i_pattern,-1);
	}
	
	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	//
	// MANAGING EVENTS
	//
	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////

	/**
	 * Adds an Event to the TickMap so that it can be played by the sequencer.
	 * If the event contains controller data it is also added to the controller
	 * map for correct looping.
	 * @param i_event MidiEvent: to be added to the tickMap
	 */
	private void addEventToTickMap(
		final MidiEvent i_event,
		final long i_tick
	){
		length = Math.max(i_tick,length);
		tickMapEvents.addEvent(i_event,i_tick);
		addToControllerMap(i_event,i_tick);
	}

	/**
	 * Adds the incoming midi even to the controller map
	 * @param i_event MidiEvent: to be added to the controllermap
	 */
	private void addToControllerMap(
		final MidiEvent i_event,
		final long i_tick
	){
		try{
			if (i_event.getCommand() == ShortMessage.CONTROL_CHANGE){

				int ccKey = ((i_event.getChannel() & 0xf) << 8) | (i_event.getData1() & 0xff);

				SortedMap ccValues;
				ccValues = (SortedMap) controllerMap.get(new Integer(ccKey));
				if (ccValues == null){
					ccValues = new TreeMap();
					controllerMap.put(new Integer(ccKey), ccValues);
				}

				ccValues.put(new Long(i_tick), new Integer(i_event.getData2()));
			}
		}catch (Exception e){
			// e.printStackTrace();
		}
	}

	/**
	 * Removes the given MidiEvent from the controller map
	 * @param i_event
	 */
	private void removeFromControllerMap(
		final MidiEvent i_event,
		final long i_tick
	){
		try{
			if (i_event.getCommand() == ShortMessage.CONTROL_CHANGE){
				int ccKey = ((i_event.getChannel() & 0xf) << 8) | (i_event.getData1() & 0xff);
				((SortedMap) controllerMap.get(new Integer(ccKey))).remove(new Long(i_tick));
			}
		}catch (Exception e){
		}
	}
	
	/**
	 * Used by the sequencer to play the events for the given tick.
	 * @param tick ,thats MidiEvents has to be returned
	 */
	void sendEventsForTick(
		final long i_tick,
		final MidiOut i_midiOut
	){
		final Vector eventsForTick = tickMapEvents.getEventsForTick(i_tick);
		
		if(eventsForTick!=null){
			for (int j = 0; j < eventsForTick.size(); j++){
				MidiEvent event = (MidiEvent)eventsForTick.get(j);
				i_midiOut.sendEvent(event);
			}
		}
		
		for(int i = 0; i < keys.length; i++){
			if(keys[i].tickIsInRange(i_tick)){
				patterns[i].sendEventsForTick(i_tick,i_midiOut);
			}
		}
	}

	/**
	 * Return a list of midimessages in order to restore controller states at a specific tick.
	 * Used when looping a sequence, or when starting playback in the middle of the song.
	 * @param i_tick
	 * @return
	 */
	private synchronized Vector getControllerStateAtTick(final long i_tick){

		controllerStateMessages.clear();
		Set controllerMapKeys = controllerMap.keySet();
		for (Iterator it = controllerMapKeys.iterator(); it.hasNext();){
			int ccKey = ((Integer) it.next()).intValue();
			SortedMap ccValues = (SortedMap) controllerMap.get(new Integer(ccKey));
			try{
				int ccValue = ((Integer) ccValues.get(ccValues.headMap(new Long(i_tick)).lastKey())).intValue();
				ShortMessage shm = new ShortMessage();
				shm.setMessage(ShortMessage.CONTROL_CHANGE, (ccKey >> 8) & 0xf, ccKey & 0xff, ccValue);
				controllerStateMessages.add(shm);
			}catch (Exception e){
			}
		}

		return controllerStateMessages;
	}
	
	/**
	 * Resets the midi controllers at the given tick. THis method is called 
	 * by the sequencer when looping a sequence, or when starting playback in 
	 * the middle of the song.
	 * @param i_tick
	 */
	void resetControllers(
		final long i_tick,
		final MidiOut i_midiOut
	){
		final Vector midiMessages = getControllerStateAtTick(i_tick);
		for (int j = 0; j < midiMessages.size(); j++){
			i_midiOut.sendEvent((MidiEvent) midiMessages.get(j));
		}
		
		for(int i = 0; i < keys.length; i++){
			if(keys[i].tickIsInRange(i_tick)){
				patterns[i].resetControllers(i_tick,i_midiOut);
			}
		}
	}

	/**
	 * Sends a noteOff for all actual notes.
	 */
	void flushNoteOnCache(
		final MidiOut i_midiOut
	){
		final Vector notes = noteOnCache.getPendingNoteOffs();
		for (int i = 0; i < notes.size(); i++){
			int note = ((Integer) notes.get(i)).intValue();
			i_midiOut.sendEvent(MidiEvent.NOTE_ON, (note >> 8) & 0xf, note & 0xff);
		}
		noteOnCache.releasePendingNoteOffs();
		
		for(int i = 0; i < patterns.length; i++){
				patterns[i].flushNoteOnCache(i_midiOut);
		}
	}
	
	/**
	 * Returns the song the track was added to
	 * @return
	 */
	Song getSong(){
		return song;
	}
	
	/**
	 * Set the song the track was added to
	 * @param i_song
	 */
	void setSong(final Song i_song){
		song = i_song;
	}
	
	/**
	 * Returns the name of the pattern.
	 * @return String: the name of the pattern
	 */
	public String getName(){
		return name;
	}
	
	/**
	 * Sets the name of the track.
	 * @param i_name String: the new name of track
	 */
	public void setName(final String i_name){
		name = i_name;
	}
	
	/**
	 * Adds a new event to the pattern or track.  However, if the event is already
	 * contained, it is not added again.  The list of events
	 * is kept in time order, meaning that this event inserted at the
	 * appropriate place in the list, not necessarily at the end.
	 * @shortdesc Adds a new event to the pattern or track.
	 * @example promidi_sequencer
	 * @param i_event the event to add
	 * @return <code>true</code> if the event did not already exist in the
	 * track and was added, otherwise <code>false</code>
	 */
	public boolean addEvent(
		final MidiEvent i_event,
		final long i_tick
	){
		if (i_event == null){
			return false;
		}
		
		if (!set.contains(i_event)){
			addEventToTickMap(i_event,i_tick * quantization);
			set.add(i_event);
			return true;
		}

		return false;
	}

	/**
	 * Removes the specified event from the track.
	 * @param i_event MidiEvent: the event to remove
	 * @param i_tick long: the position of the event to remove
	 * @return <code>true</code> if the event existed in the track and was removed,
	 * otherwise <code>false</code>
	 */
	public boolean removeEvent(
		final MidiEvent i_event,
		final long i_tick
	){
		if (set.remove(i_event)){
			tickMapEvents.removeEvent(i_event,i_tick);
			removeFromControllerMap(i_event,i_tick);
			length = tickMapEvents.getMaxTick();
			return true;
		}

		return false;
		
	}

	/**
	 * Obtains the number of events in this pattern.
	 * @return the size of the track's event vector
	 */
	public int size(){
		return set.size();
	}
	
   /**
	 * Obtains the length of the pattern, expressed in MIDI ticks. (The duration of
	 * a tick in seconds is determined by the timing resolution of the
	 * <code>Sequence</code> containing this track, and also by the tempo of
	 * the music as set by the sequencer.)
	 * @shortdesc Obtains the length of the pattern, expressed in MIDI ticks.
	 * @return the duration, in ticks
	 * @related Song
	 * @related Sequencer
	 */
	public long ticks(){
		return length;
	}
	
	
}
