boolean left, right;
PVector leftAcc = new PVector (-2,0);
PVector rightAcc = new PVector (2,0);

void keyReleased(){
  if(key == CODED){
    if(keyCode == LEFT) left = false;
    if(keyCode == RIGHT) right = false;
  }
}
