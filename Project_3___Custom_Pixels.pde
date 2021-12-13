class pixels {

  PVector post, targ;
  color col;
  float speed;
  float pixelSize;
  boolean ready;
  
  pixels(float x, float y, color _col, PVector _targ) {
   
    post = new PVector(x, y);
    col = _col;
    targ = _targ;
    speed = 0.02;
    pixelSize = 10;
    ready = false;
  }
  
  void update() {
   
    post.lerp(targ, speed);
    ready = post.dist(targ) < 5;
  }
  
  void draw() {
    
    stroke(col);
    strokeWeight(pixelSize);
    point(post.x, post.y);
  }
  
  void run() {
    
    update();
    draw();
  }

}
