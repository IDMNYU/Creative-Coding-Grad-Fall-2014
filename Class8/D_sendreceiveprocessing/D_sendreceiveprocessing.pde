/**
 * send shit to and from max
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 whereimlistening; // equivalent to [udpreceive] in max, e.g. it's listening
NetAddress whereimsending; // equivalent to [udpsend] in max - it's sending

String messageselector;
int x, y;
int r, g, b;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  whereimlistening = new OscP5(this,12000);
  
  /* whereimsending is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. whereimsending is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  whereimsending = new NetAddress("127.0.0.1",8000); // hostname, port

}


void draw() {
  background(r, g, b);  
   rect(x, y, 10, 10); 

  OscMessage themessage = new OscMessage("mouse");
  
  themessage.add(mouseX); /* add an int to the osc message */
  themessage.add(mouseY); /* add an int to the osc message */

  /* send the message */
  whereimlistening.send(themessage, whereimsending); 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage thereceivedmessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  messageselector = thereceivedmessage.addrPattern();
  // println("!" + messageselector + "!");
  if(messageselector.equals("d")) {
    // println("drawing...");
    x = thereceivedmessage.get(0).intValue();
    y = thereceivedmessage.get(1).intValue();
  }
    else if(messageselector.equals("c")) {
    // println("coloring...");
    r = thereceivedmessage.get(0).intValue();
    g = thereceivedmessage.get(1).intValue();
    b = thereceivedmessage.get(2).intValue();
  }

}
