class Pipe{
 
  boolean fresh;
  float x;
  int yup;
  int ydown;
  float xspeed;
  PImage pipeDown;
  PImage pipe;
  
  public Pipe(float x, int yup, int ydown, PImage pipeDown, PImage pipe){
    this.x = x;
    this.yup = yup;
    this.ydown = ydown;
    this.pipeDown = pipeDown;
    this.pipe = pipe;
    this.xspeed = 0;
    this.fresh = true;
  }
  
  public void show(){
   image(this.pipeDown, this.x, this.yup); 
   image(this.pipe, this.x, this.ydown); 
  }
  
  public void update(){
    this.show();
    if(started) this.xspeed = -2.5;
    this.x += this.xspeed;
    
    //score system
    
    if(this.x<160 && this.fresh){
      score++;
      this.fresh = false;
    }
    
    //renewing the pipes
    
    if(this.x<-55.0){
      this.x = 1200.0;
      this.yup = (int)random(-260, -32);
      this.ydown = this.yup + gap;
      this.fresh = true;
    }
  }
  
  public int getYUp(){
   return this.yup; 
  }
  
  public int getYDown(){
   return this.ydown; 
  }
  
  public float getX(){
   return this.x; 
  }
  
}
