
int[] rectX = new int[5];
int rectY;
color rectHighlight;
color rectColor, baseColor;

void carregarescolha () {

  carregar = true;

  rectColor = color(255);
  rectHighlight = color(200);
  rectY = height / 2 - 40 / 2;


  for (int i = 0; i < 5; i++) {
    rectX[i] = rectX[i - 1] + 320 + 10;
  }
}

void escolha() {
  if (!carregar) {
    carregarescolha();
  }

  fill(0);
  textSize(50);
  text("Choose a song", width/3, 350);

  update(mouseX, mouseY);

  for (int i = 0; i < 5; i++) {
    if (rectOver[i]) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }
    stroke(10);
    rect(rectX[i] + width/3, rectY + i * 50 + height/2, 320, 40);
  }
}

void update(int x, int y) {
  for (int i = 0; i < 5; i++) {
    rectOver[i] = mouseX > rectX[i] && mouseX < rectX[i] + 320 && mouseY > rectY && mouseY < rectY + 40;
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

void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}
