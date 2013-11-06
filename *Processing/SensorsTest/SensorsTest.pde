//  Code for the tutorial: 
//  Connect to the Natural World - http://mganucheau.github.io/Connect-to-the-Natural-World/
//  by Matt Ganucheau

import processing.serial.*;

Serial myPort;
int linefeed = 10;   // Linefeed in ASCII
int numSensors = 4;  // we will be expecting for reading data from four sensors
int sensors[];       // array to read the 4 values
int pSensors[];      // array to store the previuos reading, usefur for comparing
// actual reading with the last one

void setup() {
  size(200, 200);
  // List all the available serial ports in the output pane.
  // You will need to choose the port that the Wiring board is
  // connected to from this list. The first port in the list is
  // port #0 and the third port in the list is port #2.
  println(Serial.list());

  myPort = new Serial(this, Serial.list()[1], 9600);
  // read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil(linefeed);
}

void draw() {
}

void serialEvent(Serial myPort) {
  // read the serial buffer:
  String myString = myPort.readStringUntil(linefeed);

  // if you got any bytes other than the linefeed:
  if (myString != null) {
    myString = trim(myString);

    // split the string at the commas
    // and convert the sections into integers:
    pSensors = sensors;
    sensors = int(split(myString, ','));

    // print out the values you got:
    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
    }

    // add a linefeed after all the sensor values are printed:
    println();
  }
}

