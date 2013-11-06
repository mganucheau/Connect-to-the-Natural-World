import processing.serial.*;
import httprocessing.*;


String formURL = "https://docs.google.com/a/adi.do/forms/d/1IGyUyCg9Y2lQZszY3PgXFFnYhOLadTT_k9OWI9lW3P0/formResponse";
String field1 = "entry.992209282";
String field2 = "entry.552332506";
String field3 = "entry.2028762248";

Serial myPort;
int linefeed = 10;   // Linefeed in ASCII
int numSensors = 4;  // we will be expecting for reading data from four sensors
int sensors[];       // array to read the 4 values
int pSensors[];      // array to store the previuos reading, usefur for comparing

void setup() {
  size(200, 200);
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[8], 9600);
  myPort.bufferUntil(linefeed);    // read bytes into a buffer until you get a linefeed (ASCII 10):
}

void draw() {
}

void serialEvent(Serial myPort) {
  String myString = myPort.readStringUntil(linefeed);    // read the serial buffer:
  if (myString != null) {    // if you got any bytes other than the linefeed:
    myString = trim(myString);

    // split the string at the commas
    // and convert the sections into integers:
    pSensors = sensors;
    sensors = int(split(myString, ','));


    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      print(sensors[sensorNum] + "\t");      // print out the values you got:
      PostRequest post = new PostRequest(formURL);


      post.addData(field1, str(sensors[0]));
      post.addData(field2, str(sensors[1]));
      post.addData(field3, str(sensors[2]));
    }

    post.send();
    //    println();    // add a linefeed after all the sensor values are printed:
  }
  delay(100);
}

