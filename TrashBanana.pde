class TrashBanana extends TrashItem {
    PImage bananaTrash;
    
    TrashBanana(float x, float y, float speed) {
    super(x, y, speed);
    bananaTrash = loadImage("Trash3.png");  
    bananaTrash.resize(80, 80);
  }
  
  @Override
  void fall() {
    speed = 5;         
    super.fall();      
  }

  @Override
  void display() {
    image(bananaTrash, position.x, position.y);
  }


}
