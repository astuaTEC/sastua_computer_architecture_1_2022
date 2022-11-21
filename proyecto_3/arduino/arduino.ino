#include <SoftwareSerial.h>
SoftwareSerial HC06(10, 11);

const int Trigger = 12;   //Pin digital 2 para el Trigger del sensor
const int Echo = 13;   //Pin digital 3 para el Echo del sensor
long randomNumber;
int enA = 9;
int in1 = 8;
int in2 = 7;
// Motor B connections
int enB = 3;
int in3 = 5;
int in4 = 4;
int motorLimpieza = 6;
int auxDirection = 0;
char dir, empezar;
String modo = "";
bool banderaAgua = false;
bool detener = false;
#define sensor A0

void setup() {

  Serial.begin(9600);//iniciailzamos la comunicación
  HC06.begin(9600);
  pinMode(Trigger, OUTPUT); //pin como salida
  pinMode(Echo, INPUT);  //pin como entrada
  digitalWrite(Trigger, LOW);//Inicializamos el pin con 0
  pinMode(enA, OUTPUT);
  pinMode(enB, OUTPUT);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);
  pinMode(sensor, INPUT);
  pinMode(motorLimpieza, OUTPUT);
  encenderMotores();

  //Establecemos la semilla fija
  randomSeed(1);
}

void loop()
{
  char receive = (char)HC06.read();
  int valorHumedad = map(analogRead(sensor), 0, 1023, 100, 0);

  //Serial.println(valorHumedad);
  if(valorHumedad > 0){
     detener = true;
     apagarMotores();
    }
  if (receive == '1') {
    Serial.print("Manual");
    modo = "manual";
    detener = false;
  }
  if (receive == '2') {
    Serial.print("Auto");
    modo = "auto";
    detener = false;
  }

  if (receive == 'S') {
    detener = true;
    apagarMotores();
  }
  
 if (receive == 'E') {
    empezar = '1';
  }

  if (modo == "manual" && (receive != '1' && receive != '2') && detener == false) {
    empezar == '0';
    controller(receive);
  }

  if (modo == "auto" && empezar == '1' && detener == false) {
    Serial.print("Entra a auto");
    Automatico();
  }

  else {
    apagarMotores();
  }

}



void controller(char receive) {
  if (receive == 'I') {
    dir = 'I';
  }
  if (receive == 'B') {
    dir = 'B';
  }
  if (receive == 'D') {
    dir = 'D';
  }
  if (receive == 'A') {
    dir = 'A';
  }
  Manual();
}

void Automatico() {
  analogWrite(enA, 150);
  analogWrite(enB, 150);
  
  long t; //timepo que demora en llegar el eco
  long d; //distancia en centimetros

  digitalWrite(Trigger, HIGH);
  delayMicroseconds(10);          //Enviamos un pulso de 10us
  digitalWrite(Trigger, LOW);

  t = pulseIn(Echo, HIGH); //obtenemos el ancho del pulso
  d = t / 59;           //escalamos el tiempo a una distancia en cm
  Serial.print(d);

  delay(100);          //Hacemos una pausa de 100ms
  if (d < 50) {
    randomNumber = random(1, 3);
    if (randomNumber == 1 && auxDirection == 0) {
      auxDirection = 1;
      girarDerecha();
      delay(500);
    } else if (randomNumber == 2 && auxDirection == 0) {
      auxDirection = 2;
      girarIzquierda();
      delay(500);
    }
    digitalWrite(motorLimpieza, LOW);
  }
  else {
    encenderMotores();
    auxDirection = 0;
  }
}

void Manual() {
  analogWrite(enA, 125);
  analogWrite(enB, 125);
  if (dir == 'I') {
    digitalWrite(motorLimpieza, LOW);
    girarIzquierda();
  }
  else if (dir == 'B') {
    moverAtras();
  }
  else if (dir == 'D') {
    digitalWrite(motorLimpieza, LOW);
    girarDerecha();
  }
  else if (dir == 'A') {
    moverAdelante();
  }
  delay(100); 
}

void girarDerecha() {
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  digitalWrite(in3, LOW);
  digitalWrite(in4, LOW);
}

void girarIzquierda() {
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  digitalWrite(in3, HIGH);
  digitalWrite(in4, LOW);
}

void moverAtras() {
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  digitalWrite(in3, HIGH);
  digitalWrite(in4, LOW);

  digitalWrite(motorLimpieza, HIGH);
}

void moverAdelante() {
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  digitalWrite(in3, LOW);
  digitalWrite(in4, HIGH);

  digitalWrite(motorLimpieza, HIGH);
}

void encenderMotores() {
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  digitalWrite(in3, LOW);
  digitalWrite(in4, HIGH);

  digitalWrite(motorLimpieza, HIGH);
}

void apagarMotores() {
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  digitalWrite(in3, LOW);
  digitalWrite(in4, LOW);

  digitalWrite(motorLimpieza, LOW);
}
