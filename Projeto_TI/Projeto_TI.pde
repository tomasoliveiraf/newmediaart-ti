
import processing.serial.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int nivel = 0;

boolean carregar = false;
boolean[] rectOver = new boolean[5];
boolean isPlaying = false;

File selectFile;
Minim minim;
AudioPlayer[] songs = new AudioPlayer[5];
FFT fft;
/*
Button playButton;
Button stopButton;
*/
AudioPlayer player;
int currentSong = -1;

float lineThickness = 1;


void setup() {
  size(800, 800);

  minim = new Minim(this);
/*
  playButton = new Button(width / 2 - 50, height - 100, 100, 50, "Play");
  stopButton = new Button(width / 2 + 50, height - 100, 100, 50, "Stop");
*/
  for (int i = 0; i < songNames.length; i++) {
    songs[i] = minim.loadFile(songNames[i], 1024);

    songs[0] = minim.loadFile("Angerfist - Street Fighter.mp3");
    songs[1] = minim.loadFile("Guita Pimpolho - Baila Morena.mp3");
    songs[2] = minim.loadFile("carolina deslandes - paz drill remix.mp3");
    songs[3] = minim.loadFile("MARIACHI FUNK.mp3");
    songs[4] = minim.loadFile("Xutos e Pontapés - Ai Se Ele Cai.mp3");
  }
}

void draw() {

  background(255);

  if (nivel == 0) {
    menu();
  } else if (nivel == 1) {
    escolha();
  } else if (nivel == 2) {
    base();
    //desenharBotoes();
  } else if (nivel == 3) {
    tipo();
  }
}

void mousePressed() {
  for (int i = 0; i < 5; i++) {
    if (rectOver[i]) {
      selectFile = new File(dataPath(songNames[i]));
      if (selectFile.exists()) {
        currentSong = i;
        carregarbase();
        nivel = 2;
      }

      break;
    }
  }
}


void playMusic() {
  if (songs != null && !isPlaying) {
    songs[currentSong].play();
    isPlaying = true;
  }
}

void stopMusic() {
  if (songs != null && songs[currentSong].isPlaying()) {
    songs[currentSong].pause();
    isPlaying = false;
  }
}

/*
void processSelectedFile(File selection) {
 if (selection == null) {
 println("Nenhum arquivo selecionado.");
 } else {
 selectFile = selection;
 player = minim.loadFile(selectFile.getAbsolutePath(), 1024);
 fft = new FFT(player.bufferSize(), player.sampleRate());
 carregarbase();
 }
 }*/
