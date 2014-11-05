// L-systems.  rock on!

// midi stuff
import promidi.*;
MidiIO midiIO;
MidiOut midiOut;
Note note;

int position = 0;
int thepitch = 60;

// L-systems stuff
// set the number of generations
int generations = 3;

// what we're gonna start with
String axiom = "F";

// we need an array of rules
String[][] rules = {
{"F", "Ff++F-F-F--f+F+F"},
{"f", "fF--f+f+f++F-f-f"},
};

String instring, outstring;

int i, j, k;
int ismatching = 0;


void setup()
{
  size(128, 128);
  frameRate(8);

  // do the MIDI setup stuff
  midiIO = MidiIO.getInstance(this);
  midiIO.printDevices();
  midiOut = midiIO.getMidiOut(0, 0);
  midiOut.sendProgramChange(
        new ProgramChange(11)
  );

  // run the L-system
  instring = axiom;
  println("axiom:" + axiom);

  for (i=0;i<generations;i++) // 1 - loop through the generations
  {
    outstring = "";
    for (j=0;j<instring.length();j++) // 2 - loop through the input string
    {
      ismatching = 0;
      for (k=0;k<rules.length;k++) // 3 - loop through the rules
      {
        if (instring.charAt(j)==rules[k][0].charAt(0)) ismatching++;
        if (ismatching>0) {
          outstring=outstring+rules[k][1];
          k = rules.length;
        }
      }
      if (ismatching==0)
      {
        outstring=outstring+instring.charAt(j);
      }
    }
    instring = outstring; // we know we're doing this at the end
    println(i + ": " + outstring);
  }
}

void draw()
{
  int needsF = 1;
  
  while(needsF==1)
  {
    if(instring.charAt(position)=='F')
    {
      note = new Note(thepitch, 100, 50);
      midiOut.sendNote(note);
      needsF=0;
    }
    if(instring.charAt(position)=='f')
    {
      note = new Note(thepitch-12, 100, 50);
      midiOut.sendNote(note);
      note = new Note(thepitch+12, 100, 50);
      midiOut.sendNote(note);
      needsF=0;
    }
    if(instring.charAt(position)=='+')
    {
       thepitch=thepitch+7;
    }
    if(instring.charAt(position)=='-')
    {
      thepitch=thepitch-7;
    }
    position++;
    if(position>=instring.length()) position=0;
  }
}

void mousePressed()
{

  note = new Note(mouseX, mouseY, 1000);
  midiOut.sendNote(note);
}

