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

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.sound.midi.MidiSystem;
import javax.sound.midi.MidiUnavailableException;

/**
 * MidiIO is the base class for managing the available midi ports. 
 * It provides you with methods to get information on your ports and 
 * to open them. There are various changes on the new proMIDI version
 * in handling inputs and outputs. Instead of opening a complete port
 * you can now open inputs and outputs with a channel number and a 
 * port name or number. To start use the printDevices method to get
 * all devices available on your system.
 * @example promidi_midiio
 * @related MidiOut
 * @related Note
 * @related Controller
 * @related ProgramChange
 * @related printDevices ( )
 */
public class MidiIO{

	/**
	 * PApplet proMidi is running in
	 */
	processing.core.PApplet parent;

	/**
	 * Method to check if the parent Applet calls noteOn
	 */
	Method noteOnMethod;

	/**
	 * Method to check if the parent Applet calls noteOn
	 */
	Method noteOffMethod;

	/**
	 * Method to check if the parent Applet calls controllerIn
	 */
	Method controllerMethod;

	/**
	 * Method to check if the parent Applet calls programChange
	 */
	Method programChangeMethod;

	/**
	 * Stores all available midi input devices
	 */
	final private Vector midiInputDevices = new Vector();

	/**
	 * Stores all available midi output devices
	 */
	final private Vector midiOutDevices = new Vector();

	/**
	 * Contains all open midiouts
	 */
	final private Map openMidiOuts = new HashMap();

	/**
	 * Stores the MidiIO instance;
	 */
	private static MidiIO instance;

	/**
	 * Initialises a new MidiIO object.
	 * @param parent
	 */
	private MidiIO(processing.core.PApplet parent){
		this.parent = parent;
		parent.registerDispose(this);

		try{
			noteOnMethod = parent.getClass().getMethod("noteOn", new Class[] {Note.class,Integer.TYPE,Integer.TYPE});
		}catch (Exception e){
			// no such method, or an error.. which is fine, just ignore
		}
		try{
			noteOffMethod = parent.getClass().getMethod("noteOff", new Class[] {Note.class,Integer.TYPE,Integer.TYPE});
		}catch (Exception e){
			// no such method, or an error.. which is fine, just ignore
		}
		try{
			controllerMethod = parent.getClass().getMethod("controllerIn", new Class[] {Controller.class,Integer.TYPE,Integer.TYPE});
		}catch (Exception e){
			// no such method, or an error.. which is fine, just ignore
		}
		try{
			programChangeMethod = parent.getClass().getMethod("programChange", new Class[] {ProgramChange.class,Integer.TYPE,Integer.TYPE});
		}catch (Exception e){
			// no such method, or an error.. which is fine, just ignore
		}
		getAvailablePorts();
	}

	private MidiIO(){
		getAvailablePorts();
	}

	/**
	 * Use this method to get instance of MidiIO. It makes sure that only one 
	 * instance of MidiIO is initialized. You have to give this method a reference to 
	 * your applet, to let promidi communicate with it.
	 * @param parent PApplet, reference to the parent PApplet
	 * @return MidiIO, an instance of MidiIO for midi communication
	 * @example promidi_midiio
	 * @shortdesc Use this method to get instance of MidiIO.
	 * @related openInput ( )
	 * @related getMidiOut ( )
	 * @related printDevices ( )
	 */
	public static MidiIO getInstance(processing.core.PApplet parent){
		if (instance == null){
			instance = new MidiIO(parent);
		}
		return instance;
	}

	public static MidiIO getInstance(){
		if (instance == null){
			instance = new MidiIO();
		}
		return instance;
	}

	/**
	 * Throws an exception if an invalid midiChannel number is put in
	 * @param i_midiChannel
	 * @invisible
	 */
	public static void checkMidiChannel(final int i_midiChannel){
		if (i_midiChannel < 0 || i_midiChannel > 15){
			throw new RuntimeException("Invalid midiChannel make sure you have a channel number between 0 and 15.");
		}
	}

