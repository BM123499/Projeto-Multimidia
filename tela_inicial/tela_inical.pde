PImage bg;

int rectX, rectY;
int rectSize = 140;
int gapRectY = 85;
boolean genButtonOver = false, seqButtonOver = false, notasButtonOver = false, insButtonOver = false;

void setup() {
  size(750, 750);
  // A imagem precisa ter o mesmo tamanho da tela
  bg = loadImage("Tela_Inicial.png");
  
  rectX = width/2-rectSize-10;
  rectY = height/2-rectSize/5;
}

void draw() {
  background(bg);
  
  if(genButtonOver){
    fill(#b25726);
  } else {
    fill(#FF7D37);
  }
  rect(rectX, rectY, rectSize + 180, rectSize - 90, 25);
  
  textSize(30);
  fill(0, 0, 0);
  text("Gêneros", rectX + 100, rectY + 35);
  
  if(seqButtonOver){
    fill(#b20079);
  } else {
    fill(#FF00AE);
  }
  rect(rectX, rectY + gapRectY, rectSize + 180, rectSize - 90, 25);
  
  fill(0, 0, 0);
  text("Sequências", rectX + 80, rectY + gapRectY + 35);
  
  if(notasButtonOver){
    fill(#b2953e);
  } else {
    fill(#FFD659);
  }
  rect(rectX, rectY + gapRectY*2, rectSize + 180, rectSize - 90, 25);
  
  fill(0, 0, 0);
  text("Notas", rectX + 120, rectY + gapRectY*2 + 35);
  
  if(insButtonOver){
    fill(#008076);
  } else {
    fill(#00B8A9);
  }
  rect(rectX, rectY + gapRectY*3, rectSize + 180, rectSize - 90, 25);
  
  fill(0, 0, 0);
  text("Instrumentos", rectX + 70, rectY + gapRectY*3 + 35);
  
}

void mouseMoved(){
  if ( overRect(rectX, rectY, rectSize + 180, rectSize - 90) ) {
    genButtonOver = true; 
    seqButtonOver = notasButtonOver = insButtonOver = false;
  } else if ( overRect(rectX, rectY + gapRectY, rectSize + 180, rectSize - 90) ) {
    seqButtonOver = true; 
    genButtonOver = notasButtonOver = insButtonOver = false;
  } else if ( overRect(rectX, rectY + gapRectY*2, rectSize + 180, rectSize - 90) ) {
    notasButtonOver = true; 
    seqButtonOver = genButtonOver = insButtonOver = false;
  } else if ( overRect(rectX, rectY + gapRectY*3, rectSize + 180, rectSize - 90) ) {
    insButtonOver = true; 
    seqButtonOver = notasButtonOver = genButtonOver = false;
  } else {
    genButtonOver = seqButtonOver = notasButtonOver = insButtonOver = false;
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void mousePressed(){
  if(genButtonOver){
    print("gêneros");
  } else if(seqButtonOver){
    print("sequências");
  } else if(notasButtonOver){
    print("notas");
  } else if(insButtonOver){
    print("instrumentos");
  }
}
