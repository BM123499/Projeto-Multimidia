import processing.sound.*;
Waveform ins_waveform;

SoundFile somTambor, somCorneta, somViolao, somTriangulo, somDaVez, somVitoria, somDerrota;
PImage img, tamborButton, cornetaButton, violaoButton, trianguloButton, ouvir;
int tbX = 18, cbX = 201, vbX = 384 , trbX = 567, bY = 521;
int numeroDoInstrumento;
int insOver = -1;
  
void instrumentos_setup() {
  img = loadImage("../Images/Instrumentos.png");
  tamborButton = loadImage("../Images/tambor.png");
  cornetaButton = loadImage("../Images/corneta.png");
  violaoButton = loadImage("../Images/violao.png");
  trianguloButton = loadImage("../Images/triangulo.png");
  
  somTambor = new SoundFile(this, "../Sounds/somTambor.wav");
  somCorneta = new SoundFile(this, "../Sounds/somCorneta.wav");
  somViolao = new SoundFile(this, "../Sounds/somViolao.wav");
  somTriangulo = new SoundFile(this, "../Sounds/somTriangulo.wav");
  somVitoria = new SoundFile(this, "../Sounds/win.wav");
  somDerrota = new SoundFile(this, "../Sounds/lost.wav");

  numeroDoInstrumento = ceil(random(1, 4));
}
  
void instrumentos_draw() {
  //setando resposta certa
  if (numeroDoInstrumento == 1)
    somDaVez = somTambor;
  else if (numeroDoInstrumento == 2)
    somDaVez = somCorneta;
  else if (numeroDoInstrumento == 3)
    somDaVez = somViolao;
  else
    somDaVez = somTriangulo;

  //fundo e imagens dos botoes
  fill(255, 140);
  noStroke();

  image(img, 0, 0);
  image(tamborButton, tbX, bY);
  if (insOver == 0)
    circle(tbX + 82, bY + 78, 156);
  image(cornetaButton, cbX, bY);
  if (insOver == 1)
    circle(cbX + 83, bY + 78, 156);
  image(violaoButton, vbX, bY);
  if (insOver == 2)
    circle(vbX + 83, bY + 78, 156);
  image(trianguloButton, trbX, bY);
  if (insOver == 3)
    circle(trbX + 83, bY + 78, 156);
 
  fill(255);
  rect(50, 150, 650, 250, 20);
  
  if (somDaVez.isPlaying()) {
    ins_waveform.analyze();

    for(int i = 0; i < 100; i++) {
      fill(255 - 255 * (i/100.0), 0, 255 * (i/100.0));
      rect(6.5 * i + 51, 275 - 100 * ins_waveform.data[i], 3, 200 * ins_waveform.data[i], 3);
    }
  }
  else {
    fill(0);
    textSize(38); 
    text("Clique para escutar", 200, 290);
  }
  
  fill(0);
  textSize(30);
  text("Maior Pontuação: " + str(HScore[1]), 425, 730);
  text("Pontuação Atual: " + str(actualScore[1]), 50, 730);

  stroke(0);
}
  
void instrumentos_mouseClicked(){
  
  if (somVitoria.isPlaying())
    somVitoria.stop();
  if (somDerrota.isPlaying())
    somDerrota.stop();
  if (somDaVez.isPlaying())
    somDaVez.stop();

  //clique para ouvir
  if(    50 < mouseX && mouseX < 700
     && 150 < mouseY && mouseY < 400) {
        somDaVez.play();
        activateNote = true;
        ins_waveform = new Waveform(this, 100);
        ins_waveform.input(somDaVez);
  }

  //tambor
  if(   mouseX > tbX && mouseX < (tbX + tamborButton.width)
     && mouseY >  bY && mouseY < ( bY + tamborButton.height)){

    activateNote = true;
    if (numeroDoInstrumento == 1) {
      somVitoria.play();
      numeroDoInstrumento = ceil(random(1, 4));
      HScore[1] = max(++actualScore[1], HScore[1]);
    }
    else {
      actualScore[1] = 0;
      somDerrota.play();
    }
  }

  //corneta
  if(   mouseX > cbX && mouseX < (cbX + cornetaButton.width)
     && mouseY >  bY && mouseY < ( bY + cornetaButton.height)){

    activateNote = true;
    if (numeroDoInstrumento == 2) {
      somVitoria.play();
      numeroDoInstrumento = ceil(random(1, 4));
      HScore[1] = max(++actualScore[1], HScore[1]);
    }
    else {
      actualScore[1] = 0;
      somDerrota.play();
    }
  }

  //violao
  if(   mouseX > vbX && mouseX < (vbX + violaoButton.width)
     && mouseY >  bY && mouseY < ( bY + violaoButton.height)){

    activateNote = true;
    if (numeroDoInstrumento == 3) {
      somVitoria.play();
      numeroDoInstrumento = ceil(random(1, 4));
      HScore[1] = max(++actualScore[1], HScore[1]);
    }
    else {
      actualScore[1] = 0;
      somDerrota.play();
    }
  }

  //triangulo
  if(   mouseX > trbX && mouseX < (trbX + trianguloButton.width)
     && mouseY >   bY && mouseY < (  bY + trianguloButton.height)) {

    activateNote = true;
    if (numeroDoInstrumento == 4) {
      somVitoria.play();
      numeroDoInstrumento = ceil(random(1, 4));
      HScore[1] = max(++actualScore[1], HScore[1]);
    }
    else {
      actualScore[1] = 0;
      somDerrota.play();
    }
  }
}

void instrumentos_mouseMoved() {
  insOver = -1;

  //tambor
  if(   mouseX > tbX && mouseX < (tbX + tamborButton.width)
     && mouseY >  bY && mouseY < ( bY + tamborButton.height))
     insOver = 0;

  //corneta
  if(   mouseX > cbX && mouseX < (cbX + cornetaButton.width)
     && mouseY >  bY && mouseY < ( bY + cornetaButton.height))
     insOver = 1;

  //violao
  if(   mouseX > vbX && mouseX < (vbX + violaoButton.width)
     && mouseY >  bY && mouseY < ( bY + violaoButton.height))
     insOver = 2;

  //triangulo
  if(   mouseX > trbX && mouseX < (trbX + trianguloButton.width)
     && mouseY >   bY && mouseY < (  bY + trianguloButton.height))
      insOver = 3;
}

void instrumentos_exit() {

  if (somDaVez.isPlaying())
    somDaVez.stop();

  if (somTambor.isPlaying())
    somTambor.stop();
  if (somCorneta.isPlaying())
    somCorneta.stop();
  if (somViolao.isPlaying())
    somViolao.stop();
  if (somVitoria.isPlaying())
    somVitoria.stop();
  if (somDerrota.isPlaying())
    somDerrota.stop();
}
