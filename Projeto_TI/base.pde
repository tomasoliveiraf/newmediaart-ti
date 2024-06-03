
PVector[] linhas;
float[] lineYPositions;

int octaves = 1;
float distortion = 5.0;
float lacunarity = 3.25;
float scale = 10.0;

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
      fft.logAverages(22, 1);
      fft.window(FFT.HAMMING);
    }
  }
}

void desenharLinhas() {
  if (player != null && fft != null && linhas != null) {
    fft.forward(player.mix);

    float espacamento = height / (float) linhas.length + 20;

    for (int i = 0; i < linhas.length; i++) {
      float amplitude = fft.getBand(i);
      float largura = map(amplitude, 0, 256, 0, width);

      float distorcao = 5 * amplitude;
      largura += distorcao;

      strokeWeight(max(amplitude / 10, lineThickness));
      stroke(0);
      line(0, i * espacamento + 20, largura * width, i * espacamento + 20);
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

void keyPressed() {
  if (keyCode == LEFT) {
    lineThickness = max(1, lineThickness - 1);
  } else if (keyCode == RIGHT) {
    lineThickness = min(25, lineThickness + 1);
  }
}
