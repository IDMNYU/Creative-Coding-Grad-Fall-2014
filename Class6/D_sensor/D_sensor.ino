int i;
int t;
int a;
int v;

// this is the pin i'm lighting the LED with
int theoutpin = 3; 
// this is the pin the photocell is talking to
int theinpin = A0;

void setup()
{
  i = 0;
  t = 1000;
  a = 0;
  Serial.begin(9600); // this starts the serial system
  pinMode(theoutpin, OUTPUT); // set pin 3 to be an output
}

void loop()
{
  v = analogRead(theinpin);
  // pin and the value (0-255)
  a = map(v, 100, 350, 0, 255);
  analogWrite(theoutpin, a); 
  Serial.println(v);
  i = 1-i; // flip from 0 to 1
  t = t * 0.9; // reduce to 90% of previous rate
  if(t<1) t=1000;

  delay(30);
}
