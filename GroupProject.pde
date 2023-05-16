import processing.sound.*;
PImage img;
SoundFile song;
String currentScreen = "menu";
int playerXCor = 600;
int playerYCor = 590;
int playerWidth = 55;
int playerHeight = 55;
int difficulty = 5;
int limit = 10;
float score = 0;
Brick[] bricks;
boolean isCollided = false;


void initBricks(int xMin, int xMax, int yMin, int yMax, int num){
  bricks = new Brick[num];
 
  for(int i = 0; i < bricks.length; i++){
     int x = (int)random(xMin, xMax);
     int y = (int)random(yMin, yMax);
     bricks[i] = new Brick(x, y, 30, 15);
  }
}
// In a program that has the setup() function, the size()/fullscreen() function must be the first line of code inside setup(), and the setup() function must appear in the code tab with the same name as your sketch folder.
void setup(){
  //fullScreen();
  size(800,700);
  //rameRate(60);
 img = loadImage("bg.jpg");
 initBricks(-100, width + 20, -250, -80, difficulty); 
 PFont font;
 font = loadFont("Papyrus-Regular-48.vlw");
 textFont(font);
 song = new SoundFile(this, "song.mp3");
 song.loop();
 song.amp(0.05);
}

void draw(){
  
 background(0);

   if(currentScreen =="menu"){
   fill(240,50,50);
   textSize(50);
   textAlign(CENTER);
   text("Brick    Escape",400,250);
   textSize(30);
   textAlign(CENTER);
   text("Press any key to start", 400, 320);
   text("Use mouse to move left or right & up or down", 400, 380);
   textSize(20);
   textAlign(CENTER);
   text("By:  Utsav Baxi    Minjing Liang    Carlos Lopez    Phi Nguyen", 400, 600);
 }
 else if(currentScreen == "gameplay"){
   
   image(img,0,0);
  
   drawPlayer();
  if(!isCollided){
    moveBricks();
    if(score > limit && score < limit + 2){
      initBricks(-100, width + 20, -260, -80, difficulty); difficulty += 10; limit += 20;
    }
  }
  else
   currentScreen = "gameover";
 }
 else{
   fill(240,50,50);
   text("Your Score: "+(int)score,120, 100);
   textSize(50);
   textAlign(CENTER);
   text("Game    Over", 400,300);
   textSize(30);
   textAlign(CENTER);
   text("Press any key to retry", 400, 380);
   }
 }

void moveBricks(){
      for(int i = 0; i < bricks.length; i++){
        if(bricks[i].yCor > height){
           bricks[i].yCor = -10;
        }
        bricks[i].display();
        bricks[i].drop(random(1, 10));
      
        boolean conditionXLeft = bricks[i].xCor + bricks[i].w >= playerXCor;
        boolean conditionXRight = bricks[i].xCor + bricks[i].w <= playerXCor + playerWidth + 4;
        boolean conditionUp =  bricks[i].yCor >= playerYCor;
        boolean conditionDown = bricks[i].yCor + bricks[i].h <= playerYCor + playerHeight;
      
        if(conditionXLeft && conditionXRight && conditionUp && conditionDown){
             isCollided = true;
        }
  
      } 
    score += 0.1;

    fill(230,110,120);
    textSize(30);
    text("Score: "+(int)score, 70, 40);
    
}

void drawPlayer(){
  noStroke();
  //stroke(204, 132, 0);
  strokeWeight(4);
  fill(222, 55, 0);
  rect(playerXCor, playerYCor, playerWidth, playerHeight, 7);
}

void mouseDragged(){
  if(mouseX >= 0 && mouseX <= width - playerWidth + 1){
    playerXCor = mouseX;
  }
  if(mouseY >= 590 && mouseY <= height - playerHeight){
    playerYCor = mouseY;
  }
}


void keyPressed(){
if(currentScreen == "menu"){//if the current showing screen is menu, then switch to gameplay
currentScreen = "gameplay";
}
else if(currentScreen == "gameover"){
currentScreen = "gameplay";
isCollided = false;
score=0;
playerXCor = 600;
playerYCor = 590;
playerWidth = 55;
playerHeight = 55; 
difficulty = 10;
limit = 10;
setup();
}
}
