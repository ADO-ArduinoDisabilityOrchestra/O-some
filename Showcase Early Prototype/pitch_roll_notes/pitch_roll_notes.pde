//      Arduino Disability Orchestra - O-Some
/*********************************************************************
  created by Elena Falomo
  This sketch combined with the IMUduino_YawPitchRoll_ThroughSerial gives you an
  interface to visualise the data from the IMUduino
*/

import processing.serial.*;
import oscP5.*;
import netP5.*;

import ddf.minim.*;
import ddf.minim.ugens.*;

Serial myPort;        // The serial port
OscP5 oscP5;
NetAddress dest;

float pitch;
float roll;

int myOne= 0;
int myTwo= 0;

Minim minim;
AudioOutput out;

void setup () {
  
  println(Serial.list());
  
  minim = new Minim(this);
  out = minim.getLineOut();

  // Check the listed serial ports that you get, find the right one
  // and use the corresponding index number in Serial.list()[].
  myPort = new Serial(this, Serial.list()[5], 9600);  //
  print(myPort);

  // Everytime a newline character is received a serialEvent is created
  myPort.bufferUntil('\n');
  background(0);      // set inital background:
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1",6448);
  
  
}


void draw () {
  sendOsc();
  
    if (myOne==1){
    out.playNote("C4");
  } else if (myOne==2){
    out.playNote("D4");
 } else if (myOne==3){
    out.playNote("D#4");
 } else if (myOne==4){
    out.playNote("E4");
 } else if (myOne==5){
    out.playNote("G4");
 }
  
  delay(500);
}

void loop(){

}



void serialEvent (Serial myPort) {
 String inString = myPort.readStringUntil('\n');
 if (inString != null) {
   String inStringArray [] = new String [2];
   //separates the 2 data for Pitch and Roll coming from the serial
   inStringArray = inString.split(" ");    
    
   //getting pitch
   inStringArray[0] = trim(inStringArray[0]); 
   pitch = float(inStringArray[0]);
    
   //getting roll    
   inStringArray[1] = trim(inStringArray[1]); 
   roll = float(inStringArray[1]);
 }
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add(pitch); 
  msg.add(roll);
  println(pitch+ ", "+ roll);
  oscP5.send(msg, dest);
}

void oscEvent(OscMessage theOscMessage) {
if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
    if(theOscMessage.checkTypetag("f")) { // looking for 1 control value
        float receivedOne = theOscMessage.get(0).floatValue();
        myOne = int(receivedOne);
    } else {
       println("Error: unexpected OSC message received by Processing: ");
       theOscMessage.print();
     }
}
}