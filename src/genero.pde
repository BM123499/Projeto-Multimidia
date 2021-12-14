import processing.sound.*;
Waveform gen_waveform;

PImage gen_img;

SoundFile[] musicas;
String[] generos;

String[] todasOpcoes = {"Funk", "Rock", "POP", "KPOP", "Folk", "Forró", "MPB", "Rap"};
String[] opcoes = new String[] {"Opcao1", "Opcao2", "Opcao3", "Opcao4"};

int idMusica = -1;
int resposta = -1;
int genOver  = -1;

void genero_setup() {
  gen_img = loadImage("../Images/Generos.png");

  musicas = new SoundFile[] {new SoundFile(this, "../Sounds/sample.aiff")};
  generos = new String[] {"POP"};
}

void genero_draw() {
  fill(255);
  textAlign(CENTER, CENTER);

  image(gen_img, 0, 0, width, height);
  
  fill(255);
  noStroke();
  rect(50, 150, 650, 250, 20);
  
  if (idMusica >= 0 && musicas[idMusica].isPlaying()){
    gen_waveform.analyze();

    for(int i = 0; i < 100; i++) {
      fill(255 - 255 * (i/100.0), 0, 255 * (i/100.0));
      rect(6.5 * i + 51, 275 - 100 * gen_waveform.data[i], 3, 200 * gen_waveform.data[i], 3);
    }
  }
  else {
    fill(0);
    textSize(30);
    text("Clique para escutar", 375, 275);
  }

  stroke(5);
  fill( genOver == 0 ? color(255, 177,  62) : color(247, 147, 32));
  rect( 50, 500, 300, 60, 15);
  fill( genOver == 1 ? color(122, 231, 255) : color( 92, 201, 231));
  rect(400, 500, 300, 60, 15);
  fill( genOver == 2 ? color(255, 255,  42) : color(245, 229,  12));
  rect( 50, 600, 300, 60, 15);
  fill( genOver == 3 ? color( 31, 196, 114) : color(  1, 166,  84));
  rect(400, 600, 300, 60, 15);

  fill(255);
  textSize(30);
  text(opcoes[0], 200, 530);
  text(opcoes[1], 550, 530);
  text(opcoes[2], 200, 630);
  text(opcoes[3], 550, 630);
  rectMode(CORNER);
  
  textAlign(LEFT, BASELINE);
  fill(0);
  textSize(30);
  text("Maior Pontuação: " + str(HScore[2]), 425, 730);
  text("Pontuação Atual: " + str(actualScore[2]), 50, 730);
}

void genero_mouseClicked() {
  int selecionado = -1;
  
  if (50 < mouseX && mouseX < 700 && 150 < mouseY && mouseY < 400)
    selecionado = 4;
  else if (50 < mouseX && mouseX < 350) {
    if (500 < mouseY && mouseY < 560)
      selecionado = 0;
    else if (600 < mouseY && mouseY < 660)
      selecionado = 2;
  }
  else if (400 < mouseX && mouseX < 700) {
    if (500 < mouseY && mouseY < 560)
      selecionado = 1;
    else if (600 < mouseY && mouseY < 660)
      selecionado = 3;
  }
  
  if (selecionado == -1)
    return;

  activateNote = true;
  if (0 <= resposta && resposta < 4 && selecionado != 4) {
    if (resposta == selecionado)
      HScore[2] = max(++actualScore[2], HScore[2]);
    else
      actualScore[2] = 0;

    musicas[idMusica].stop();
  }

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
  
  gen_waveform = new Waveform(this, 100);
  gen_waveform.input(musicas[idMusica]);
  musicas[idMusica].play();
}

void genero_mouseMoved() {
  genOver = -1;

  if (50 < mouseX && mouseX < 350) {
    if (500 < mouseY && mouseY < 560)
      genOver = 0;
    else if (600 < mouseY && mouseY < 660)
      genOver = 2;
  }
  else if (400 < mouseX && mouseX < 700) {
    if (500 < mouseY && mouseY < 560)
      genOver = 1;
    else if (600 < mouseY && mouseY < 660)
      genOver = 3;
  }
}

void genero_exit() {
  if (idMusica >= 0 && musicas[idMusica].isPlaying())
    musicas[idMusica].stop();

  idMusica = -1;
  resposta = -1; 
}
