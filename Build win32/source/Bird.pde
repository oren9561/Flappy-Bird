class Bird{
 
  float flap;
  int i;
  float angle;
  PVector v;
  PVector p;
  PImage img;
  PImage[] images;
  boolean dead;
  boolean a;
  
  
  public Bird(PImage midFlap, PImage upFlap, PImage downFlap){
    this.a = true;
    this.dead = false;
    this.angle = 0;
    this.flap = 0;
    this.i = 3;
    this.v = new PVector(0, 0);
    this.p = new PVector(200, 230);
    this.images = new PImage[4]; 
    images[0] = upFlap;
    images[1] = midFlap;
    images[2] = downFlap;
    images[3] = midFlap;
    this.img = images[i];
  }
  
  public void show(){
    pushMatrix();
    this.move();
    image(this.img, 0, 0);
    popMatrix();  
    this.flap();
  }
  
  public void showStart(){
    image(this.img, this.p.x, this.p.y);
    this.flap();
  }
  
  public void flap(){
    float mil = millis()/100;
    if(mil - this.flap > 0.5){
      this.i++;
      if(this.i==4) this.i = 0;
      this.img = this.images[this.i];
      this.flap = mil;
    }
  }
  
  public boolean checkDead(Pipe[] p){
   float x = this.p.x + this.img.width/2;
   float y = this.p.y;
   if(y+this.img.height/3 - 3>=456 || y+this.img.height/3 - 3<=-200) return true;
   for(int i=0;i<5;i++){
     if((x>=p[i].getX() && x<=(p[i].getX()+pipe.width)) && !(y>(p[i].getYUp()+pipe.height) && y<p[i].getYDown()))
       return true;
     y += this.img.height/3 - 3;
     if((x>=p[i].getX() && x<=(p[i].getX()+pipe.width)) && !(y>(p[i].getYUp()+pipe.height) && y<p[i].getYDown()))
       return true;
   }
   return false;
  }
  
  public void setDead(boolean a){
   this.dead = a; 
  }
  
  public void update(){
   if(!dead){
     if(started) this.show();
     else this.showStart();
   }
   else{
     image(lose, 400, 220);
     textFont(f, 40);
     text("Press Space To Go Again", 250, 320);
   }
  }
  
  public boolean isDead(){
   return this.dead; 
  }
  
  public void jump(){ // sets the velocity of the bird to be positive (as if it jumps forcefully all of a sudden)
   this.v.x = 13;
  }
  
  public void move(){ // moves up and down accordingly to the acceleration and speed of the bird (v.y = acceleration, v.x = velocity)
    if(!(this.v.x == 0)){
      if(this.v.x>0){ // happens only when the bird jumps
          this.p.y -= this.v.x;
          this.v.x = this.v.x/1.2;
          this.rotateUp();
          if(this.v.x <=0.5)
            this.v.x = -3;
      }
      else{ // happens only when the bird falls (doesn't jump) 
        this.p.y -= this.v.x;
        this.rotateDown();
        if(this.v.x > -7)
          this.v.x -= 0.4;
      }
    }
  }
  
  public void rotateUp(){
    if(!this.a){
    if(this.angle<=0){
      this.angle = 0;
      translate(this.p.x, this.p.y);
    }
    else{
      if(this.angle<=15){
        this.angle = 15;
        translate(this.p.x-2, this.p.y+3);
      } 
      else{
          if(this.angle<=30){
            this.angle = 30;
            translate(this.p.x-3, this.p.y+8); 
          }
          else {
            this.angle = 45; 
            translate(this.p.x-6, this.p.y+13);
          }
      }
    }
    this.a = true;
    }
    else{
    switch((int)this.angle){
     case 0: this.angle = 15;  translate(this.p.x-2, this.p.y+3);   break;
     case 15: this.angle = 30; translate(this.p.x-3, this.p.y+8);   break;
     case 30: this.angle = 45; translate(this.p.x-6, this.p.y+13);   break;
     case 45: translate(this.p.x-6, this.p.y+13); break;
    }
    }
    rotate(radians(-this.angle));
  }
  
  public void rotateDown(){
    this.a = false;
    switch((int)this.angle/10){
     case 0: translate(this.p.x, this.p.y);          break;
     case 1: translate(this.p.x-1, this.p.y+1);      break;
     case 2: translate(this.p.x-2, this.p.y+4);      break;
     case 3: translate(this.p.x-3, this.p.y+8);      break;
     case 4: translate(this.p.x-4, this.p.y+12);     break;
     case -1: translate(this.p.x, this.p.y-2);       break;
     case -2: translate(this.p.x+3, this.p.y-4);     break;
     case -3: translate(this.p.x+6, this.p.y-6);     break;
     case -4: translate(this.p.x+9, this.p.y-8);     break;
     case -5: translate(this.p.x+13, this.p.y-10);   break;
     case -6: translate(this.p.x+18, this.p.y-10);   break;
     case -7: translate(this.p.x+21, this.p.y-10);   break;
     case -8: translate(this.p.x+24, this.p.y-8);    break;
     case -9: translate(this.p.x+28, this.p.y-7);    break;
    }
    if(this.angle>=0) this.angle -= 2.2;
    else
      if(this.angle>-90) this.angle -= 10;
    rotate(radians(-this.angle));
  }
  
  
  
}
