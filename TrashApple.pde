class TrashApple extends TrashItem {
    PImage appleTrash;
    
    TrashApple(float x, float y, float speed) {
    super(x, y, speed);
    appleTrash = loadImage("Trash2.png");  
    appleTrash.resize(80, 80);
  }
  
  @Override
  void fall() {
    speed = 3;         
    super.fall();      
  }

  @Override
  void display() {
    image(appleTrash, position.x, position.y);
  }














}
