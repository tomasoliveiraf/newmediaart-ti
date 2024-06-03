
import processing.serial.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int nivel = 0;

//variaveis dos valores do arduino
/*int senProx, potenci, joyX, joyY;
String touch;*/


boolean carregar = false;
boolean[] rectOver = new boolean[5];
boolean isPlaying = false;

File selectFile;
Minim minim;
AudioPlayer[] songs = new AudioPlayer[5];
FFT fft;

Serial myPort;

/*
Button playButton;
 Button stopButton;
 */

AudioPlayer player;
int currentSong = -1;

float lineThickness = 1;


void setup() {
  size(800, 800);

  //esgalhar porta
  //ines
  
  //myPort.bufferUntil(10);

  //myPort = new Serial(this, "/dev/cu.usbserial-14110", 9600);
  //myPort = new Serial(this, "COM7", 9600);

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
  
    //receber e fazer split dos dados do arduino
/*
  if (myPort.available() > 0) {
    String value = myPort.readStringUntil('\n');

    //ordem dos valores "sensorProximidade, Touch, Potenciometro, xdoJoystick, ydoJoystick"

    if (value != null) {
      String[] pieces = value.split(",");
      //Sensor de Proximidade
      int senProx = Integer.parseInt(pieces[0].trim()); //está a tornar uma parte de uma string (pieces) num int
      //Touch
      String touch = pieces[1];
      //potenciometro
      int potenci = Integer.parseInt(pieces[2].trim());
      //x do joystick
      int joyX = Integer.parseInt(pieces[3].trim());
      //x do joystick
      int joyY = Integer.parseInt(pieces[4].trim());

      //visualizar valores na consola
      println("sensor " + senProx);
      println("touch " + touch);
      println("potenciometro " + potenci);
      println("joyX " + joyX);
      println("joyY " + joyY);
      
      if(nivel == 0 && senProx <= 50){
        nivel = 1;
      }
    }
  }
 */ 
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
