int bit0 = 2;
int bit1 = 3;
int bit2 = 4;
int bit3 = 5;
int bit4 = 6;
int bit5 = 7;
int bit6 = 8;
int bit7 = 9;
int outFlag = 12;
int outFlagValor = 0;

int contador = 0;
int flag = 0;
int Byte = B00000000;

int bit0Val = 0;
int bit1Val = 0;
int bit2Val = 0;
int bit3Val = 0;
int bit4Val = 0;
int bit5Val = 0;
int bit6Val = 0;
int bit7Val = 0;

void setup() {

  // Iniciar comunicación serie
  Serial.begin(9600);
  pinMode(bit0, INPUT);
  pinMode(bit1, INPUT);
  pinMode(bit2, INPUT);
  pinMode(bit3, INPUT);
  pinMode(bit4, INPUT);
  pinMode(bit5, INPUT);
  pinMode(bit6, INPUT);
  pinMode(bit7, INPUT);

  pinMode(outFlag, INPUT);

}


void loop() {
  outFlagValor = digitalRead(outFlag);
  bit7Val = digitalRead(bit7); 
  bit6Val = digitalRead(bit6); 
  bit5Val = digitalRead(bit5); 
  bit4Val = digitalRead(bit4); 
  bit3Val = digitalRead(bit3); 
  bit2Val = digitalRead(bit2); 
  bit1Val = digitalRead(bit1); 
  bit0Val = digitalRead(bit0);
  
  if(outFlagValor == 1 && flag == 0){
    Serial.println(contador);
    flag = 1;
    bitWrite(Byte, 0, bit0Val);
    bitWrite(Byte, 1, bit1Val);
    bitWrite(Byte, 2, bit2Val);
    bitWrite(Byte, 3, bit3Val);
    bitWrite(Byte, 4, bit4Val);
    bitWrite(Byte, 5, bit5Val);
    bitWrite(Byte, 6, bit6Val);
    bitWrite(Byte, 7, bit7Val);
    Serial.print(contador);
    Serial.println(char(Byte));
    
    contador++;
  } else if (outFlagValor == 0){
    flag = 0;
  }
}
