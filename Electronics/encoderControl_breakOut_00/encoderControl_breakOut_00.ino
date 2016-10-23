
/*
ON ROBOTLINKING BREAKBOARD
 GRN -> GROUND
 + -> 5V
 CLK (clock) -> PIN 3 (these two can be switch to reverse direction)
 DT (data) -> PIN 2
 SW (switch) -> PIN 4
 */

int clock = 3;
int data = 2;
int button = 4;
void setup(){
  Serial.begin(9600);
  pinMode(clock, INPUT);
  pinMode(data, INPUT);
  pinMode(button, INPUT);
}

void loop(){

  if(digitalRead(clock) == LOW){
    //Serial.print(digitalRead(clock));
    //Serial.print("-");
    Serial.print(digitalRead(data), DEC);
    delay(50);
  }
  
  
  
  // NOT WORKING
  /*
  if(digitalRead(button) == HIGH){
    Serial.println("BUTTON PRESSED");
  }
  */

}


