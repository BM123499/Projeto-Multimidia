  import processing.sound.*;
  
  SoundFile somTambor, somCorneta, somViolao, somTriangulo, somDaVez, somVitoria, somDerrota;
  PImage img, tamborButton, cornetaButton, violaoButton, trianguloButton, ouvir;
  int tbX = 18, cbX = 201, vbX = 384 , trbX = 567, bY = 521;
  int numeroDoInstrumento;
  
  void setup() {
    size(750,750);
    img = loadImage("Instrumentos.png");
    ouvir = loadImage("ouvir.png");
    tamborButton = loadImage("tambor.png");
    cornetaButton = loadImage("corneta.png");
    violaoButton = loadImage("violao.png");
    trianguloButton = loadImage("triangulo.png");
    
    somTambor = new SoundFile(this, "./data/somTambor.wav");
    somCorneta = new SoundFile(this, "./data/somCorneta.wav");
    somViolao = new SoundFile(this, "./data/somViolao.wav");
    somTriangulo = new SoundFile(this, "./data/somTriangulo.wav");
    somVitoria = new SoundFile(this, "./data/win.wav");
    somDerrota = new SoundFile(this, "./data/lost.wav");
  
  
    numeroDoInstrumento = ceil(random(1, 4));
    
    if (numeroDoInstrumento == 1){
      somDaVez = somTambor;
    } else if (numeroDoInstrumento == 2){
      somDaVez = somCorneta;
    } else if (numeroDoInstrumento == 3){
      somDaVez = somViolao;
    } else{
      somDaVez = somTriangulo;
    }
  
  }
  
  void draw() {
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
  }
  
  void mouseClicked(){
    //clique para ouvir 
      if( mouseX > 230.5 && mouseX < (230.5 + 282) &&
        mouseY > 420 && mouseY < (420 + 35)){
            somDaVez.play();
        };
    //tambor
    if( mouseX > tbX && mouseX < (tbX + tamborButton.width) &&
        mouseY > bY && mouseY < (bY + tamborButton.height)){
          print(numeroDoInstrumento);
          if (numeroDoInstrumento == 1){
            somVitoria.play();
          } else{
            somDerrota.play();
          }
        };
     //corneta
     if( mouseX > cbX && mouseX < (cbX + cornetaButton.width) &&
        mouseY > bY && mouseY < (bY + cornetaButton.height)){
          if (numeroDoInstrumento == 2){
            somVitoria.play();
          } else{
            somDerrota.play();
          }
        };
     //violao
     if( mouseX > vbX && mouseX < (vbX + violaoButton.width) &&
        mouseY > bY && mouseY < (bY + violaoButton.height)){
           if (numeroDoInstrumento == 3){
            somVitoria.play();
          } else{
            somDerrota.play();
          }
        };
     //triangulo
     if( mouseX > trbX && mouseX < (trbX + trianguloButton.width) &&
        mouseY > bY && mouseY < (bY + trianguloButton.height)){
            if (numeroDoInstrumento == 4){
            somVitoria.play();
          } else{
            somDerrota.play();
          }
        }; 
      }
