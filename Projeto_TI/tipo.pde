
void carregartipo () {

  carregar = true;
}

void tipo() {
  if (!carregar) {
    carregartipo();
  }

  PFont font;
  font = createFont("Futura Bold font", 128);
  textFont(font);
  textSize(40);
  text("Tecnologias da Interface 2024", 30, 30);
}
