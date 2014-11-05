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

import java.util.ArrayList;
import java.util.List;

/**
 * Handles the incoming midi data defined by an an midi device and
 * an midichannel
 * @author tex
 *
 */
class MidiIn{
	/**
	 * The midichannel of the midiout
	 */
	final int midiChannel;

	/**
	 * The midi context holding the methods implemented
	 * in PApplet to invoke on incoming midi events
	 */
	private final MidiIO promidiContext;
	
	/**
	 * List of plugs to handle midi events
	 */
	private final List plugEventList;
	
	/**
	 * List of plugs handling incoming notes
	 */
	private final List plugNoteList;
	
	/**
	 * List of plugs handling incomming controller
	 */
	private final List plugControllerList;
	
	/**
	 * List of plugs handling incoming programchanges
	 */
	private final List plugProgramChangeList;
	
	/**
	 * Initializes a new MidiOutput.
	 * @param i_midiChannel int, the midiChannel of the midiout
	 * @param i_midiInDevice MidiOutPort, the midi port of the midiout
	 */
	MidiIn(final int i_midiChannel,final MidiIO i_promidiContext){
		midiChannel = i_midiChannel;
		promidiContext = i_promidiContext;
		
		plugEventList = new ArrayList();
		plugNoteList = new ArrayList();
		plugControllerList = new ArrayList();
		plugProgramChangeList = new ArrayList();
	}

	/**
	 * Looks if two MidiOuts are equal. This is the case if they have
	 * the same midiChannel and port.
	 * @return true, if the given object is equal to the MidiOut
	 */
	public boolean equals(final Object object){
		if(!(object instanceof MidiOutDevice))return false;
		final MidiIn midiOut = (MidiIn)object;
		if(midiChannel != midiOut.midiChannel) return false;
		return true;
	}	
	
	/**
	 * plugs a method with the given name of the given object
	 * @param i_object
	 * @param i_methodName
	 */
	void plug(
		final Object i_object, 
		final String i_methodName
	){
		List plugList;
		Plug plug = new Plug(i_object,i_methodName);
		switch(plug.getParameterKind()){
			case Plug.MIDIEVENT:
				plugList = plugEventList;
				break;
			case Plug.NOTE:
				plugList = plugNoteList;
				break;	
			case Plug.CONTROLLER:
				plugList = plugControllerList;
				break;
			case Plug.PROGRAMCHANGE:
				plugList = plugProgramChangeList;
				break;
			default:
				throw new RuntimeException("Error on plug "+i_methodName+" check the given event type");
		}
		
		plugList.add(plug);
	}

	/**
	 * Use this method to send a control change to the midioutput. You can send 
	 * control changes to change the sound on midi sound sources for example.
	 * @param controller Controller: the controller you want to send.
	 * @param deviceNumber 
	 */
	void sendController(
		final Controller controller,
		final int deviceNumber,
		final int midiChannel
	){
		try{
			if (promidiContext.controllerMethod != null)
				promidiContext.controllerMethod.invoke(
					promidiContext.parent, 
					new Object[] {
						controller,
						new Integer(deviceNumber),
						new Integer(midiChannel)
					}
				);
		}catch (Exception e){
			System.err.println("Disabling controller() for " + promidiContext.parent.getName() + " because of an error.");
			e.printStackTrace();
			promidiContext.controllerMethod = null;
		}
		
		for(int i = 0; i < plugControllerList.size();i++){
			((Plug)plugControllerList.get(i)).callPlug(controller);
		}
	}

	/**
	 * With this method you can send a note on to your midi output. You can send note on commands
	 * to trigger midi soundsources. Be aware that you have to take care to send note off commands
	 * to release the notes otherwise you get midi hang ons.
	 * @param note Note, the note you want to send the note on for
	 */
	void sendNoteOn(
		final Note note,
		final int deviceNumber,
		final int midiChannel
	){
		try{
			if (promidiContext.noteOnMethod != null)
				promidiContext.noteOnMethod.invoke(
					promidiContext.parent, 
					new Object[] {
						note,
						new Integer(deviceNumber),
						new Integer(midiChannel)
					}
				);
		}catch (Exception e){
			System.err.println("Disabling noteOn() for " + promidiContext.parent.getName() + " because of an error.");
			e.printStackTrace();
			promidiContext.noteOnMethod = null;
		}
		
		for(int i = 0; i < plugNoteList.size();i++){
			((Plug)plugNoteList.get(i)).callPlug(note);
		}
	}

	/**
	 * Use this method to send a note off command to your midi output. You have to send note off commands 
	 * to release send note on commands.
	 * @param note Note, the note you want to send the note off for
	 */
	void sendNoteOff(
		final Note note,
		final int deviceNumber,
		final int midiChannel
	){
		note.setToNoteOff();
		sendNoteOn(note,deviceNumber,midiChannel);
		try{
			if (promidiContext.noteOffMethod != null)
				promidiContext.noteOffMethod.invoke(
					promidiContext.parent, 
					new Object[] {
						note,
						new Integer(deviceNumber),
						new Integer(midiChannel)
					}
				);		
		}catch (Exception e){
			System.err.println("Disabling noteOff() for " + promidiContext.parent.getName() + " because of an error.");
			e.printStackTrace();
			promidiContext.noteOffMethod = null;
		}
		
		for(int i = 0; i < plugNoteList.size();i++){
			((Plug)plugNoteList.get(i)).callPlug(note);
		}
	}

	/**
	 * With this method you can send program changes to your midi output. Program changes are used 
	 * to change the preset on a midi sound source.
	 */
	void sendProgramChange(
		final ProgramChange programChange,
		final int deviceNumber,
		final int midiChannel
	){
		try{
			if (promidiContext.programChangeMethod != null)
				promidiContext.programChangeMethod.invoke(
					promidiContext.parent, 
					new Object[] {
						programChange,
						new Integer(deviceNumber),
						new Integer(midiChannel)
					}
				);
		}catch (Exception e){
			System.err.println("Disabling programChange() for " + promidiContext.parent.getName() + " because of an error.");
			e.printStackTrace();
			promidiContext.programChangeMethod = null;
		}
		
		for(int i = 0; i < plugProgramChangeList.size();i++){
			((Plug)plugProgramChangeList.get(i)).callPlug(programChange);
		}
	}
}
