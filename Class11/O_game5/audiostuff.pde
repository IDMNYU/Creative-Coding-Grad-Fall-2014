
void playscene0()
{
  introsound.cue(0); //rewind
  introsound.play();
}

void playscene2()
{
  scenesound.cue(0); //rewind
  scenesound.play();
}

void playronnie()
{
  //println("HERE'S RONNIE!");
  int voicematch = -1;
  for (int i = 0; i<rgroove.length; i++)
  {
    if (rgroove[i].isPlaying()==false)
    {
      voicematch = i;
      break;
    }
  }
  if (voicematch>-1) {
    rgroove[voicematch].cue(0);
    rgroove[voicematch].play();
  }
}

void playhalf()
{
  int voicematch = -1;
  for (int i = 0; i<groove.length; i++)
  {
    if (groove[i].isPlaying()==false)
    {
      voicematch = i;
      break;
    }
  }
  if (voicematch>-1) {
    groove[voicematch].cue(0);
    groove[voicematch].play();
  }
}