	/**
	 * The dispose method to close all opened ports.
	 * @invisible
	 */
	public void dispose(){
		closePorts();
	}

	/**
	 * Method to get all available midi ports and add them to the corresponding
	 * device list.
	 */
	private void getAvailablePorts(){
		javax.sound.midi.MidiDevice.Info[] infos = MidiSystem.getMidiDeviceInfo();
		for (int i = 0; i < infos.length; i++){
			try{
				javax.sound.midi.MidiDevice theDevice = MidiSystem.getMidiDevice (infos[i]);
				
				if (theDevice instanceof javax.sound.midi.Sequencer) {
					// Ignore this device as it's a sequencer
				}else if (theDevice.getMaxReceivers () != 0) {
					midiOutDevices.add(theDevice);
				}else if (theDevice.getMaxTransmitters () != 0) {
					midiInputDevices.add(theDevice);
				}
			}catch (MidiUnavailableException e){
				e.printStackTrace();
			}
		}
	}

	/**
	 * Use this method to get the number of available midi input devices.
	 * @return int, the number of available midi inputs
	 * @example promidi_midiio
	 * @related numberOfOutputDevices ( )
	 * @related getInputDeviceName ( )
	 * @related getOutputDeviceName ( )
	 */
	public int numberOfInputDevices(){
		return midiInputDevices.size();
	}

	/**
	 * Use this method to get the number of available midi output devices.
	 * @return int, the number of available midi output devices.
	 * @example promidi_midiio
	 * @related numberOfInputDevices ( )
	 * @related getInputDeviceName ( )
	 * @related getOutputDeviceName ( )
	 */
	public int numberOfOutputDevices(){
		return midiOutDevices.size();
	}

	/**
	 * Use this method to get the name of an input device.
	 * @param input int, number of the input
	 * @return String, the name of the input
	 * @example promidi_midiio
	 * @related numberOfInputDevices ( )
	 * @related numberOfOutputDevices ( )
	 * @related getOutputDeviceName ( )
	 */
	public String getInputDeviceName(final int input){
		return ((MidiInDevice) midiInputDevices.get(input)).getName();
	}

	/**
	 * Use this method to get the name of an output device.
	 * @param output int, number of the output
	 * @return String, the name of the output
	 * @example promidi_midiio
	 * @related numberOfInputDevices ( )
	 * @related numberOfOutputDevices ( )
	 * @related getInputDeviceName ( )
	 */
	public String getOutputDeviceName(final int output){
		return ((MidiOutDevice) midiOutDevices.get(output)).getName();
	}

	/**
	 * Use this method for a simple trace of all available midi input devices.
	 * @example promidi_midiio
	 * @related printOutputDevices ( )
	 * @related printDevices ( )
	 */
	public void printInputDevices(){
		System.out.println("<< inputs: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		for (int i = 0; i < numberOfInputDevices(); i++){
			System.out.println("input " + /*parent.nf(*/i/*,2)*/+ " : " + getInputDeviceName(i));
		}
	}

	/**
	 * Use this method for a simple trace of all available midi output devices.
	 * @example promidi_midiio
	 * @related printInputDevices ( )
	 * @related printDevices ( )
	 */
	public void printOutputDevices(){
		System.out.println("<< outputs: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		for (int i = 0; i < numberOfOutputDevices(); i++){
			System.out.println("output " + /*parent.nf(*/i/*,2)*/+ " : " + getOutputDeviceName(i));
		}
	}

