//  Code for the tutorial: 
//  Connect to the Natural World - http://mganucheau.github.io/Connect-to-the-Natural-World/
//  by Matt Ganucheau

import processing.serial.*;
import httprocessing.*;  // https://github.com/runemadsen/HTTProcessing

String formURL = "https://docs.google.com/forms/d/XXXXXXXXXX/formResponse";
String field1 = "entry.XXXXXXXXXX";
String field2 = "entry.XXXXXXXXXX";
String field3 = "entry.XXXXXXXXXX";

Serial myPort;
int linefeed = 10;   // Linefeed in ASCII
int numSensors = 4;  // we will be expecting for reading data from four sensors
int sensors[];       // array to read the 4 values
int pSensors[];      // array to store the previuos reading, usefur for comparing

int var1 = 0;
int var2 = 0;
int var3 = 0;

void setup() {
  size(200, 200);
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil(linefeed);    // read bytes into a buffer until you get a linefeed (ASCII 10):
}

void draw() {
  String myString = myPort.readStringUntil(linefeed);    // read the serial buffer:
  if (myString != null) {    // if you got any bytes other than the linefeed:
    myString = trim(myString);

    // split the string at the commas
    // and convert the sections into integers:
    pSensors = sensors;
    sensors = int(split(myString, ','));

    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      print(sensors[sensorNum] + "\t");      // print out the values you got:
      var1 = sensors[0];
      var2 = sensors[1];      
      var3 = sensors[2];
    }
    println();    // add a linefeed after all the sensor values are printed:
  }

  PostRequest post = new PostRequest(formURL);
  post.addData(field1, str(var1));
  post.addData(field2, str(var2));
  post.addData(field3, str(var3));
  post.send();
  
  delay(10000); // Delay the posting to every 10 seconds
}

