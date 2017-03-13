Frog frog;
Frog[] lifeFrogs = {
  new Frog (10, 550), new Frog(40, 550), new Frog(70, 550)
  };
  Car [] cars;


int lives = 3;
int score = 0;

color BLACK = color(0, 0, 0);

float FROG_LEFT = 175, FROG_TOP= 505;


//this method runs once, when you load the sketch
void setup()
{
  size(400, 600);
  frameRate(60);

  frog = new Frog(FROG_LEFT, FROG_TOP);

  cars = new Car[16];

  for (int i = 0; i < 4; i++) {
    cars[i] = new Car(300-i*100, 415, 1, 1);
  }

  for (int i = 4; i < 8; i++) {
    cars[i] = new Car(300-(i-4)*100, 360, 1, -1);
  }

  for (int i = 8; i < 12; i++) {
    cars[i] = new Car(300-(i-8)*100, 265, 2, 1);
  }

  for (int i = 12; i < 16; i++) {
    cars[i] = new Car(300-(i-12)*100, 215, 2, -1);
  }
}

//this method calls itself after waiting however long your frame rate is
void draw()
{
  //draw the environment
  drawBackGround();
  
  for (int i = 0; i < lives; i++)
    lifeFrogs[i].draw();

  frog.draw();
  
  for (int i = 0; i < 16; i++) {
    cars[i].move();
    cars[i].draw();
    if (frog.isTouching(cars[i])) 
      die();
  }

  fill(BLACK);
  text("Lives: ", 15, 545);
  text("Score: ", 350, 550);
  text(score, 360, 570);
  
  if (lives < 0) {
    gameOver();
  }
  
  if(frog.top < 50)
    win();
}

void drawBackGround() {
  //grass
  background(color(0, 255, 0));

  //pond  
  noStroke();
  fill(color(0, 0, 255));
  ellipse(0, -50, 400, 50);

  //roads
  rectMode(CORNERS);
  fill(color(150, 150, 150));  
  rect(0, 350, 400, 450);
  rect(0, 200, 400, 300);

  fill(color(200, 200, 0));
  for (int x = 0; x < 400; x+=40) {
    rect(x, 399, x+20, 401);
    rect(x, 249, x+20, 251);
  }
}

void keyPressed()
{
  if (keyCode == 37 && frog.left > 0) { //left
    frog.moveLeft();
  }  
  else if (keyCode == 39 && frog.right < 400) { //right
    frog.moveRight();
  }  
  else if (keyCode == 38) { //up
    frog.moveUp();
  }  
  else if (keyCode == 40 && frog.bottom < 590) { //down
    frog.moveDown();
  }
}

void die() {
  lives--;
  frog.move(FROG_LEFT, FROG_TOP);
  frog.draw();
}

void win() {
  score += 100; 
  frog.move(FROG_LEFT, FROG_TOP);
  frog.draw();
}

void gameOver() {
  
  fill(0,255,0);
  rect(0,0,400,800);
  
  fill(BLACK);
  textSize(30);
  text("Game Over", 130, 270);
  text("Score: " + score, 130, 300);
  
}

class Shape
{
  float left, right, top, bottom, width, height;
  color outline, fill2;

  boolean isTouching(Shape other)
  {
    return (left < other.right) && (right > other.left) && (top < other.bottom) && (bottom > other.top);
  }
}

class Frog extends Shape
{
  Frog(float left, float top) {
    this.left = left;
    this.top = top;

    outline = color(0);
    fill2 = color(20, 220, 20);

    width = 25;
    height = 40;
    right = left+width;
    bottom = top+height;
  }

  void moveLeft() {
    left-=width;
    right-=width;
  }
  void moveRight() {
    left+=width;
    right+=width;
  }
  void moveUp() {
    top-=50;
    bottom-=50;
  }
  void moveDown() {
    top+=50;
    bottom+=50;
  }

  void move(float left, float top) {
    this.left = left;
    this.top = top;
    right = left + width;
    bottom = top + height;
  }

  void draw() {
    stroke(outline);
    fill(fill2);
    ellipseMode(CORNERS);
    ellipse(left, top, right, bottom);
  }
}

class Car extends Shape
{
  float speed, direction;

  Car(float left, float top, float speed, float direction) {
    outline = BLACK;
    fill2 = color(random(0, 255), random(0, 255), random(0, 255));

    this.left = left;
    this.top = top;
    this.width = 35;
    this.height = 20;
    this.speed = speed;
    this.direction = direction;

    right = left + width;
    bottom = top + height;
  }

  void move() {
    left += speed*direction;
    right += speed*direction;

    if (right < 0) {
      left = 400;
      right = 400 + width;
    }
    if (left > 400) {
      right=0;
      left=-width;
    }
  }

  void draw() {
    rectMode(CORNERS);
    stroke(outline);
    fill(fill2);
    rect(left, top, right, bottom);
  }
}
