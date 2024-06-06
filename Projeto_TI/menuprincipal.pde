void carregarmenuprincipal() {
  carregar = true;
}


void menu() {
  if (!carregar) {
    carregarmenuprincipal();
  }

  image(apito, width/2-150, height/2-100, 300, 200);
}
