
PVector[] linhas;
float[] lineYPositions;

void carregarbase() {
  if (selectFile != null) {
    player = minim.loadFile(selectFile.getAbsolutePath(), 1024);
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

void desenharLinhas() {
  if (player != null) {
    fft.forward(player.mix);

    for (int i = 0; i < linhas.length; i++) {
      float amplitude = fft.getBand(i) * 2;

      
      float y2 = constrain(height / 2 - amplitude, 0, height - 200);

      strokeWeight(amplitude/2);
      stroke(0);
      line(linhas[i].x, linhas[i].y, linhas[i].x, y2);

      
      lineYPositions[i] = y2;
    }
  }
}

void base() {
  desenharLinhas();
}
