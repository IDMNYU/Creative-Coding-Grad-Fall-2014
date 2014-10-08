int i;
int t;
int a;

// this is the pin i'm lighting the LED with
int theoutpin = 3; 

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
  // pin and the value (0 or 1, LOW or HIGH)
  analogWrite(theoutpin, a); 
  Serial.println(i);
  i = 1-i; // flip from 0 to 1
  t = t * 0.9; // reduce to 90% of previous rate
  if(t<1) t=1000;
  a = (a+1)%255;
//  delay(t);
  delay(30);
}
