
PVector[] linhas;
float[] lineYPositions;

void carregarbase() {
  if (selectFile != null) {
    player = minim.loadFile(selectFile.getAbsolutePath(), 1024);

    if (player != null) {
      linhas = new PVector[player.bufferSize()];
      lineYPositions = new float[player.bufferSize()];

      float espacamento = width / (float) player.bufferSize();

      for (int i = 0; i < player.bufferSize(); i++) {
        linhas[i] = new PVector(i * espacamento, height / 2);
        lineYPositions[i] = height / 2;
      }

      fft = new FFT(player.bufferSize(), player.sampleRate());
    }
  }
}

void desenharLinhas() {
  
  if (player != null && fft != null && linhas != null) {
    fft.forward(player.mix);

    float espacamento = height / (float) linhas.length + 10;
    
    for (int i = 0; i < linhas.length; i++) {
      float amplitude = fft.getBand(i);
      float largura = map(amplitude, 0, 256, width, 0);
      
      strokeWeight(max(amplitude / 10, 1)); 
      
      stroke(0);
      line(0, i * espacamento + 10, width + largura, i * espacamento + 10);
      
      lineYPositions[i] = i * espacamento;
    }
    
    if (!player.isPlaying()) {
      player.rewind();
      player.play();
    }
  } 
}

void base() {
  desenharLinhas();
}
