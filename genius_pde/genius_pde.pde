import processing.sound.*;

// prefab
color[] sectionColors = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0), color(255, 0, 255), color(0, 255, 255)};
int[] sequence = {};
int sequenceId = 0;
int difficult = 4;

// Sound
SoundFile[] SF;

// design
int innerCircle = 75;

// automatic
int waitingTime  = 200;
int blinkingTime = 800;

int timeStep = 0;
int mousePlace = -1;

boolean error   = false;
boolean showing = false;
boolean breath  = false;

void setup() {
  size(500, 500);
  strokeWeight(6);
  
  SF = new SoundFile[] {new SoundFile(this, "../Sound/1.wav"), new SoundFile(this, "../Sound/2.wav"), new SoundFile(this, "../Sound/3.wav"), new SoundFile(this, "../Sound/4.wav"),
                        new SoundFile(this, "../Sound/5.wav"), new SoundFile(this, "../Sound/6.wav"), new SoundFile(this, "../Sound/7.wav")};
}

void draw() {
  fill(color(0, 0, 0));
  arc(250, 250, 400, 400, 0, 2 * PI, PIE);

  float sectionDegree = 2 * PI / difficult;
  for (int i = 0; i < difficult; ++i) {
    fill(error ? color(255, 0, 0) : sectionColors[i]);
    arc(250, 250, 320, 320, i * sectionDegree, (i + 1) * sectionDegree, PIE);

    if (!showing && !error && i == mousePlace){
      fill(color(255, 255, 255, 200));
      arc(250, 250, 320, 320, i * sectionDegree, (i + 1) * sectionDegree, PIE);
    }
  }
  
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

  fill(color(0, 0, 0));
  arc(250, 250, 2 * innerCircle, 2 * innerCircle, 0, 2 * PI, PIE);
}

void mouseClicked(){

  if (mousePlace == 100) {
    showing = false;
    sequenceId = 0;
    sequence = new int[] {parseInt(random(0, difficult))};
    SF[sequence[0]].play();
    showing = true;
    timeStep = millis();
    breath = false;
  }
  else if (!showing && 0 <= mousePlace && mousePlace < difficult) {
    if (sequence.length == 0 || sequence[sequenceId] != mousePlace)
      error = true;
    else if (++sequenceId >= sequence.length) {
      sequenceId = 0;
      showing = true;
      SF[sequence[0]].play();
      sequence = append(sequence, parseInt(random(0, difficult)));
    }
    else
      SF[sequence[sequenceId]].play();
    timeStep = millis();
  }
}

void mouseMoved() {
  PVector vec = new PVector(mouseX - 250, mouseY - 250);
  
  if (vec.dot(vec) < innerCircle * innerCircle)
    mousePlace = 100;
  else if (vec.dot(vec) < 160 * 160){
    float angle = PVector.angleBetween(vec.normalize(), new PVector(1, 0));
    
    if (vec.y < 0)
      angle = TWO_PI - angle;
     
    mousePlace = parseInt(angle * difficult / TWO_PI);
  }
  else 
    mousePlace = -1;
}
