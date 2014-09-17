void donewmatch()
{
  // pick a random girl and random boy
  girl = (int)random(0, t1);
  boy = (int)random(0, t2);
  matchcount = 0;
  thescore = 0;
  firedlinks=0;
  gsize = min(w4m[girl].length, MAXWORDS);
  bsize = min(m4w[boy].length, MAXWORDS);
  wgx = new float[gsize];
  wgy = new float[gsize];
  wbx = new float[bsize];
  wby = new float[bsize];
  mgx = new float[gsize];
  mgy = new float[gsize];
  mbx = new float[bsize];
  mby = new float[bsize];
  mmm = new String[max(gsize, bsize)];
  
  // figure out loop length...
  LOOPLEN = max(MINLOOPLEN, (int)(((gsize+bsize)/WPM)*60.*24.));
  for (int i = 0;i<gsize;i++)
  {
    wgx[i] = -1;
    wgy[i] = -1;
    mgx[i] = -1;
    mgy[i] = -1;
  }
  for (int i = 0;i<bsize;i++)
  {
    wbx[i] = -1;
    wby[i] = -1;
    mbx[i] = -1;
    mby[i] = -1;
  }

  for (int i = 0;i<gsize;i++)
  {
    for (int j = 0;j<bsize;j++)
    {
      if (w4m[girl][i].equals(m4w[boy][j])) // match!
      {
        if (w4m[girl][i].indexOf(".")==-1) {
          if (w4m[girl][i].indexOf(" ")==-1) {
            if (w4m[girl][i].length()>0) {
              mgx[i] = 0;
              mbx[j] = 0;
              int newmatch = 1;
              for (int k =0;k<matchcount;k++)
              {
                if (mmm[k].equals(w4m[girl][i])) // we have this word already
                {
                  newmatch = 0;
                  k=matchcount;
                }
              }
              if (newmatch==1)
              {
                mmm[matchcount] = w4m[girl][i];
                matchcount++;
              }
            }
          }
        }
      }
    }
  }
  // figure out score
  for (int i = 0;i<matchcount;i++)
  {
    String p = pos(mmm[i]);
    thescore+=pos2score(p);
  }

  nummatches++;

}

void dopredraw()
{
  // clear the screen
  background(0x00);
  fill(0x00);
  textAlign(LEFT, BASELINE);

  float gx = 0;
  float gy = 20;
  float bx = 0;
  float by = 0;

  // predraw girls
  for (int i = 0;i<gsize;i++)
  {
    if (gx+textWidth(w4m[girl][i])>width) // linewrap
    {
      gx = 0;
      gy += fontsize;
    }
    if (mgx[i]>-1) { // matching word
      mgx[i]=gx+(textWidth(w4m[girl][i])/2.0);
      mgy[i]=gy;
    }
    wgx[i] = gx;
    wgy[i] = gy;
    gx+=textWidth(w4m[girl][i])+(fontsize/2);
  }
  // predraw boys
  //by = gy+256;
  by = max(gy+256, height*0.666666);
  for (int i = 0;i<bsize;i++)
  {
    if (bx+textWidth(m4w[boy][i])>width) // linewrap
    {
      bx = 0;
      by += fontsize;
    }
    if (mbx[i]>-1) {
      mbx[i]=bx+(textWidth(m4w[boy][i])/2.0);
      mby[i]=by;
    }
    wbx[i] = bx;
    wby[i] = by;
    bx+=textWidth(m4w[boy][i])+(fontsize/2);
  }
}

void domatchwords()
{
  int st = 0;
  int ed = (int)(LOOPLEN*0.25);
  int nframes = ed-st;
  int gstep = ceil(gsize/(float)nframes);
  int bstep = ceil(bsize/(float)nframes);

  fill(255, 128, 128);
  textAlign(LEFT, BASELINE);
  for (int i = gstep*(frameptr-st);i<min(gstep*(frameptr-st+1),gsize);i++)
  {
    if (mgx[i]>-1) { // matching word
      text(w4m[girl][i], wgx[i], wgy[i]);
    }
  }
  fill(128, 128, 255);
  for (int i = bstep*(frameptr-st);i<min(bstep*(frameptr-st+1),bsize);i++)
  {
    if (mbx[i]>-1) { // matching word
      text(m4w[boy][i], wbx[i], wby[i]);
    }
  }
}

void dootherwords()
{
  int st = (int)(LOOPLEN*0.25);
  int ed = (int)(LOOPLEN*0.4);
  int nframes = ed-st;
  int gstep = ceil(gsize/(float)nframes);
  int bstep = ceil(bsize/(float)nframes);

  // draw words
  fill(255);
  textAlign(LEFT, BASELINE);
  for (int i = gstep*(frameptr-st);i<min(gstep*(frameptr-st+1),gsize);i++)
  {
    if (mgx[i]==-1) { // non-matching word
      text(w4m[girl][i], wgx[i], wgy[i]);
    }
  }
  for (int i = bstep*(frameptr-st);i<min(bstep*(frameptr-st+1),bsize);i++)
  {
    if (mbx[i]==-1) { // non-matching word
      text(m4w[boy][i], wbx[i], wby[i]);
    }
  }
}

void dolines()
{
  int st = (int)(LOOPLEN*0.4);
  int ed = (int)(LOOPLEN*0.8);
  int nframes = ed-st;
  int gstep = ceil(gsize/(float)nframes);
  int bstep = ceil(bsize/(float)nframes);
//  float a = 128.*(1.0/(float)sqrt(matchcount));
  float a1 = 128.*(1.0/(float)sqrt(matchcount));
  float a2 = 255.*(1.0/(float)sqrt(matchcount));
  
  // draw lines
  for (int i = gstep*(frameptr-st);i<min(gstep*(frameptr-st+1),gsize);i++)
  {

    for (int j = 0;j<mbx.length;j++)
    {
      if ((mgx[i]>-1)&&(mbx[j]>-1)) // draw
      {
        float textpos = random(0.3,0.7);
        stroke(255, random(192, 255), random(192, 255), a1);
        line(mgx[i], mgy[i]-6, mbx[j], mby[j]-6);
        String p = pos(w4m[girl][i]);
        noStroke();
        fill(192, 128, 255, a2*2);
        text(p, (mgx[i]*(1.0-textpos))+(mbx[j]*textpos), (mgy[i]*(1.0-textpos))+(mby[j]*textpos));
      }
    }
  }
}

void doending()
{
  filter(BLUR, 1);
  textAlign(CENTER, CENTER);
  float pct = thescore/10.;
  if (pct>99.) pct=99.;
  textFont(font, fontsize); 
  fill(0);
  text("estimated match: " + pct + "%", width/2-2, height*0.4-2);
  fill(0);
  text("estimated match: " + pct + "%", width/2+2, height*0.4-2);
  fill(0);
  text("estimated match: " + pct + "%", width/2-2, height*0.4+2);
  fill(0);
  text("estimated match: " + pct + "%", width/2+2, height*0.4+2);

  fill(255, 192, 255);
  text("estimated match: " + pct + "%", width/2, height*0.4);

  if (pct>triggerpoint) // open new windows
  {
    if (firedlinks==0)
    {
      // uncomment for normal use
      //link(links1[girl][0], "_new1");
      //link(links2[boy][0], "_new2");
      firedlinks = 1;
    }
  }
}

