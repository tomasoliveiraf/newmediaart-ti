#include <CapacitiveSensor.h>

const int ledPin = 12;

const int trigPin = 9;
const int echoPin = 10;

CapacitiveSensor cs_5_6 = CapacitiveSensor(5, 6);

int analogPin = 3;
int val = 0;
int previousVal = 0;

long duration;
int distance;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(ledPin, OUTPUT);
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

  /*Serial.print("Sensor de proximidade: ");
  Serial.println(distance);*/

  //___________________________CAPACITOR__TOUCH______________
  //ver se há necessidade de acresecentar o led porque o touch é meio manhoso
  long start = millis();
  long total1 = cs_5_6.capacitiveSensor(30);

  if (total1 > 450) {
    //digitalWrite(ledPin, HIGH);
    Serial.println("Touch");
  } else {
    //digitalWrite(ledPin, LOW);
  }
  // arbitrary delay to limit data to serial port
  delay(10);

  //____________________________POTENCIOMETRO______________________
  //esgalha valores entre 0 e 255
  //ver posição da coisa que está ao contrario
  val = analogRead(analogPin);
  // Verifica se o valor atual do potenciômetro é diferente do valor anterior
  if (val != previousVal) {
    // Atualiza o valor anterior para o atual
    previousVal = val;
    int val2 =  val / 4;
    Serial.print("Potenciômetro: ");
    Serial.println(val2);
  }
}
