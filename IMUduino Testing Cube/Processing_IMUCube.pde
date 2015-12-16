//      Arduino Disability Orchestra - O-some Team
/*********************************************************************
  created by Elena Falomo, Alessandro Siino and Paolo Cavagnolo
  This sketch combined with the IMUduino_YawPitchRoll_ThroughSerial gives you an
  interface to visualise the data from the IMU

*/
import processing.serial.*;

Serial myPort;        // The serial port

float inByte[]= new float [3];

void setup () {
  // set the window size:
  size(600, 400, P3D);        


  println(Serial.list());

  // Check the listed serial ports that you get, find the right one
  // and use the corresponding index number in Serial.list()[].
  myPort = new Serial(this, Serial.list()[3], 1200);  //

  // Everytime a newline character is received a serialEvent is created
  myPort.bufferUntil('\n');
  background(0);      // set inital background:
}


void draw () {
  //sets the background to black
  background(0);

  //matrix to draw the cube
  pushMatrix();
  translate(width/2, height/2);
  rotateX(inByte[1]);
  rotateY(inByte[0]);
  rotateZ(inByte[2]);
  box(150, 150, 150);
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