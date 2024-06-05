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


  Serial.print(distance);
  Serial.print(",");

  //___________________________CAPACITOR__TOUCH______________
  //ver se há necessidade de acresecentar o led porque o touch é meio manhoso
  long start = millis();
  long total1 = cs_5_6.capacitiveSensor(30);

  if (total1 > 450) {
    digitalWrite(ledPinT, HIGH);
    Serial.print("Touch");
    Serial.print(",");
  } else {
    digitalWrite(ledPinT, LOW);
    Serial.print("NoTouch");
    Serial.print(",");
  }

  //____________________________POTENCIOMETRO______________________
  //esgalha valores entre 0 e 255
  val = analogRead(analogPin);
  int val2 = val / 4;
  Serial.print(val2);
  Serial.print(",");

  // Verifica se o valor atual do potenciômetro é diferente do valor anterior
  /*if (val != previousVal) {
    // Atualiza o valor anterior para o atual
    previousVal = val;
    int val2 = val / 4;
    Serial.print(val2);
    Serial.print(",");
  }*/

  //______________JOYSTICK____________
  // Ler os valores do joystick
  xValue = analogRead(VRX_PIN);
  yValue = analogRead(VRY_PIN);

  // Mapear os valores lidos para uma faixa de 0 a 100
  int mappedX = map(xValue, minX, maxX, 0, 100);
  int mappedY = map(yValue, minY, maxY, 0, 100);

  // Limitar os valores mapeados para a faixa de 0 a 100
  mappedX = constrain(mappedX, 0, 100);
  mappedY = constrain(mappedY, 0, 100);

  // Imprimir os valores mapeados
  Serial.print(mappedX);
  Serial.print(",");
  Serial.println(mappedY);
}
