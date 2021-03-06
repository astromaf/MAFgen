// Sine wave generator 
//Based on Damien Di Fede's code.
// By Miguel Ángel de Frutos
//www.madebyfrutos.es

import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;
SineWave sine;

PFont font;

float freq=700;

void setup()
{
  size(512, 200, P2D);
  
  minim = new Minim(this);
  // get a line out from Minim, default bufferSize is 1024, default sample rate is 44100, bit depth is 16
  out = minim.getLineOut(Minim.STEREO);
  // create a sine wave Oscillator, set to 440 Hz, at 0.5 amplitude, sample rate from line out
  sine = new SineWave(440, 0.5, out.sampleRate());
  // set the portamento speed on the oscillator to 200 milliseconds
  sine.portamento(200);
  // add the oscillator to the line out
  out.addSignal(sine);
  
  font = loadFont("AbadiMT-CondensedLight-38.vlw"); 
}

void draw()
{
  background(0);
  stroke(255);
  // draw the waveforms
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out.bufferSize(), 0, width);
    line(x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
   
  }
  textFont(font);
  fill(255);
  text(freq+" Hz",(width/2)-65,(height/2)+50);
}

void mouseDragged()
{
  // with portamento on the frequency will change smoothly
  freq = map(mouseX, 0, width, 0, 4800);
  sine.setFreq(freq);
 
 
  sine.setPan(-1);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      freq=(int)freq+1;
    } else if (keyCode == DOWN) {
     freq=(int)freq-1;
    } 
  } else{
    freq=700;
    }
    
   sine.setFreq(freq);
}//key pressed

void stop()
{
  out.close();
  minim.stop();
  
  super.stop();
}
