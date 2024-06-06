
void carregartipo () {

  carregar = true;
}

void tipo() {
  if (!carregar) {
    carregartipo();
  }

  PFont font;
  font = createFont("Retro Gaming", 128);
  textFont(font);
  textSize(40);
  text("ApitoMaster3000", 30, 30);
}
