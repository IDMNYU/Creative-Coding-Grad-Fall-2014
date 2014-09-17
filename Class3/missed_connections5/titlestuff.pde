
// startup screen
void doloadingscreen()
{
  background(0x00);
  textAlign(LEFT, BASELINE);
  text("missed connections", 0, 20);
  text("r. luke dubois", 0, 40);
  text("loading... " + citytext, 0, 80);
  text((int)((((loadptr1+loadptr2)/2)/(float)LINKNUM)*100)+"%", 0, 100);
  fill(0);
  stroke(255);
  rect(50, 90, (LINKNUM+LINKNUM)*2, 10);
  noStroke();
  fill(255);
  rect(50, 90, (loadptr1+loadptr2)*2, 10);
  if (loadptr1<t1) parsesuburl_w4m();
  if (loadptr2<t2) parsesuburl_m4w();
  if (loadptr1==t1&&loadptr2==t2) {
    loaded=1;
    frameptr = 0;
  }
}

// selection screen, incl. mouse hover
void doselectionscreen()
{
  background(0x00);
  fill(255);
  text("missed connections", 0, 20);
  text("r. luke dubois", 0, 40);
  text("pick a city:", 0, 80);
  for (int i = 0;i<cityURLs.length;i++)
  {
    if (mouseX>cityrects[i][0]&&mouseX<cityrects[i][1]&&mouseY>cityrects[i][2]&&mouseY<cityrects[i][3])
    {
      fill(255, 128, 255);
    }
    else
    {
      fill(255);
    }

    text(citytexts[i], 0, 100+i*20);
    cityrects[i][0] = 0;
    cityrects[i][1] = (int)textWidth(citytexts[i]);
    cityrects[i][2] = 100+i*20-12;
    cityrects[i][3] = 100+i*20;
  }

  if (mouseX>0&&mouseX<textWidth(eline)&&mouseY>citytexts.length*20+120-12&&mouseY<citytexts.length*20+120)
  {
    fill(255, 128, 255);
  }
  else
  {
    fill(255);
  }

  text(eline, 0, citytexts.length*20+120);
}

// mouse click callback
void checkselection()
{
  int selection = -1;
  for (int i=0;i<cityURLs.length;i++)
  {
    if (mouseX>cityrects[i][0]&&mouseX<cityrects[i][1]&&mouseY>cityrects[i][2]&&mouseY<cityrects[i][3])
    {
      selection = i;
      break;
    }
  }
  if (selection>-1)
  {
    city = cityURLs[selection]; 
    citytext = citytexts[selection];
    started = 1;
  }

  if (mouseX>0&&mouseX<textWidth(eline)&&mouseY>citytexts.length*20+120-12&&mouseY<citytexts.length*20+120)
  {
    link(eURL);
  }

}

