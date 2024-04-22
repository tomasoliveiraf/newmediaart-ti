
void carregartipo () {

  carregar = true;
}

void tipo() {
  if (!carregar) {
    carregartipo();
  }
}
