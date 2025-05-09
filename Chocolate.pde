class Chocolate extends Item {
  PImage burgerImage;
  
  Chocolate(float x, float y, float speed) {
    super(x, y, speed);
    burgerImage = loadImage("Choco.png");  
    burgerImage.resize(80, 80);
  }
  
  @Override
  void fall() {
    speed = 6;         
    super.fall();      
  }

  @Override
  void display() {
    image(burgerImage, position.x, position.y);
  }
}
