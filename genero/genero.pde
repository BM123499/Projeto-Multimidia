import processing.sound.*;
Waveform waveform;

PImage img;

SoundFile[] musicas;
String[] generos;

String[] todasOpcoes = {"Funk", "Rock", "POP", "KPOP", "Opcao1", "Opcao2", "Opcao3", "Opcao4"};
String[] opcoes = new String[] {"Opcao1", "Opcao2", "Opcao3", "Opcao4"};

int idMusica = -1;
int resposta = -1; 

void setup() {
  size(750, 750);
  img = loadImage("Genero.png");

  musicas = new SoundFile[] {new SoundFile(this, "sample.aiff")};
  generos = new String[] {"POP"};
  
  fill(255);
  textAlign(CENTER, CENTER);
}

void draw() {
  image(img, 0, 0, width, height);
  
  fill(255);
  noStroke();
  rect(50, 150, 650, 250, 20);
  
  if (idMusica >= 0 && musicas[idMusica].isPlaying()){
    waveform.analyze();

    for(int i = 0; i < 100; i++) {
      fill(255 - 255 * (i/100.0), 0, 255 * (i/100.0));
      rect(6.5 * i + 51, 275 - 100 * waveform.data[i], 3, 200 * waveform.data[i], 3);
    }
  }
  else {
    fill(0);
    textSize(30);
    text("Clique para escutar", 375, 275);
  }

  stroke(5);
  fill(247, 147, 32);
  rect( 50, 500, 300, 60, 15);
  fill( 92, 201, 231);
  rect(400, 500, 300, 60, 15);
  fill(245, 229, 12);
  rect( 50, 600, 300, 60, 15);
  fill(  1, 166, 84);
  rect(400, 600, 300, 60, 15);

  fill(255);
  textSize(30);
  text(opcoes[0], 200, 530);
  text(opcoes[1], 550, 530);
  text(opcoes[2], 200, 630);
  text(opcoes[3], 550, 630);
  rectMode(CORNER);
}

void mouseClicked() {
  int selecionado = -1;
  
  if (50 < mouseX && mouseX < 700 && 150 < mouseY && mouseY < 400)
    selecionado = 4;
  else if (50 < mouseX && mouseX < 350) {
    if (500 < mouseY && mouseY < 560)
      selecionado = 0;
    else if (600 < mouseY && mouseY < 660)
      selecionado = 1;
  }
  else if (400 < mouseX && mouseX < 700) {
    if (500 < mouseY && mouseY < 560)
      selecionado = 2;
    else if (600 < mouseY && mouseY < 660)
      selecionado = 3;
  }
  
  if (selecionado == -1)
    return;

  if (selecionado == 4) {
    if (idMusica >= 0 && musicas[idMusica].isPlaying())
      musicas[idMusica].stop();
      
    resposta = parseInt(random(4));
    idMusica = parseInt(random(generos.length));    
    opcoes[resposta] = generos[idMusica];

    for (int i = 0; i < 4; ++i) {
      if (i == resposta)
        continue;

      Boolean b = true;
      while(b) {
        opcoes[i] = todasOpcoes[parseInt(random(todasOpcoes.length))];

        b = opcoes[i].equals(generos[idMusica]);
        for (int j = 0; j < i; ++j)
          if (opcoes[i].equals(opcoes[j]))
            b = true;
      }
    }
    
    waveform = new Waveform(this, 100);
    waveform.input(musicas[idMusica]);
    musicas[idMusica].play();
  }
  else if (resposta != -1) {
    if (resposta == selecionado) {
      println("acertou");
    }
    else {
      println("errou");
    }
    
    musicas[idMusica].stop();
  }
  
}
