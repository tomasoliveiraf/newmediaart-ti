
Serial myPort;

void carregarmenuprincipal() {
  carregar = true;


  String[] portNames = Serial.list();
  if (portNames.length > 0) {
    String portName = portNames[0];
    myPort = new Serial(this, "/dev/cu.usbserial-14110", 9600);
    println("Conectado à porta serial: " + "COM7");
  } else {
    println("Nenhuma porta serial disponível.");
  }
}

void menu() {
  if (!carregar) {
    carregarmenuprincipal();
  }
  
  fill(0);
  textSize(50);
  text("ApitoMaster3000", width/3 - 30, height/2);

  // Verificar a distância recebida do Arduino
 /* if (myPort != null && myPort.available() > 0) {
    String distanceStr = myPort.readStringUntil('\n');
    if (distanceStr != null) {
      int distance = int(trim(distanceStr));

      // Mudar para o nível de escolha de música se a distância for menor que 50 cm
      if (distance < 50) {*/
      if(mousePressed == true){
        nivel = 1;
        println("Distância menor que 50 cm. Nível mudado para escolha de música.");
      }
    }
  //}
//}
