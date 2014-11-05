
import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;

Minim minim; // this is an audio object
AudioInput in; // this is the audio input [adc~]
AudioOutput out; // this is the audio output [dac~]
FFT         fft; // this is an FFT - analysis
Oscil[]       wave = new Oscil[50]; // these are 50 sine waves

IntDict scale;

int pitch;

float fund = 500.;


void setup()
{
  size(512, 200, P3D);

  // start the audio engine!!!!
  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  // start an FFT
  fft = new FFT( in.bufferSize(), in.sampleRate() );

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  for (int i = 0; i<wave.length; i++)
  {
    wave[i] = new Oscil( fund*(i+1), 0.01f, Waves.SINE );
    wave[i].patch( out );
  }

  loadDictionary();
}


void draw()
{
  background(0); // clear the background

  fft.forward(in.mix); // analyze my voice

  // DRAW A WAVEFORM - TIME DOMAIN
  stroke(255, 255, 255);
  for (int i = 0; i < in.bufferSize () - 1; i++)
  {
    line(i, 50  + in.left.get(i)*50, i+1, 50  + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  
  // DRAW A SPECTROGRAM - FREQUENCY DOMAIN
  stroke(255, 0, 0);
  for (int i = 0; i < fft.specSize (); i++)
  {
    // draw the line for frequency band i, scaling it up a bit so we can see it
    line( i, height, i, height - fft.getBand(i)*8 );
  }

  // MAKE THE SOUND
  fund = mtof(pitch); // figure what frequency we want

  for (int i = 0; i<wave.length; i++)
  {
    wave[i].setFrequency(fund*(i+1));
    float amp = fft.getFreq(fund*(i+1))/200.;
    wave[i].setAmplitude(amp);
  }
}

float mtof(int note) // mtof
{
  return (440. * exp(0.057762265 * (note - 69.)));
}

void loadDictionary()
{
  scale = new IntDict();
  scale.set("a", 60);
  scale.set("s", 62);
  scale.set("d", 63);
  scale.set("f", 65);
  scale.set("g", 67);
  scale.set("h", 68);
  scale.set("j", 70);
  scale.set("k", 72);
  scale.set("l", 74);

  pitch = scale.get("a");
}

void keyPressed()
{
  String foo = new String(key+"");
  pitch = scale.get(foo);
}

