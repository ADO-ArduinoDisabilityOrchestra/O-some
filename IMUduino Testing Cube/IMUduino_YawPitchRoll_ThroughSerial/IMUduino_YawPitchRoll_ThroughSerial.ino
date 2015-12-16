

//          Arduino Disability Orchestra - Arduino Ball
/*********************************************************************

Readapted from the IMUDUINO_Bluetooth_UART_YawPitchRoll example
Combined with the Processing IMUCube gives you a interface to
visualise data from the IMU
We used the function getEulerRad from the FreeIMU library instead.
We didn't enable the Bluethooth. The IMU communicates
with Processing through Serial

modified by Elena Falomo, Alessandro Siino and Paolo Cavagnolo 

**/
/***

Notes from Femto.io
===================

Avoid using String(), as it takes up large amounts of storage, causing the sketch to 
grow beyond the max flash size of an ATMega32u4

***/

//   ..... Adafruit nRF8001 libary ....
/*********************************************************************
This is an example for our nRF8001 Bluetooth Low Energy Breakout

  Pick one up today in the adafruit shop!
  ------> http://www.adafruit.com/products/1697

Adafruit invests time and resources providing this open source code, 
please support Adafruit and open-source hardware by purchasing 
products from Adafruit!

Written by Kevin Townsend/KTOWN  for Adafruit Industries.
MIT license, check LICENSE for more information
All text above, and the splash screen below must be included in any redistribution
*********************************************************************/

/**  ..... FreeIMU library ....
 * Example program for using the FreeIMU connected to an Arduino Leonardo.
 * The program reads sensor data from the FreeIMU, computes the yaw, pitch
 * and roll using the FreeIMU library sensor fusion and use them to move the
 * mouse cursor. The mouse is emulated by the Arduino Leonardo using the Mouse
 * library.
 * 
 * Originally authored by Fabio Varesano 
*/



#include <HMC58X3.h>
#include <MS561101BA.h>
#include <I2Cdev.h>
#include <MPU60X0.h>
#include <EEPROM.h>

//#define DEBUG
#include "DebugUtils.h"
//#include "IMUduino.h"
#include "FreeIMU.h"
#include <Wire.h>
#include <SPI.h>


// Connect CLK/MISO/MOSI to hardware SPI
// e.g. On UNO & compatible: CLK = 13, MISO = 12, MOSI = 11
//      On Leo & compatible: CLK = 15, MISO = 14, MOSI = 16
#define ADAFRUITBLE_REQ 10
#define ADAFRUITBLE_RDY 7     // This should be an interrupt pin, on Uno thats #2 or #3. IMUduino uses D7
#define ADAFRUITBLE_RST 9


//aci_evt_opcode_t laststatus = ACI_EVT_DISCONNECTED;
//aci_evt_opcode_t status = laststatus;

float ypr[3];
char chrData[17]; // Yaw (5 bytes), Pitch (5 bytes), Roll (5 bytes) ...delimeter is a pipe '|'
char sendbuffersize;
    
// Set the FreeIMU object
FreeIMU my3IMU = FreeIMU();


void setup() {
  
  Serial.begin(1200);
  // Comment this out if you don't want to open up the Serial Monitor to start initialization
 //if you don't comment this line the communication with Processinf through serial won't work 
 // while(!Serial);
  
  Wire.begin();
  

  delay(500);
  // Initialize the IMU components.
  Serial.println(F("...Initializing IMU"));
  my3IMU.init(true);
  // Initialize the BLE component.
  Serial.println(F("...Initializing BTLE"));
 // BTLEserial.begin();
  Serial.println(F("...Ok! Starting main loop."));
}


void loop() {
  
    //we use euler coordinates because are the absolute ones for the IMU, 
    //the rotate() function in Processing uses radians so we chose getEulerRad() over getEuler()
    my3IMU.getEulerRad(ypr);
    Serial.print(ypr[0]);
    Serial.print(' ');
    Serial.print(ypr[1]);
    Serial.print(' ');
    Serial.print(ypr[2]);
}

