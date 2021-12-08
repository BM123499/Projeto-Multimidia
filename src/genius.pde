import processing.sound.*;

// prefab
color[] Colors = {color(234, 28, 36), color(247, 147, 32), color(245, 229, 12), color(1, 166, 84), color(92, 201, 231), color(18, 74, 149), color(134, 61, 152)};
int sequenceId = 0;
int difficult = 7;
int[] sequence = {};

// Sound
SoundFile[] SF;
SoundFile errorSound;

// design
PImage note_img;

int mX, mY;

// automatic
int errorTime    = 2000;
int waitingTime  =  200;
int blinkingTime =  800;
int posclickTime =  500;
int holdTime     = 1500;

int timeStep     = 0;
int mousePlace   = -1;
int selectedTile = 0;

boolean error   = false;
boolean showing = false;
boolean breath  = false;
boolean posclick   = false;

boolean hold = false;
PImage cursor;

void genius_setup() {
  cursor = loadImage("../Images/Test.PNG");

  note_img = loadImage("../Images/note.png");

  errorSound = new SoundFile(this, "../Sounds/error.mp3");
  SF = new SoundFile[] {new SoundFile(this, "../Sounds/1.wav"), new SoundFile(this, "../Sounds/2.wav"), new SoundFile(this, "../Sounds/3.wav"), new SoundFile(this, "../Sounds/4.wav"),
                        new SoundFile(this, "../Sounds/5.wav"), new SoundFile(this, "../Sounds/6.wav"), new SoundFile(this, "../Sounds/7.wav")};
}

void genius_draw() {
  background(200);
  strokeWeight(3);
  cursor(cursor, 0, 0);

  fill(165, 109, 39);
  rotate(radians(15));
  rect(40, 70, 478, 33, 10);  
  rotate(radians(-30));
  rect(-90, 390, 478, 33, 10);
  rotate(radians(15));
  
  for (int i = 0; i < difficult; ++i) {
    fill(error ? color(255, 0, 0) : Colors[i]);
    rect(40 + 63 * i, 65 + 15 * i, 50, 375 - 30 * i, 10);

    if (!showing && !error && !posclick && i == mousePlace){
      fill(color(255, 255, 255, 100));
      rect(40 + 63 * i, 65 + 15 * i, 50, 375 - 30 * i, 10);
    }
  }
  
  int passedTime = millis() - timeStep;
  
   if (hold) {
    if (millis() - timeStep > holdTime)
      hold = false;
   }

  else if (posclick) {
    fill(color(255, 255, 255, 150 + min((100 * passedTime)/posclickTime, 100 - (100 * passedTime)/posclickTime) ));
    rect(40 + 63 * selectedTile, 65 + 15 * selectedTile, 50, 375 - 30 * selectedTile, 10);
    
    image(note_img, mX + passedTime/15, mY - pow(passedTime, 1.9)/1500, 32, 64 ); 
    
    if (passedTime > posclickTime) {
      timeStep = millis();
      posclick = false;
    }
  }
  else if (error) {
    if (millis() - timeStep > errorTime)
      error = false;
  }
  else if (showing && !breath) {
    fill(color(255, 255, 255, 150 + min((100 * passedTime)/blinkingTime, 100 - (100 * passedTime)/blinkingTime) ));
    rect(40 + 63 * sequence[sequenceId], 65 + 15 * sequence[sequenceId], 50, 375 - 30 * sequence[sequenceId], 10);
    
    image(note_img, 65 + 63 * sequence[sequenceId] + passedTime/15, 250 - pow(passedTime, 1.9)/1500, 32, 64 );

    if (millis() - timeStep > blinkingTime) {
      timeStep = millis();
      breath = true;
    }
  }
  else if (showing && millis() - timeStep > waitingTime) {
    timeStep = millis();
    breath = false;
    
    if (++sequenceId >= sequence.length) {
      showing = false;
      sequenceId = 0;
    }
    else
      SF[sequence[sequenceId]].play();
  }

  strokeWeight(1);
  fill(128, 128, 128);
  for (int i = 0; i < difficult; ++i) {
    circle(65 + 63 * i, 103 + 17 * i, 8);
    circle(65 + 63 * i, 403 - 17 * i, 8);
  }

  strokeWeight(1);
  cursor(ARROW);
}

void genius_mouseClicked(){

  if (mousePlace == -1) {
    sequence = new int[] {parseInt(random(0, difficult))};
    showing = true;
    breath = true;
    sequenceId = -1;
    timeStep = millis();
  }
  else if (!showing && 0 <= mousePlace && mousePlace < difficult) {
    if (sequence.length == 0 || sequence[sequenceId] != mousePlace) {
      errorSound.play();
      error = true;
      sequence = new int[]{};
    }
    else {
      SF[sequence[sequenceId]].play();
      selectedTile = mousePlace;
      posclick = true;
      mX = mouseX;
      mY = mouseY;

      if (++sequenceId >= sequence.length) {
        sequenceId = -1;
        showing = true;
        breath = true;
        hold = true;
        sequence = append(sequence, parseInt(random(0, difficult)));
      }
    }

    timeStep = millis();
  }
}

void genius_mouseMoved() {
  PVector vec = new PVector(mouseX, mouseY);
  
  for (int i = 0; i < difficult; i++)
    if (40 + 63 * i < vec.x && vec.x < 90 + 63 * i && 65 + 15 * i < vec.y && vec.y < 440 - 15 * i) {
      mousePlace = i;
      return;
    }
   
  mousePlace = -1;
}

void genius_exit() {
  if (errorSound.isPlaying())
    errorSound.stop();
    
  for (int i = 0; i < SF.length; ++i)
    if (SF[i].isPlaying())
      SF[i].stop();
      
  sequenceId = 0;
  sequence = new int[] {};
}
