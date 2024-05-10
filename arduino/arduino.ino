#include <CapacitiveSensor.h>

//Led do sensor de proximidade
const int ledPin = 12;
//Led do sensor touch
const int ledPinT = 13;

//Sensor de proximidade
const int trigPin = 9;
const int echoPin = 10;
long duration;
int distance;

//Sensor touch
CapacitiveSensor cs_5_6 = CapacitiveSensor(5, 6);

//potenciometro
int analogPin = 3;
int val = 0;
int previousVal = 0;

//joystick
#define VRX_PIN A0  // Arduino pin connected to VRX pin
#define VRY_PIN A1  // Arduino pin connected to VRY pin

int xValue = 0;  // To store value of the X axis
int yValue = 0;  // To store value of the Y axis

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(ledPinT, OUTPUT);
  cs_5_6.set_CS_AutocaL_Millis(0xFFFFFFFF);
  Serial.begin(9600);
}

void loop() {

  //_______________________SENSOR PROXIMIDADE_____________________
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH);
  distance = duration * 0.034 / 2;

  //OUTPUT LED
  if (distance <= 50) {
    digitalWrite(ledPin, HIGH);
  } else {
    digitalWrite(ledPin, LOW);
  }

  Serial.print("Sensor de proximidade: ");
  Serial.println(distance);

  //___________________________CAPACITOR__TOUCH______________
  //ver se há necessidade de acresecentar o led porque o touch é meio manhoso
  long start = millis();
  long total1 = cs_5_6.capacitiveSensor(30);

  if (total1 > 450) {
    digitalWrite(ledPinT, HIGH);
    Serial.println("Touch");
  } else {
    digitalWrite(ledPinT, LOW);
  }
  // arbitrary delay to limit data to serial port
  delay(10);

  //____________________________POTENCIOMETRO______________________
  //esgalha valores entre 0 e 255
  val = analogRead(analogPin);
  // Verifica se o valor atual do potenciômetro é diferente do valor anterior
  if (val != previousVal) {
    // Atualiza o valor anterior para o atual
    previousVal = val;
    int val2 = val / 4;
    Serial.print("Potenciômetro: ");
    Serial.println(val2);
  }

  //______________JOYSTICK____________
  // read analog X and Y analog values
  xValue = analogRead(VRX_PIN);
  yValue = analogRead(VRY_PIN);

  // print data to Serial Monitor on Arduino IDE
  Serial.print("x = ");
  Serial.print(xValue);
  Serial.print(", y = ");
  Serial.println(yValue);
  delay(200);
}
