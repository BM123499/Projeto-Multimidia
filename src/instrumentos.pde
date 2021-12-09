import processing.sound.*;

SoundFile somTambor, somCorneta, somViolao, somTriangulo, somDaVez, somVitoria, somDerrota;
PImage img, tamborButton, cornetaButton, violaoButton, trianguloButton, ouvir;
int tbX = 18, cbX = 201, vbX = 384 , trbX = 567, bY = 521;
int numeroDoInstrumento;
  
void instrumentos_setup() {
  img = loadImage("../Images/Instrumentos.png");
  ouvir = loadImage("../Images/ouvir.png");
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
  image(img, 0, 0);
  image(tamborButton, tbX, bY);
  image(cornetaButton, cbX, bY);
  image(violaoButton, vbX, bY);
  image(trianguloButton, trbX, bY);
  image(ouvir, 110, 154);
  
  //botao de escutar
  fill(1, 166, 84);
  noStroke();
  rect(230.5, 420, 282, 35, 20);
  fill(0, 0, 0);
  textSize(23); 
  text("Clique para escutar", 264, 445);
  
  stroke(0);
}
  
void instrumentos_mouseClicked(){
  somDaVez.stop();

  //clique para ouvir
  if(   mouseX > 230.5 && mouseX < (230.5 + 282)
     && mouseY > 420   && mouseY < (420   + 35)) {
        somDaVez.play();
        activateNote = true;
  }

  //tambor
  if(   mouseX > tbX && mouseX < (tbX + tamborButton.width)
     && mouseY >  bY && mouseY < ( bY + tamborButton.height)){

    activateNote = true;
    if (numeroDoInstrumento == 1) {
      somVitoria.play();
      numeroDoInstrumento = ceil(random(1, 4));
    }
    else
      somDerrota.play();
  }

  //corneta
  if(   mouseX > cbX && mouseX < (cbX + cornetaButton.width)
     && mouseY >  bY && mouseY < ( bY + cornetaButton.height)){

    activateNote = true;
    if (numeroDoInstrumento == 2) {
      somVitoria.play();
      numeroDoInstrumento = ceil(random(1, 4));
    }
    else
      somDerrota.play();
  }

  //violao
  if(   mouseX > vbX && mouseX < (vbX + violaoButton.width)
     && mouseY >  bY && mouseY < ( bY + violaoButton.height)){

    activateNote = true;
    if (numeroDoInstrumento == 3) {
      somVitoria.play();
      numeroDoInstrumento = ceil(random(1, 4));
    }
    else
      somDerrota.play();
  }

  //triangulo
  if(   mouseX > trbX && mouseX < (trbX + trianguloButton.width)
     && mouseY >   bY && mouseY < (  bY + trianguloButton.height)) {

    activateNote = true;
    if (numeroDoInstrumento == 4) {
      somVitoria.play();
      numeroDoInstrumento = ceil(random(1, 4));
    }
    else
      somDerrota.play();
  }
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
