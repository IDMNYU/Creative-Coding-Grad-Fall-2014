
// read in the two main missed connection files
void parsemainurl()
{
  String temp;
  String blockstart = "<div class=\"content\">";
  String blockend = "<div class=\"toc_legend bottom\">";
  int start, end, i;

  // regular expression to find a valid URL
  //String pt = "\\b(https?|ftp|file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
  //String pt = "<a href=\"(.*?)\">";
  String pt ="href=\"(/\\w*/\\w*/\\w*\\.html)\" class=\"i\">";

  temp = "";
  for (i = 0;i<w4m_main.length;i++)
  {
    temp+=w4m_main[i];
  }
  //println(temp);
  start = temp.indexOf(blockstart);
  temp = temp.substring(start);

  end = temp.indexOf(blockend);
  temp = temp.substring(0, end);
  //println(temp);

  // parse urls
  links1 = matchAll(temp, pt);

  temp = "";
  for (i = 0;i<m4w_main.length;i++)
  {
    temp+=m4w_main[i];
  }
  start = temp.indexOf(blockstart);
  temp = temp.substring(start);

  end = temp.indexOf(blockend);
  temp = temp.substring(0, end);
  // parse urls
  links2 = matchAll(temp, pt);

  t1 = min(LINKNUM, links1.length);
  t2 = min(LINKNUM, links2.length);
  
/*  for(i=0;i<links1.length;i++)
  {
     println(links1[i][1]); 
  }*/

  // we're ready to go
  parsed = 1;
}

// parse the women looking for men
void parsesuburl_w4m()
{
  String s = "";
  String startblock = "<section id=\"postingbody\">";
  //String endblock = "<!-- START CLTAGS -->";
  String endblock = "</section>";
  String url = "http://"+city+links1[loadptr1][1];
  println("loading women: " + url);
  String t[] = loadStrings(url);
  for (int i = 0;i<t.length;i++)
  {
    s+=t[i];
  }
  println("parsing women: " + loadptr1);  
  int start = s.indexOf(startblock);
  s = s.substring(start+startblock.length());
  int endi = s.indexOf("<script");
  if (endi>-1) s = s.substring(0, endi);
  int end = s.indexOf(endblock);
  if (end>-1) s = s.substring(0, end);
  s = s.replaceAll("<br>", " ");
  s = s.replaceAll("\r", " ");
  s = s.replaceAll("\n", " ");
  s = s.replaceAll("\0", " ");
  s = s.replaceAll(",", ".");
  s = s.replaceAll("!", ".");
  s = s.replaceAll("\\?", ".");
  s = s.replaceAll("\\.", " . ");
  s = s.replaceAll("[^A-z0-9\\s.,'*]", "");
  s = s.replaceAll("^\\s+", "");
  s = s.replaceAll("\\s+$", "");
  s = s.replaceAll("\\b\\s{2,}\\b", " ");
  s = s.toLowerCase();

  text(s, 0, 120);
  w4m[loadptr1] = split(s, ' ');
  loadptr1++;
}

// parse the men looking for women
void parsesuburl_m4w()
{
  String s = "";
  String startblock = "<section id=\"postingbody\">";
  //String endblock = "<!-- START CLTAGS -->";
  String endblock = "</section>";
  String url = "http://"+city+links2[loadptr2][1];
  println("loading men: " + url);
  String t[] = loadStrings(url);
  for (int i = 0;i<t.length;i++)
  {
    s+=t[i];
  }
  println("parsing men: " + loadptr2);
  int start = s.indexOf(startblock);
  s = s.substring(start+startblock.length());
  int endi = s.indexOf("<script");
  if (endi>-1) s = s.substring(0, endi);
  int end = s.indexOf(endblock);
  if (end>-1) s = s.substring(0, end);
  s = s.replaceAll("<br>", " ");
  s = s.replaceAll("\r", " ");
  s = s.replaceAll("\n", " ");
  s = s.replaceAll("\0", " ");
  s = s.replaceAll("-", " ");
  s = s.replaceAll(",", ".");
  s = s.replaceAll("!", ".");
  s = s.replaceAll("\\?", ".");
  s = s.replaceAll("\\.", " . ");
  s = s.replaceAll("[^A-z0-9\\s.,'*]", "");
  s = s.replaceAll("^\\s+", "");
  s = s.replaceAll("\\s+$", "");
  s = s.replaceAll("\\b\\s{2,}\\b", " ");
  s = s.toLowerCase();

  text(s, 0, 140);
  m4w[loadptr2] = split(s, ' ');
  loadptr2++;
}

void loadcities() // load cities list
{
   String cities[] = loadStrings("cities.txt");
   String temp[];
   cityURLs = new String[cities.length];
   citytexts = new String[cities.length];
   cityrects = new int[cities.length][4];
   for(int i = 0;i<cities.length;i++)
   {
     temp = split(cities[i], ", ");
     cityURLs[i] = temp[0];
     citytexts[i] = temp[1];
   }
}

void loadpos() // load parts of speech database (split into 3 for a vague efficiency boost)
{
  pos[0] = loadStrings("part-of-speech-A-J.txt");
  pos[1] = loadStrings("part-of-speech-K-R.txt");
  pos[2] = loadStrings("part-of-speech-S-Z.txt");
}

int pos2score(String p) // translate parts-of-speech to numerical score
{
  /*  
   N	Noun
   P	Plural
   h	Noun Phrase
   V	Verb (usu participle)
   t	Verb (transitive)
   i	Verb (intransitive)
   A	Adjective
   v	Adverb
   C	Conjunction
   P	Preposition
   !	Interjection
   r	Pronoun
   D	Definite Article
   I	Indefinite Article
   o	Nominative
   */
  int score=0;
  if (p.indexOf("-")>-1) score+=50; // special word (not in pos database)
  else if (p.indexOf("N")>-1) score+=20; // ordinary noun
  else if (p.indexOf("V")>-1) score+=10; // verb
  else if (p.indexOf("t")>-1) score+=10; // verb
  else if (p.indexOf("i")>-1) score+=10; // verb
  else if (p.indexOf("A")>-1) score+=25; // adjective
  else if (p.indexOf("v")>-1) score+=25; // adverb
  else score++; // other parts

  return(score);
}

String pos(String query) // do a part-of-speech check, return string
{
  char q = query.charAt(0);
  int f, t, m;
  String p = "-";
  if (q<'k') f = 0;
  else if (q<'s') f = 1;
  else f = 2;
  m = -1;
  t = -1;
  for (int i = 0;i<pos[f].length;i++)
  {
    t = pos[f][i].toLowerCase().indexOf(query+",");
    if (t>-1) 
    {
      m=i;
      break;
    }
  }
  if (m>-1) p = pos[f][m].substring(t+query.length()+2, pos[f][m].length()-1);
  return(p);
}

