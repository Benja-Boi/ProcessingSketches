float frameRate = 1;
float breathingRate = 3;
float waveFreq = 5;
float innerFreq = 35;
float circleSize = 200;
float donutWidth = 80;
float diameter = -1.7;
float trailDist = .05;
float breathingPad = 1;
int numCircles = 10000;

void setup(){
  size(1000, 1000);
  noStroke();
}

void draw(){
  noStroke();
  background(0f, 0f, 0f, 0f);
  float x0 = width / 2;
  float y0 = height / 2;
  float theta = calcTheta();
  float currCircleSize  = circleSize * map(sin(theta), -1, 1, 1 - breathingPad,  1 + breathingPad);
  float currInnerFreq = innerFreq * map(sin(theta),-1, 1, 1 - breathingPad, 1 + breathingPad);
  for (int i = 0; i < numCircles; i++){
      float thetaI = calcThetaI(i);
      float x = (currCircleSize + donutWidth * sin(currInnerFreq * thetaI)) * cos(thetaI) + x0;
      float y = (currCircleSize + donutWidth * sin(currInnerFreq * thetaI)) * sin(thetaI) + y0;
      float fill = map(sin(innerFreq * thetaI), - 1, 1, 0, 255);
      fill(fill);
      circle(x, y, diameter);
  }
  float fill = map(sin(theta), - 1, 1, 0, 255);
  fill(2 * fill / 3 , 100);
  //circle(x0, y0, currCircleSize / 4);
}

float calcTheta(){
  return (radians(frameRate * frameCount)) % (2 * PI);
}

float calcThetaI(int i){
  return (radians(frameRate * frameCount - i * trailDist)) % (2 * PI);
}
