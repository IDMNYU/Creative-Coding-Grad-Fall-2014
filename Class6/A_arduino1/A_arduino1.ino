int i;

void setup()
{
  i = 0;
  Serial.begin(9600);
}

void loop()
{
  Serial.println(i);
  i++;
}
