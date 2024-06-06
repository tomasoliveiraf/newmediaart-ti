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

long ellapsed;
int maxX = 0, maxY = 0, minX = 1024, minY = 1024;


void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(ledPinT, OUTPUT);
  cs_5_6.set_CS_AutocaL_Millis(0xFFFFFFFF);
  Serial.begin(9600);


  ellapsed = millis();

  // Calibração: valores máximos e mínimos enquanto está parado
  while ((millis() - ellapsed) < 10000) {
    // Ler os valores analógicos do joystick
    int X = analogRead(VRX_PIN);
    int Y = analogRead(VRY_PIN);
    if (X > maxX) maxX = X;
    if (X < minX) minX = X;
    if (Y > maxY) maxY = Y;
    if (Y < minY) minY = Y;
  }

  // Imprimir os valores calibrados
  /*Serial.print("Calibração Completa:\n");
  Serial.print("Max X: ");
  Serial.println(maxX);
  Serial.print("Min X: ");
  Serial.println(minX);
  Serial.print("Max Y: ");
  Serial.println(maxY);
  Serial.print("Min Y: ");
  Serial.println(minY);
*/
}

void loop() {
  String dataString = "";

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

  /*Serial.print(distance);
  Serial.print(",");*/

  dataString += String(distance) + ",";


  //___________________________CAPACITOR__TOUCH______________
  //ver se há necessidade de acresecentar o led porque o touch é meio manhoso
  long start = millis();
  long total1 = cs_5_6.capacitiveSensor(30);

  if (total1 > 450) {
    digitalWrite(ledPinT, HIGH);
    /*Serial.print("Touch");
    Serial.print(",");*/
    dataString += "Touch,";
  } else {
    digitalWrite(ledPinT, LOW);
    /*Serial.print("NoTouch");
    Serial.print(",");*/
    dataString += "NoTouch,";
  }

  //____________________________POTENCIOMETRO______________________
  //esgalha valores entre 0 e 255
  val = analogRead(analogPin);
  int val2 = val / 4;
  /*Serial.print(val2);
  Serial.print(",");*/
  dataString += String(val2) + ",";

  // Verifica se o valor atual do potenciômetro é diferente do valor anterior
  /*if (val != previousVal) {
    // Atualiza o valor anterior para o atual
    previousVal = val;
    int val2 = val / 4;
    Serial.print(val2);
    Serial.print(",");
  }*/

  //______________JOYSTICK____________

  if (millis() - ellapsed > 100) {
    int X = analogRead(VRX_PIN);
    int Y = analogRead(VRY_PIN);
    int XSend = 0, YSend = 0;

    ellapsed = millis();

    if ((X < minX) || (X > maxX)) {
      XSend = X - 512;
    }
    if ((Y < minY) || (Y > maxY)) {
      YSend = Y - 512;
    }

    // Imprimir os valores mapeados
    /*Serial.print(XSend);
    Serial.print(",");
    Serial.println(YSend);*/
    dataString += String(XSend) + ",";
    dataString += String(YSend);
  }

  Serial.println(dataString);
  delay(100);
}
