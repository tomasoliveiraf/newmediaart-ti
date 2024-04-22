
void carregarmenuprincipal () {

  carregar = true;

  rectColor = color(255);
  rectHighlight = color(200);
  rectX = width/3;
  rectY = height/2 ;
  circleX = width - 100;
  circleY = height - 40;
}

int rectX, rectY;
int circleX, circleY;
int circleSize = 40;
color rectHighlight;
color rectColor, baseColor;


void menu() {
  if (!carregar) {
    carregarmenuprincipal();
  }

  fill(0);
  textSize(50);
  text("Choose a song", width/3, 350);

  update(mouseX, mouseY);

  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(10);
  rect(rectX, rectY, 320, 40);

  if (circleOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
}

void update(int x, int y) {

  if ( overRect(rectX, rectY, 320, 40) ) {
    rectOver = true;
    circleOver = false;
  } else if ( overCircle (circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
  }
}

boolean overRect(int x, int y, int width, int height) {

  if (mouseX >= x && mouseX <= x+width &&
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}
