import processing.sound.*;

int screen = 0;
int noteDuration = 500;
int noteStart = -noteDuration - 1;
boolean activateNote = false;
int mX, mY;
int[] HScore = new int[] {0, 0, 0, 0}, actualScore = new int[] {0, 0, 0, 0};

void setup() {
  size(750, 750);

  genero_setup();
  tela_setup();
  nota_setup();
  instrumentos_setup();
  genius_setup();
}

void draw() {

  if (screen == 0)
    tela_draw();
  else if (screen == 1)
    nota_draw();
  else if (screen == 2)
    instrumentos_draw();
  else if (screen == 3)
    genero_draw();
  else if (screen == 4)
    genius_draw();
  else
    println("Wrong Screen:" + screen);

  if (activateNote && millis() < noteStart + noteDuration)
    image(note_img, mX + (millis() - noteStart)/15, mY - pow((millis() - noteStart), 2)/1500, 32, 64);

  fill(0);
  textSize(50);
  text("x", 695, 55);
}

void mouseClicked() {
  mX = mouseX;
  mY = mouseY;
  noteStart = millis();
  activateNote = false;
  
  if (mouseX > 690 && mouseY < 55){
    if (screen == 0)
      exit();
    else if (screen == 1)
      nota_exit();
    else if (screen == 2)
      instrumentos_exit();
    else if (screen == 3)
      genero_exit();
    else if (screen == 4)
      genius_exit();

    screen = 0;
    return;
  }

  if (screen == 0)
    tela_mouseClicked();
  else if (screen == 1)
    nota_mouseClicked();
  else if (screen == 2)
    instrumentos_mouseClicked();
  else if (screen == 3)
    genero_mouseClicked();
  else if (screen == 4)
    genius_mouseClicked();
  else
    println("Wrong Screen:" + screen);
}

void mouseMoved() {
  if (screen == 0)
    tela_mouseMoved();
  else if (screen == 1)
    nota_mouseMoved();
  else if (screen == 2)
    instrumentos_mouseMoved();
  else if (screen == 3)
    genero_mouseMoved();
  else if (screen == 4)
    genius_mouseMoved();
  else
    println("Wrong Screen:" + screen);
}
