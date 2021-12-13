PImage itachi, kurapika;

ArrayList<pixels> dots;
ArrayList<PVector> targets1, targets2;

int scaler = 4; 
int threshold = 210;

boolean imageToggled = false;
color col1, col2;

void setup() {
  size(75, 75, P2D);  
  
  itachi = loadImage("itachi.png");
  kurapika = loadImage("kurapika.png");

  int w, h;
  if (itachi.width > kurapika.width) {
    w = itachi.width;
  } 
  else {
    w = kurapika.width;
  }
 
  if (itachi.height > kurapika.height) {
    h = itachi.height;
  }
  else {
    h = kurapika.height;
  }
  surface.setSize(w, h);
  
  itachi.loadPixels();
  kurapika.loadPixels();
  
  targets1 = new ArrayList<PVector>();
  targets2 = new ArrayList<PVector>();
  
  col1 = color(#0347FF);
  col2 = color(#FF0303);
  
  for (int x = 0; x < kurapika.width; x += scaler) {
    
    for (int y = 0; y < kurapika.height; y += scaler) {
      int loc = x + y * kurapika.width;

      if (brightness(kurapika.pixels[loc]) > threshold) {
        targets2.add(new PVector(x, y));
      }
    }
  }

  dots = new ArrayList<pixels>();

  for (int x = 0; x < itachi.width; x += scaler) {
   
    for (int y = 0; y < itachi.height; y += scaler) {
      int loc = x + y * itachi.width;
      
      
      if (brightness(itachi.pixels[loc]) > threshold) {
        int targetIndex = int(random(0, targets2.size()));
        targets1.add(new PVector(x, y));
        pixels dot = new pixels(x, y, col1, targets2.get(targetIndex));
        dots.add(dot);
      }
    }
  }
}

void draw() { 
  background(0);
  
  blendMode(ADD);
  
  boolean flipTargets = true;

  for (pixels dot : dots) {
    dot.run();
    
    if (!dot.ready) flipTargets = false;
  }
  
  if (flipTargets) {
   
    for (pixels dot : dots) {
      
      if (!imageToggled) {
        int targetIndex = int(random(0, targets1.size()));
        dot.targ = targets1.get(targetIndex);
        dot.col = col2;
      }
      else {
        int targetIndex = int(random(0, targets2.size()));
        dot.targ = targets2.get(targetIndex);
        dot.col = col1;
      }
    }
    imageToggled = !imageToggled;
  }
    
  surface.setTitle("" + frameRate);
}
