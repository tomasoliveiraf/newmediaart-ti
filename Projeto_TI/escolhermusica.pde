
int[] rectX = new int[5];
int rectY;
String[] songNames = {
  "Guita Pimpolho - AI oh mano.mp3",
  "Guita Pimpolho - Baila Morena.mp3",
  "GUITA PIMPOLHO  FT HELDER KICKER Chorei Amargo.mp3",
  "GUITA PIMPOLHO - MELON CELESTE.mp3",
  "GUITA PIMPOLHO FT ANDRÉ FILIPE - TIKTOK OFICIAL.mp3"
};

void carregarescolha() {
  carregar = true;
  rectY = height / 2 - 40 / 2;

  for (int i = 0; i < 5; i++) {
    rectX[i] = i * 330 + width / 3;
  }
}

void escolha() {
  if (!carregar) {
    carregarescolha();
  }

  fill(0);
  textSize(50);
  text("Choose a song", width / 3, 350);

  update(mouseX, mouseY);

  for (int i = 0; i < 5; i++) {
    fill(255);
    stroke(10);
    rect(rectX[i] + width/5, rectY + i * 50 + height / 2, 500, 40);
    fill(0);
    textSize(20);
    text(songNames[i], rectX[i] + width/5, rectY + 25 + i * 50 + height / 2);
  }
}

void update(int x, int y) {
  for (int i = 0; i < 5; i++) {
    rectOver[i] = mouseX > rectX[i] && mouseX < rectX[i] + 500 && mouseY > rectY + i * 50 + height / 2 && mouseY < rectY + 40 + i * 50 + height / 2;
  }
}


boolean overRect(int x, int y, int width, int height) {

  if (mouseX >= x && mouseX <= x+width &&
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
/*
void fileSelected(File selection) {
 
 if (selection == null) {
 println("Window was closed or the user hit cancel.");
 } else {
 println("User selected " + selection.getAbsolutePath());
 }
 }*/
