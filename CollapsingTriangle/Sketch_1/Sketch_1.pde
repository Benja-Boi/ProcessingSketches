float xBase, yBase, sideLen, padding;
float speed = 0.5;
float cutoff = 0.02;
boolean dir = randomDir();
PVector[] triPts = new PVector[3];
PVector[] currTriPts = new PVector[3];
PVector lastPt = new PVector();
int state = 0;
final float hRatio = sqrt(3) / 2;

void setup(){
  size(900, 900);
  background(0);
  frameRate(120);
  initStroke();
  initGlobalParams();
  noFill();
  triangle();
}

void draw(){
    //background(0);
    if (cue()){
        drawLine();
    }
    if (changeDir() && false){
        dir = !dir;
    }
}

void triangle(){
    triangle(triPts[0].x, triPts[0].y, triPts[1].x, triPts[1].y, triPts[2].x, triPts[2].y);
}

void drawLine(){
    PVector nextPt = getNextPt();
    //println("State: " + state + " nextPt: " + nextPt);
    line(lastPt.x, lastPt.y, nextPt.x, nextPt.y);
    if (dist(lastPt.x, lastPt.y, nextPt.x, nextPt.y) < 10){
        initCurr();
    } else{
        lastPt.x = nextPt.x;
        lastPt.y = nextPt.y;
        updateState();
        updateCurrTri(state);
    }
}

boolean changeDir(){
    return random(0, 100) > .5;
}

boolean randomDir(){
    return random(0, 100) > 50;
}

void initCurr(){
    currTriPts[0] = new PVector(xBase, yBase);
    currTriPts[1] = new PVector(xBase + sideLen, yBase);    
    currTriPts[2] = new PVector(xBase + sideLen / 2, yBase - hRatio * sideLen);
    lastPt.x = triPts[0].x;
    lastPt.y = triPts[0].y;
    background(0);
    triangle();
}

PVector getNextPt(){
    PVector pt = new PVector();
    if (!dir){
        switch (state) {
            case 0:{
                pt.x = map(cutoff, 0, 1, currTriPts[1].x, currTriPts[2].x);
                pt.y = map(cutoff, 0, 1, currTriPts[1].y, currTriPts[2].y);
                return pt;
            }
            case 1:{
                pt.x = map(cutoff, 0, 1, currTriPts[2].x, currTriPts[0].x);
                pt.y = map(cutoff, 0, 1, currTriPts[2].y, currTriPts[0].y);
                return pt;
            }
            case 2:{
                pt.x = map(cutoff, 0, 1, currTriPts[0].x, currTriPts[1].x);
                pt.y = map(cutoff, 0, 1, currTriPts[0].y, currTriPts[1].y);
                return pt;
            }
        }
    } else{
        switch (state) {
            case 0:{
                pt.x = map(cutoff, 0, 1, currTriPts[2].x, currTriPts[1].x);
                pt.y = map(cutoff, 0, 1, currTriPts[2].y, currTriPts[1].y);
                return pt;
            }
            case 1:{
                pt.x = map(cutoff, 0, 1, currTriPts[0].x, currTriPts[2].x);
                pt.y = map(cutoff, 0, 1, currTriPts[0].y, currTriPts[2].y);
                return pt;
            }
            case 2:{
                pt.x = map(cutoff, 0, 1, currTriPts[1].x, currTriPts[0].x);
                pt.y = map(cutoff, 0, 1, currTriPts[1].y, currTriPts[0].y);
                return pt;
            }
        }
    }

    //print(pt);
    return new PVector(0,0);
}

void updateCurrTri(int state){
    currTriPts[state].x = lastPt.x;
    currTriPts[state].y = lastPt.y;
}

boolean cue(){
    return (frameCount % speed) == 0;
}

void initStroke(){
  stroke(230);
  strokeWeight(1);
} 

void initGlobalParams(){
    padding = 100;
    sideLen = ((2 * height) - (4 * padding)) / sqrt(3);
    xBase = (width - sideLen) / 2;
    yBase = height - padding;

    triPts[0] = new PVector(xBase, yBase);
    triPts[1] = new PVector(xBase + sideLen, yBase);    
    triPts[2] = new PVector(xBase + sideLen / 2, yBase - hRatio * sideLen);
    currTriPts[0] = new PVector(xBase, yBase);
    currTriPts[1] = new PVector(xBase + sideLen, yBase);    
    currTriPts[2] = new PVector(xBase + sideLen / 2, yBase - hRatio * sideLen);

    lastPt.x = triPts[0].x;
    lastPt.y = triPts[0].y;
}

void updateState(){
    if (!dir){
        switch (state) {
            case 2:{
                state = 0;
                break;
            }
            default:{
                state ++;
            }
        }
    } else{
        switch (state) {
            case 0:{
                state = 2;
                break;
            }
            default:{
                state--;
            }
        }
    }
    
  //println("updated" + state);
}
