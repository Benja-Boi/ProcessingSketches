
int resolution = 250;
int canvasSize = 1000;
PVector[][] flow = new PVector[resolution][resolution];
PVector offsets = new PVector(0.005,0.005);
float time = 0;
float speed = 0.005;
float cellSize = canvasSize / resolution;
color foregroundColor = color(255);
color backgroundColor = color(0);
int numParticles = 10000;
Particle[] particles = new Particle[numParticles];

void setup(){
  frameRate(40);
  size(1000, 1000);
  background(backgroundColor);
  fill(foregroundColor);
  stroke(foregroundColor);
  strokeWeight(1);
  
  for (int i = 0; i < numParticles; i++){
    particles[i] = new Particle();
  }
}

void draw(){
 
  getFlow();
  //background(backgroundColor); 
  //println(frameRate);
  //for (int x = 0; x < resolution; x++){
  //  for (int y = 0; y < resolution; y++){
  //    noStroke();
  //    rect(x * cellSize, y * cellSize, flow[x][y].x, flow[x][y].y);
  //    stroke(foregroundColor);
  //  }
  //}

  for (int i = 0; i < numParticles; i++){
    particles[i].follow();
    particles[i].update();
    particles[i].edges();    
    particles[i].show();
  }
  time += speed;
}

void getFlow(){
  for (int x = 0; x < resolution; x++){
    for (int y = 0; y < resolution; y++){
      calcFlow(x, y);
    }
  }
}

void calcFlow(int x, int y){
  float xoff = x * offsets.x;
  float yoff = y * offsets.y;
  float noise = noise(xoff, yoff, time);
  float vectorSize = noise(xoff + yoff, time) * cellSize;
  flow[x][y] = polarToVector(noise * 360 - 180, vectorSize);
}

PVector polarToVector(float angle, float vectorSize){
  float theta = (float) Math.toRadians(angle);
  return new PVector(vectorSize * cos(theta),vectorSize * sin(theta));
}
