
void setupBotoes() {
  playButton = new Button(width / 2 - 50, height - 100, 100, 50, "Play");
  stopButton = new Button(width / 2 + 50, height - 100, 100, 50, "Stop");
}

void desenharBotoes() {
  playButton.display();
  stopButton.display();
}

class Button {
  float x, y;
  float w, h;
  String label;

  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }

  boolean isOver() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }

  void display() {
    fill(200);
    stroke(0);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h / 2);
  }
}
