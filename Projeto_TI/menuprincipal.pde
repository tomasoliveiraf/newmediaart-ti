void carregarmenuprincipal() {
  carregar = true;
  
}


void menu() {
  if (!carregar) {
    carregarmenuprincipal();
  }
  
  fill(0);
  textSize(50);
  text("ApitoMaster3000", width/3 - 30, height/2);

}
