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

import java.util.SortedMap;
import java.util.TreeMap;
import java.util.Vector;

/**
 * A song is a data structure containing musical information 
 * that can be played back by the proMIDI sequencer object. Specifically, the
 * song contains timing information and one or more tracks.  Each track consists of a
 * series of MIDI events (such as note-ons, note-offs, program changes, and meta-events).
 * <br><br>
 * A sequence can be built from scratch by adding new
 * tracks to an empty song, and adding MIDI events to these tracks.
 */
public class Song{
	/**
	 * keeps the tracks of the song
	 */
    private Vector songTracks = new Vector();
	
	
	/**
	 * Set to keep all ticks with events
	 */
	private SortedMap ticks = new TreeMap();
	
	/**
	 * Name of the song
	 */
	private String name = "";
	
	/**
	 * tempo of the song
	 */
	private float tempo = 120;
	
   /**
    * The timing resolution of the song.
    * @see #getResolution
    */
   protected int resolution;

	public Song(final int resolution){
		this.resolution = resolution;
	}
	
	/**
	 * Builds a new Song with a name, and a tempo.
	 * @param name String, name of the song
	 * @param tempo float, tempo of the song
	  * @throws InvalidMidiDataException
	 */
	public Song(String name,float tempo){
		this(128);
		this.name = name;
		this.tempo = tempo;
	}
	
	/**
	 * Adds a new track to a song.
	 * @param i_track Track, track to add to the song
	 */
	public void addTrack(final Track i_track){
		if(!songTracks.contains(i_track)){
			songTracks.addElement(i_track);
			i_track.setSong(this);
		}
	}
	
	/**
	 * Removes a track from a song
	 * @param track Track, track to remove from the song
	 */
	public void removeTrack(Track track){
		songTracks.removeElement(track);
	}
	
	void addTick(long tick){
		Long objectTick = new Long(tick);
		if(!ticks.containsKey(objectTick)){
			ticks.put(objectTick,new Integer(0));
		}
	}
	
	/**
	 * Returns the number of tracks of this song
	 * @return the number of tracks
	 */
	public int getNumberOfTracks(){
		return songTracks.size();
	}
	
	/**
	 * Returns the track with the given number
	 * @param i int, number of the track
	 * @return Track, the track with the given number
	 */
	public Track getTrack(int i){
		return (Track)songTracks.get(i);
	}

	/**
	 * Returns the name of a song.
	 * @return String, name of the song
	 */
	public String getName(){
		return name;
	}

	/**
	 * Sets the name name of a song.
	 * @param name String, new name for the song
	 */
	public void setName(String name){
		this.name = name;
	}

	/**
	 * Returns the tempo of a song in BPM.
	 * @return float, tempo of the song
	 */
	public float getTempo(){
		return tempo;
	}

	/**
	 * Sets the tempo of a song.
	 * @param tempo float, new tempo for the song
	 */
	public void setTempo(float tempo){
		this.tempo = tempo;
	}
}
