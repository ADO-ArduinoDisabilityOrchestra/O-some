//      Arduino Disability Orchestra - O-Some
/*********************************************************************
  created by Elena Falomo
  This sketch combined with the IMUduino_YawPitchRoll_ThroughSerial gives you an
  interface to visualise the data from the IMUduino
*/

import processing.serial.*;

Serial myPort;        // The serial port

float inByte[]= new float [3];

void setup () {
  // set the window size:
  size(600, 400, P3D);        
  surface.setResizable(true);

  println(Serial.list());

  // Check the listed serial ports that you get, find the right one
  // and use the corresponding index number in Serial.list()[].
  myPort = new Serial(this, Serial.list()[5], 9600);  //

  // Everytime a newline character is received a serialEvent is created
  myPort.bufferUntil('\n');
  background(0);      // set inital background:
}


void draw () {
  //sets the background to black
  background(#ffffff);

  //matrix to animate the cube
  pushMatrix();
  translate(width/2, height/2);
  rotateX(inByte[1]);
  rotateY(inByte[0]);
  rotateZ(inByte[2]);
  /*box created in a separate function in order to color each
  face differently*/
  createBox();
  popMatrix();
}



void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    String inStringArray [] = new String [3];
    //separates the 3 data for Yaw, Pitch and Roll and put
    //them inside inByte
    inStringArray = inString.split(" ");    
    for (int i = 0; i < inStringArray.length; i++) {
      inStringArray[i] = trim(inStringArray[i]); 
      inByte[i] = float(inStringArray[i]);
    }
  }
}

void createBox() {
  beginShape(QUADS);
  
  fill(26, 188,156);
  // +Z "front" face
  vertex(-150, -150,  150, 0, 0);
  vertex( 150, -150,  150, 150, 0);
  vertex( 150,  150,  150, 150, 150);
  vertex(-150,  150,  150, 0, 150);

  fill(230,126,34);
  // -Z "back" face
  vertex( 150, -150, -150, 0, 0);
  vertex(-150, -150, -150, 150, 0);
  vertex(-150,  150, -150, 150, 150);
  vertex( 150,  150, -150, 0, 150);

  fill(155, 89, 182);
  // +Y "bottom" face
  vertex(-150,  150,  150, 0, 0);
  vertex( 150,  150,  150, 150, 0);
  vertex( 150,  150, -150, 150, 150);
  vertex(-150,  150, -150, 0, 150);

  fill(241, 196, 15);
  // -Y "top" face
  vertex(-150, -150, -150, 0, 0);
  vertex( 150, -150, -150, 150, 0);
  vertex( 150, -150,  150, 150, 150);
  vertex(-150, -150,  150, 0, 150);

  fill(52, 152, 219);
  // +X "right" face
  vertex( 150, -150,  150, 0, 0);
  vertex( 150, -150, -150, 150, 0);
  vertex( 150,  150, -150, 150, 150);
  vertex( 150,  150,  150, 0, 150);

  fill(231, 76, 60);
  // -X "left" face
  vertex(-150, -150, -150, 0, 0);
  vertex(-150, -150,  150, 150, 0);
  vertex(-150,  150,  150, 150, 150);
  vertex(-150,  150, -150, 0, 150);

  endShape();
}