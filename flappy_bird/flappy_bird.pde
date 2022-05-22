//Global variables
PImage midFlap, downFlap, upFlap, background, start, lose, pipe, pipeDown, ground;
PFont f;
float[] floor;
int score, gap;
Pipe[] p = new Pipe[5];
Bird b;
boolean jumpCheck, started, go;

void setup(){
  size(1024, 576);
  
  //loading images, variables and text
  
  gap = 426;                                      //control the difficulty by increasing/decreasing the gap between the pipes
  midFlap = loadImage("midFlap.png");
  upFlap = loadImage("upFlap.png");
  downFlap = loadImage("downFlap.png");
  background = loadImage("background1.png");
  lose = loadImage("lose.png");
  start = loadImage("start.png");
  pipe = loadImage("pipe.png");
  pipeDown = loadImage("pipeDown.png");
  ground = loadImage("ground.png");
  f = createFont("font.TTF", 70, true);
  textFont(f, 70);
  score = 0;
  jumpCheck = false;
  started = false;
  go = true;
  
  //making the floor
  
  floor = new float[6];
  floor[0] = -336;
  for(int i=1; i<6; i++)
     floor[i] = floor[i-1] + 336;
     
  //making the pipes
  
  for(int i=0; i<5; i++){
     int rand = (int)random(-260, -32);
     p[i] = new Pipe(1200 + 250*i, rand, rand+gap, pipeDown, pipe);
  }
  
  //making the bird
  
  b = new Bird(midFlap, upFlap, downFlap);

}

void draw(){
  b.setDead(b.checkDead(p));
  if(!b.isDead()){
    loadBG();
    b.update();
  }
  else b.update();
}

void keyPressed(){
 if(key==' ' && !jumpCheck){
   b.jump();
   jumpCheck = true;
   started = true;
 }
 if((key==' ' && b.isDead()) || key == 'r') setup();
}

void keyReleased(){
 if(key==' ') jumpCheck = false; 
}

void loadBG(){
 background(background); 
 for(int i=0; i<5; i++){
   p[i].update();
 }
 for(int i=0;i<6;i++){
    if(i==0){
      image(ground, floor[i], 467); 
      floor[i] -= 2.5;
      if(floor[i]<-350) floor[i] = (int)floor[5] + 330;
    }
    else{
      image(ground, floor[i], 467); 
      floor[i] -= 2.5;
      if(floor[i]<-350) floor[i] = (int)floor[i-1] + 330;
    }
 }
 if(!started) image(start, 400, 120); 
 else if(go && p[0].getX()>950) text("GO!", 460, 100);
      else{
        text(score, 484, 100);
        go = false;
      }
}
