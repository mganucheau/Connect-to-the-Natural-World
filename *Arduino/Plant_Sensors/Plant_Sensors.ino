//  Sensor code for the tutorial: 
//  Connect to the Natural World - http://mganucheau.github.io/Connect-to-the-Natural-World/
//  by Matt Ganucheau, based on code by ladyada, public domain

#include "DHT.h"

#define DHTTYPE DHT22   // DHT 22  (AM2302)
//#define DHTTYPE DHT21   // DHT 21 (AM2301)
//#define DHTTYPE DHT11   // DHT 11 

DHT dht(2, DHTTYPE); // sets the humidity sensor to digital pin 2
int sensorPin = A0;  // sets the moisture sensor to analog pin 0

void setup() {
  Serial.begin(9600); 
  dht.begin();
}

void loop() {
  int h = dht.readHumidity();     // Humidity
  int t = dht.readTemperature();  // Temperature
  int m = analogRead(sensorPin);  // Moisture

  Serial.print(h, DEC);
  Serial.print(",");
  Serial.print(t, DEC);
  Serial.print(",");
  Serial.println(m, DEC);

  delay(250); // A small delay is set to keep things smooth
}

