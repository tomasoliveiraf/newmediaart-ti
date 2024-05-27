
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
      float espacamento = (width * 2 )/ (float) player.bufferSize();
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
    float espacamento = (float) height / linhas.length;
    for (int i = 0; i < linhas.length; i++) {
      float amplitude = fft.getBand(i);
      float noiseValue = noise(i * lacunarity * 0.1, frameCount * 0.01 * scale);
      float distorcao = distortion * noiseValue * 2;
      float xEnd = map(amplitude + distorcao, 0, 256 + distortion, 0, width);
      strokeWeight(max(amplitude / 10, 1));
      stroke(0);
      line(0, i * espacamento, xEnd * 20, i * espacamento);
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
