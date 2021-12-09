import processing.sound.*;

String[] NOTES = {"DÓ", "RÉ", "MI", "FÁ", "SOL", "LÁ", "SI"}; 

SoundFile[] NOTES_SOUNDS;
SoundFile ERROR_SOUND;

int STATE_INITIAL = 1;
int STATE_WAITING_FOR_ANSWER = 2;
int STATE_CORRECT = 3;
int STATE_ERROR = 4;

int CURRENT_STATE = 1;
String CHOSEN_NOTE = null;
int CHOSEN_NOTE_INDEX = -1;

int LARGURA_BOTAO = 147;
int ALTURA_BOTAO = 64;

color[] CORES_BOTOES = {#00B8A9, #FF00AE, #FF7D37, #FFD659}; 
int[] X_INICIAL_BOTOES = {37, 214, 214 + 177, 214 + 177*2, 125, 125 + 177, 125 + 177 * 2 };
int[] Y_INICIAL_BOTOES = {482, 482, 482, 482, 575, 575, 575 };

void nota_setup() {
  ERROR_SOUND = new SoundFile(this, "../Sounds/error.mp3");
  NOTES_SOUNDS = new SoundFile[] {new SoundFile(this, "../Sounds/1.wav"), new SoundFile(this, "../Sounds/2.wav"), new SoundFile(this, "../Sounds/3.wav"), new SoundFile(this, "../Sounds/4.wav"),
                                  new SoundFile(this, "../Sounds/5.wav"), new SoundFile(this, "../Sounds/6.wav"), new SoundFile(this, "../Sounds/7.wav")};
}
void initialize() {
  int chosenIndex = int(random(NOTES.length - 1));
  CHOSEN_NOTE = NOTES[chosenIndex];
  CHOSEN_NOTE_INDEX = chosenIndex;
  CURRENT_STATE = STATE_WAITING_FOR_ANSWER; 
}

void onAnswer(String note) {
  if (CHOSEN_NOTE.equals(note)) {
    CURRENT_STATE = STATE_CORRECT;
    NOTES_SOUNDS[CHOSEN_NOTE_INDEX].play();
  } else {
    CURRENT_STATE = STATE_ERROR; 
    ERROR_SOUND.play();
  }
}

void cleanUp() {
  CHOSEN_NOTE = null;
  CURRENT_STATE = STATE_INITIAL;
}

void drawBackground() { 
  image(loadImage("../Images/Notas.png"), 0 , 0);
  image(loadImage("../Images/pauta.png"), 0 , 150);
}

void drawWaitingForAnswer() {  
  // Desenhar a nota na pauta
  int[] POSICOES_NOTAS = {243, 260, 348, 330, 312, 295, 277};
  PImage whole = loadImage("../Images/whole.png");
  whole.resize(0, 30);
  image(whole, 300, POSICOES_NOTAS[CHOSEN_NOTE_INDEX]);
  
  // Desenhar os botões
  for(int i = 0; i < NOTES.length; i++) {
    fill(CORES_BOTOES[i % CORES_BOTOES.length]);
    rect(X_INICIAL_BOTOES[i], Y_INICIAL_BOTOES[i], LARGURA_BOTAO, ALTURA_BOTAO);
    fill(0);
    textSize(48);
    text(NOTES[i], X_INICIAL_BOTOES[i] + 40, Y_INICIAL_BOTOES[i] + 55);
  }
}

void nota_mouseClicked() {
  if(isTerminalState()) {
    cleanUp();
  }
  if(CURRENT_STATE != STATE_WAITING_FOR_ANSWER) {
    return;
  }
  
  // Clicar no botão de resposta
  for(int i = 0; i < NOTES.length; i++) {
    if(overButton(X_INICIAL_BOTOES[i], Y_INICIAL_BOTOES[i])) {
      onAnswer(NOTES[i]);
    }
  }
}

boolean overButton(int x, int y)  {
 return (mouseX >= x && mouseX <= x+LARGURA_BOTAO && mouseY >= y && mouseY <= y+ALTURA_BOTAO);
}

void drawCorrect() {
    textSize(48);
    activateNote = true;
    text("MUITO BEM!", 250, 570);
}

void drawError() {
    textSize(48);
    activateNote = true;
    text("OOPS!", 300, 570);
}

boolean isTerminalState() {
  return CURRENT_STATE == STATE_CORRECT || CURRENT_STATE == STATE_ERROR;
}

void nota_draw() {
  drawBackground();
  
  if (CURRENT_STATE == STATE_INITIAL) {
    initialize(); 
  } else if (CURRENT_STATE == STATE_WAITING_FOR_ANSWER) {
    drawWaitingForAnswer();
  } else if (CURRENT_STATE == STATE_CORRECT) {
    drawCorrect();
  } else if (CURRENT_STATE == STATE_ERROR) {
    drawError();
  }
}

void nota_exit() {
  for (int i = 0; i < NOTES_SOUNDS.length; ++i)
    if (NOTES_SOUNDS[i].isPlaying())
      NOTES_SOUNDS[i].stop();
  
  if (ERROR_SOUND.isPlaying())
    ERROR_SOUND.stop();
}
