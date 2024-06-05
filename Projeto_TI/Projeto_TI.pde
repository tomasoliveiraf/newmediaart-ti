import processing.serial.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

File selectFile;
Minim minim;
AudioPlayer[] songs = new AudioPlayer[5];
FFT fft;

Serial myPort;

int nivel = 0;

//variaveis dos valores do arduino
/*int senProx, potenci, joyX, joyY;
 String touch;*/

boolean carregar = false;
boolean[] rectOver = new boolean[5];
boolean isPlaying = false;


AudioPlayer player;
int currentSong = -1;

float lineThickness = 1;

//joystick
PVector joifinal;
int lastJoyX = -1;
int lastJoyY = -1;

void setup() {
  size(800, 800);

  //esgalhar porta
  //ines
  myPort = new Serial(this, "/dev/cu.usbserial-14210", 9600);
  myPort.bufferUntil('\n');

  //myPort = new Serial(this, "COM7", 9600);

  minim = new Minim(this);

  for (int i = 0; i < songNames.length; i++) {
    songs[i] = minim.loadFile(songNames[i], 1024);

    songs[0] = minim.loadFile("Angerfist - Street Fighter.mp3");
    songs[1] = minim.loadFile("Guita Pimpolho - Baila Morena.mp3");
    songs[2] = minim.loadFile("carolina deslandes - paz drill remix.mp3");
    songs[3] = minim.loadFile("MARIACHI FUNK.mp3");
    songs[4] = minim.loadFile("Xutos e Pontapés - Ai Se Ele Cai.mp3");
  }
  
    joifinal = new PVector(width/2, height/2);
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
  if (myPort.available() > 0) {
    String value = myPort.readStringUntil('\n');
    
    if (value != null) {
      String[] pieces = value.split(",");
      
      if (pieces.length == 5) {
        
        
        // Sensor de Proximidade
        int senProx = Integer.parseInt(pieces[0].trim());
        
        // Touch
        String touch = pieces[1].trim();
        
        // Potenciômetro
        int potenci = Integer.parseInt(pieces[2].trim());
        lineThickness = map(potenci, 0, 255, 1, 25);
        
        // X e Y do joystick
        int joyX = Integer.parseInt(pieces[3].trim());
        int joyY = Integer.parseInt(pieces[4].trim());


        // Só atualizar se os valores do joystick tiverem mudado
        if (joyX != lastJoyX || joyY != lastJoyY) {
          lastJoyX = joyX;
          lastJoyY = joyY;

          // Mapeamento dos valores do joystick
          float mappedJoyX = map(joyX, 0, 100, -5, 5);
          float mappedJoyY = map(joyY, 0, 100, -5, 5);

          joifinal.add(mappedJoyX, mappedJoyY);

          // Garantir que a elipse não saia dos limites da tela
          joifinal.x = constrain(joifinal.x, 0, width);
          joifinal.y = constrain(joifinal.y, 0, height);
        }

        // Visualizar valores na consola
        //println("sensor :" + senProx + ",touch :" + touch + ",potenciometro :" + potenci + ",joyX :" + joyX + ",joyY :" + joyY);
        //println(senProx + "," + touch + "," + potenci + "," + joyX + "," + joyY);
        println("sensor " + senProx);
        println("touch " + touch);
        println("potenciometro " + potenci);
        println("joyX " + joyX);
        println("joyY " + joyY);

        if (nivel == 0 && senProx <= 50) {
          nivel = 1;
        }
      }
    }
  }

  //desenhar "rato"
  fill(0);
  ellipse(joifinal.x, joifinal.y, 20, 20);
}



/*void mousePressed() {
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
 }*/


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
