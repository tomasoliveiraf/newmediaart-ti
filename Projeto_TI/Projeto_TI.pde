import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int nivel = 0;

boolean carregar = false;
boolean rectOver = false;
boolean circleOver = false;
boolean isPlaying = false;

File selectFile;
Minim minim;
AudioPlayer player;
FFT fft;
Button playButton;
Button stopButton;

void setup() {
  size(800, 800);

  minim = new Minim(this);

  playButton = new Button(width / 2 - 50, height - 100, 100, 50, "Play");
  stopButton = new Button(width / 2 + 50, height - 100, 100, 50, "Stop");
}

void draw() {

  background(255);

  if (nivel == 0) {
    menu();
  } else if (nivel == 1) {
    base();
    desenharBotoes();
  } else if (nivel == 2) {
    tipo();
  }
}

void mousePressed() {
  if (rectOver) {
    if (selectFile == null) {
      selectInput("Select a file to process:", "processSelectedFile");
    }
  }

  if (circleOver) {
    nivel = 1;
  }

  if (player != null) {
    if (playButton.isOver()) {
      playMusic();
      println("Botão Play pressionado.");
    }

    if (stopButton.isOver()) {
      stopMusic();
      println("Botão Stop pressionado.");
    }
  } else {
    println("Arquivo de som não carregado.");
  }
}

void processSelectedFile(File selection) {
  if (selection == null) {
    println("Nenhum arquivo selecionado.");
  } else {
    selectFile = selection;
    player = minim.loadFile(selectFile.getAbsolutePath(), 1024);
    fft = new FFT(player.bufferSize(), player.sampleRate());
    carregarbase();
  }
}

void playMusic() {
  if (player != null && !isPlaying) {
    player.play();
    isPlaying = true;
    println("Música a tocar.");
  }
}

void stopMusic() {
  if (player != null && player.isPlaying()) {
    player.pause();
    isPlaying = false;
    println("Música parada.");
  }
}
