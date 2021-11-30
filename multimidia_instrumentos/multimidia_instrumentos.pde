import processing.sound.*;

SoundFile somTambor;
PImage img, tamborButton, cornetaButton, violaoButton, trianguloButton, ouvir;
int tbX = 18, cbX = 201, vbX = 384 , trbX = 567, bY = 521;
String answer = " ";

void setup() {
  size(750,750);
  img = loadImage("Instrumentos.png");
  ouvir = loadImage("ouvir.png");
  tamborButton = loadImage("tambor.png");
  cornetaButton = loadImage("corneta.png");
  violaoButton = loadImage("violao.png");
  trianguloButton = loadImage("triangulo.png");
  
  somTambor = new SoundFile(this, "./data/somTambor.wav");
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
          somTambor.play();
      };
  //tambor
  if( mouseX > tbX && mouseX < (tbX + tamborButton.width) &&
      mouseY > bY && mouseY < (bY + tamborButton.height)){
        answer = "tambor";
        print(answer);
      };
   //corneta
   if( mouseX > cbX && mouseX < (cbX + cornetaButton.width) &&
      mouseY > bY && mouseY < (bY + cornetaButton.height)){
        answer = "corneta";
        print(answer);
      };
   //violao
   if( mouseX > vbX && mouseX < (vbX + violaoButton.width) &&
      mouseY > bY && mouseY < (bY + violaoButton.height)){
        answer = "violao";
        print(answer);
      };
   //triangulo
   if( mouseX > trbX && mouseX < (trbX + trianguloButton.width) &&
      mouseY > bY && mouseY < (bY + trianguloButton.height)){
        answer = "triangulo";
        print(answer);
      }; 
    }