	/**
	 * Use this method for a simple trace of all midi devices. Call
	 * this method before working with proMIDI to get the numbers and
	 * names of the installed devices
	 * @example promidi_midiio
	 * @shortdesc Use this method for a simple trace of all midi devices.
	 * @related printInputDevices ( )
	 * @related printOutputDevices ( )
	 */
	public void printDevices(){
		printInputDevices();
		printOutputDevices();
		System.out.println("<<>>>>>>>>> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
	}

	/**
	 * Use this Methode to open an input device. You can open an 
	 * input device with its number or with its name. Once a input device is opened 
	 * it is reserved for your program. All opened devices are closed 
	 * by promidi when you close your application. You can also close opened devices 
	 * on your own.<br>
	 * Note that you open inputs with midi channels now, this makes you more
	 * flexible with handling incoming mididata. Instead of opening an input and
	 * analysing the incoming events in noteOn, controllerIn, noteOff or programChange
	 * you could use the plug method to directly forward the incoming events to
	 * a method and object of your choice.
	 * @param inputDeviceNumber int, number of the inputdevice to open
	 * @param midiChannel int, the midichannel of the input to open
	 * @shortdesc Use this Methode to open an input device.
	 * @example promidi_reflection
	 * @related getMidiOut ( )
	 * @related plug ( )
	 */
	public void openInput(
		final int inputDeviceNumber, 
		final int midiChannel
	){
		checkMidiChannel(midiChannel);
		MidiInDevice midiInDevice = (MidiInDevice) midiInputDevices.get(inputDeviceNumber);
		midiInDevice.open();
		midiInDevice.openMidiChannel(midiChannel);
	}

	/**
	 * @param inputDeviceName String, name of the input to open
	 */
	public void openInput(final String inputDeviceName, final int midiChannel){
		checkMidiChannel(midiChannel);
		for (int i = 0; i < numberOfInputDevices(); i++){
			MidiInDevice midiInDevice = (MidiInDevice) midiInputDevices.get(i);
			if (midiInDevice.getName().equals(inputDeviceName)){
				midiInDevice.open();
				midiInDevice.openMidiChannel(midiChannel);
			}
		}
		throw new RuntimeException("There is no input device with the name " + inputDeviceName + ".");
	}

	/**
	 * Plug is a handy method to handle incoming midiEvents. To create a plug
	 * you have to implement a method that gets a Note, a Controller or a ProgramChange
	 * as input parameter. Now you can plug these methods using this method and
	 * the correspoding midievents are send to the plugged method.
	 * @param i_object Object: the object thats method has to plugged
	 * @param i_methodName String: the name of the method that has to be plugged
	 * @param i_intputDeviceNumber int: the number of the device thats events areto the plug
	 * @param i_midiChannel int: the midichannel thats events areto the plug
	 * @example promidi_plug
	 * @shortdesc Plugs a method to handle incoming MidiEvents.
	 * @related Note
	 * @related Controller
	 * @related ProgramChange
	 */
	public void plug(
		final Object i_object, 
		final String i_methodName, 
		final int i_intputDeviceNumber, 
		final int i_midiChannel
	){
		MidiInDevice midiInDevice = (MidiInDevice) midiInputDevices.get(i_intputDeviceNumber);
		midiInDevice.plug(i_object,i_methodName,i_midiChannel);
	}

	/**
	 * Use this Methode to open an output. You can open an 
	 * output with its number or with its name. Once the output is opened 
	 * it is reserved for your program. All opened ports are closed 
	 * by promidi when you close your applet. You can also close opened Ports 
	 * on your own.
	 * @param outDeviceNumber int, number of the output to open
	 * @shortdesc Use this Methode to open an output.
	 * @example promidi
	 * @related openInput ( )
	 */
	public MidiOut getMidiOut(final int midiChannel, final int outDeviceNumber){
		checkMidiChannel(midiChannel);
		try{
			final String key = midiChannel + "_" + outDeviceNumber;
			if (!openMidiOuts.containsKey(key)){
				MidiOutDevice midiOutDevice = (MidiOutDevice) midiOutDevices.get(outDeviceNumber);
				midiOutDevice.open();
				final MidiOut midiOut = new MidiOut(midiChannel, midiOutDevice);
				openMidiOuts.put(key, midiOut);
			}
			return (MidiOut) openMidiOuts.get(key);
		}catch (RuntimeException e){
			e.printStackTrace();
			throw new RuntimeException("You wanted to open the unavailable output " + outDeviceNumber + ". The available outputs are 0 - " + (numberOfOutputDevices() - 1) + ".");
		}
	}

	/**
	 * @param outDeviceName String, name of the Output to open
	 */
	public MidiOut getMidiOut(final int midiChannel, final String outDeviceName){
		for (int i = 0; i < numberOfOutputDevices(); i++){
			MidiOutDevice midiOutDevice = (MidiOutDevice) midiOutDevices.get(i);
			if (midiOutDevice.getName().equals(outDeviceName)){
				return getMidiOut(midiChannel, i);
			}
		}
		throw new UnavailablePortException("There is no output with the name " + outDeviceName + ".");
	}

	/**
	 * Use this Methode to close an input. You can close it with its number or name. 
	 * There is no need of closing the ports, as promidi closes them when the applet 
	 * is closed.
	 * @param inputNumber int, number of the input to close
	 */
	public void closeInput(int inputNumber){
		try{
			MidiInDevice inDevice = (MidiInDevice) midiInputDevices.get(inputNumber);
			inDevice.close();
		}catch (ArrayIndexOutOfBoundsException e){
			throw new UnavailablePortException("You wanted to close the unavailable input " + inputNumber + ". The available inputs are 0 - " + (midiInputDevices.size() - 1) + ".");
		}

	}

	/**
	 * @param outputName String, name of the Input to close
	 */
	public void closeInput(String inputName){
		for (int i = 0; i < numberOfInputDevices(); i++){
			MidiInDevice inDevice = (MidiInDevice) midiInputDevices.get(i);
			if (inDevice.getName().equals(inputName)){
				closeInput(i);
				return;
			}
		}
		throw new UnavailablePortException("There is no input with the name " + inputName + ".");
	}

	/**
	 * Use this Methode to close an output. You can close it with its number or name. 
	 * There is no need of closing the ports, as promidi closes them when the applet 
	 * is closed.
	 * @invisible
	 * @param outputNumber int, number of the output to close
	 */
	public void closeOutput(int outputNumber){
		try{
			MidiOutDevice outDevice = (MidiOutDevice) midiOutDevices.get(outputNumber);
			outDevice.close();
		}catch (ArrayIndexOutOfBoundsException e){
			throw new UnavailablePortException("You wanted to close the unavailable output " + outputNumber + ". The available outputs are 0 - " + (midiOutDevices.size() - 1) + ".");
		}
	}

	/**
	 * @invisible
	 * @param outputName String, name of the Output to close
	 */
	public void closeOutput(String outputName){
		for (int i = 0; i < numberOfOutputDevices(); i++){
			MidiOutDevice outDevice = (MidiOutDevice) midiOutDevices.get(i);
			if (outDevice.getName().equals(outputName)){
				closeOutput(i);
				return;
			}
		}
		throw new UnavailablePortException("There is no output with the name " + outputName + ".");
	}

	/**
	 * Use this Methode to close all opened inputs. 
	 * There is no need of closing the ports, as promidi closes them when the applet 
	 * is closed.
	 * @invisible
	 */
	public void closeInputs(){
		for (int i = 0; i < numberOfInputDevices(); i++){
			closeInput(i);
		}
	}

	/**
	 * Use this Methode to close all opened outputs. 
	 * There is no need of closing the ports, as promidi closes them when the applet 
	 * is closed.
	 * @invisible
	 */
	public void closeOutputs(){
		for (int i = 0; i < numberOfOutputDevices(); i++){
			closeOutput(i);
		}
	}

	/**
	 * Use this Methode to close all opened ports. 
	 * There is no need of closing the ports, as promidi closes them when applet 
	 * is closed.
	 * @invisible
	 */
	public void closePorts(){
		closeInputs();
		closeOutputs();
	}
}
