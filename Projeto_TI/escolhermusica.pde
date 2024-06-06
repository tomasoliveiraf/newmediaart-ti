int[] rectX = new int[5];
int rectY;
String[] songNames = {
  "Angerfist - Street Fighter.mp3",
  "Guita Pimpolho - Baila Morena.mp3",
  "carolina deslandes - paz drill remix.mp3",
  "MARIACHI FUNK.mp3",
  "Xutos e Pontapés - Ai Se Ele Cai.mp3"
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


  //ewcolher musica
  fill(0);
  textSize(50);
  textFont(font);
  text("Choose a song", width / 3, 350);

  update(joifinal.x, joifinal.y);

  for (int i = 0; i < 5; i++) {
    fill(255);
    stroke(10);
    rect(rectX[i] + width/5, rectY + i * 50 + height / 2, 500, 40);
    fill(0);
    textSize(20);
    text(songNames[i], rectX[i] + width/5, rectY + 25 + i * 50 + height / 2);
  }

  //desenhar "rato" do joystick
  ellipse(joifinal.x, joifinal.y, 20, 20);
}

void update(float x, float y) {
  for (int i = 0; i < 5; i++) {
    rectOver[i] = x > rectX[i] + width / 5 && x < rectX[i] + width / 5 + 500 && y > rectY + i * 50 + height / 2 && y < rectY + 40 + i * 50 + height / 2;
  }
}


/*void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}*/
