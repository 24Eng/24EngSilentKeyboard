/**************************************************24Eng
This is a library for the MPR121 12-channel Capacitive touch sensor

Designed specifically to work with the MPR121 Breakout in the Adafruit shop 
  ----> https://www.adafruit.com/products/

These sensors use I2C communicate, at least 2 pins are required 
to interface

Adafruit invests time and resources providing this open source code, 
please support Adafruit and open-source hardware by purchasing 
products from Adafruit!

Written by Limor Fried/Ladyada for Adafruit Industries.  
BSD license, all text above must be included in any redistribution
**********************************************************/

#include <Wire.h>
#include "Adafruit_MPR121.h"

#ifndef _BV
#define _BV(bit) (1 << (bit)) 
#endif

// You can have up to 4 on one i2c bus but one is enough for testing!
Adafruit_MPR121 cap = Adafruit_MPR121();

// Keeps track of the last pins touched
// so we know when buttons are 'released'
uint16_t lasttouched = 0;
uint16_t currtouched = 0;



#include "Keyboard.h"
bool buttonStates[12];

void setup() {
  Serial.begin(115200);
  delay(500);
//  while (!Serial) { // needed to keep leonardo/micro from starting too fast!
//    delay(10);
//  }
  // Default address is 0x5A, if tied to 3.3V its 0x5B
  // If tied to SDA its 0x5C and if SCL then 0x5D
  if (!cap.begin(0x5A)) {
    Serial.println("MPR121 not found, check wiring and restart.");
    while (1);
  }
  Keyboard.begin();
//  Keyboard.print("24Eng");
  Serial.print("24EngSilentKeyboard\n");
}

void loop() {
  // Get the currently touched pads
  currtouched = cap.touched();
  int buttonPressed = 0;
  int buttonCounter = 0;
  for (uint8_t i=0; i<12; i++) {
    // it if *is* touched and *wasnt* touched before, alert!
    if ((currtouched & _BV(i)) && !(lasttouched & _BV(i)) ) {
      buttonPressed = i;
      buttonStates[i] = HIGH;
      buttonCounter++;
    }
  }
  if(buttonCounter > 11){
    Serial.print("Problem encountered\n");
  }else if(buttonCounter > 0){
    keyboardSwitch(buttonPressed);
  }
  
  // reset our state
  lasttouched = currtouched;
}

void keyboardSwitch(int funInput){
  switch (funInput){
    case 0:
    // Press "r" to start recording
      Keyboard.print("r");
      break;
    case 1:
    // Press space to stop recording
      Keyboard.print(" ");
      break;
    case 2:
    // Control + 1 (one) zooms in
      Keyboard.press(KEY_LEFT_CTRL);
      Keyboard.press('1');
      Keyboard.releaseAll();
      break;
    case 3:
    // Control + 2 (two) zooms out
      Keyboard.press(KEY_LEFT_CTRL);
      Keyboard.press('2');
      Keyboard.releaseAll();
      break;
    case 4:
    // Press "r" to start recording
      Keyboard.print("r");
      break;
    case 5:
    // Press space to stop recording
      Keyboard.print(" ");
      break;
    case 6:
    // The end key moves the cursor to the end of the recording
      Keyboard.write(KEY_END);
      break;
    case 7:
    // The home key moves the cursor to the beginning of the recording
      Keyboard.write(KEY_HOME);
      break;
    case 8:
    // Ctrl+S saves
      Keyboard.press(KEY_LEFT_CTRL);
      Keyboard.press('s');
      Keyboard.releaseAll();
      break;
    case 9:
    // Ctrl+S saves
      Keyboard.press(KEY_LEFT_CTRL);
      Keyboard.press('s');
      Keyboard.releaseAll();
      break;
    case 10:
    // Ctrl+shift+z redo for Audacity on Linux
      Keyboard.press(KEY_LEFT_CTRL);
      Keyboard.press(KEY_LEFT_SHIFT);
      Keyboard.press('z');
      Keyboard.releaseAll();
      break;
    case 11:
    // Ctrl+Z undo
      Keyboard.press(KEY_LEFT_CTRL);
      Keyboard.press('z');
      Keyboard.releaseAll();
      break;
    default:
    // This should never happen
      Serial.print("Unrecognized input\n");
      Keyboard.print("Unrecognized input");
      break;
  }
}
