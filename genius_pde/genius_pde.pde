import processing.sound.*;

// prefab
color[] sectionColors = {color(234, 28, 36), color(247, 147, 32), color(245, 229, 12), color(1, 166, 84), color(92, 201, 231), color(18, 74, 149), color(134, 61, 152)};
int sequenceId = 0;
int difficult = 7;
int[] sequence = {};

// Sound
SoundFile[] SF;

// design
int innerCircle = 75;

// automatic
int waitingTime  = 200;
int blinkingTime = 800;
int holdTime = 1500;

int timeStep = 0;
int mousePlace = -1;

boolean error   = false;
boolean showing = false;
boolean breath  = false;
boolean hold = false;

void setup() {
  size(500, 500);
  strokeWeight(3);
  
  SF = new SoundFile[] {new SoundFile(this, "../Sound/1.wav"), new SoundFile(this, "../Sound/2.wav"), new SoundFile(this, "../Sound/3.wav"), new SoundFile(this, "../Sound/4.wav"),
                        new SoundFile(this, "../Sound/5.wav"), new SoundFile(this, "../Sound/6.wav"), new SoundFile(this, "../Sound/7.wav")};
}

void draw() {
  fill(165, 109, 39);
  pushMatrix();
  float angle1 = radians(15);
  rotate(angle1);
  rect(40, 70, 478.58, 33, 10);
  popMatrix();
  
  pushMatrix();
  float angle2 = radians(-15);
  rotate(angle2);
  rect(-90, 390, 478.58, 33, 10);
  popMatrix();
  
  float sectionDegree = 2 * PI / difficult;
  for (int i = 0; i < difficult; ++i) {
    fill(error ? color(255, 0, 0) : sectionColors[i]);
    rect(40 + 63 * i, 65 + 15 * i, 50, 375 - 30 * i, 10);

    if (!showing && !error && i == mousePlace){
      fill(color(255, 255, 255, 200));
      rect(40 + 63 * i, 65 + 15 * i, 50, 375 - 30 * i, 10);
    }
  }
  
  if(hold && millis() - timeStep > holdTime) {
    hold = false;
  } else if (!hold) {
    if (error && millis() - timeStep > blinkingTime)
      error = false;
  
    if (showing && !breath) {
      fill(color(255, 255, 255, 200));
      arc(250, 250, 320, 320, sequence[sequenceId] * sectionDegree, (sequence[sequenceId] + 1) * sectionDegree, PIE);
  
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
  }
}

void mouseClicked(){

  if (mousePlace == -1) {
    showing = false;
    sequenceId = -1;
    sequence = new int[] {parseInt(random(0, difficult))};
    showing = true;
    breath = true;
    timeStep = millis();
  }
  else if (!showing && 0 <= mousePlace && mousePlace < difficult) {
    if (sequence.length == 0 || sequence[sequenceId] != mousePlace)
      error = true;
    else {
      SF[sequence[sequenceId]].play();

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

void mouseMoved() {
  PVector vec = new PVector(mouseX, mouseY);
  
  for (int i = 0; i < difficult; i++)
    if (40 + 63 * i < vec.x && vec.x < 90 + 63 * i && 65 + 15 * i < vec.y && vec.y < 440 - 15 * i) {
      mousePlace = i;
      return;
    }
  
   
  mousePlace = -1;
}
