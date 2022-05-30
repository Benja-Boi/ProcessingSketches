public class Particle{
  PVector position;
  PVector prevPosition;
  PVector velocity;
  PVector acc;
  float maxSpeed = 5;
  
  public Particle(){
    position = new PVector(random(canvasSize), random(canvasSize));
    velocity = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  public void update(){
    velocity.add(acc);
    velocity.limit(maxSpeed);
    prevPosition = position;
    position.add(velocity);
    acc.mult(0);
  }
  
  void follow(){
    int x = floor(position.x / cellSize) & resolution;
    int y = floor(position.y / cellSize) % resolution;
    if (x >= 0 && x < resolution && y >= 0 && y < resolution){
      applyForce(flow[x][y]);    
    }
    else{
      //print("Error: (" + x + "," + y + ")");
    }
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  public void edges(){
    if (position.x > canvasSize) position.x = 0;
    if (position.x < 0) position.x = canvasSize - 1;
    if (position.y > canvasSize) position.y = 0;
    if (position.y < 0) position.y = canvasSize - 1;
  }
  
  public void show(){
    stroke(foregroundColor, 2);
    strokeWeight(1);
    line(position .x, position.y, prevPosition.x, prevPosition.y);
  }
}
