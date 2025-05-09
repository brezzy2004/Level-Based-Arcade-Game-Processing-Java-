class Croissant extends Item {
  PImage croissantImg;
  
  Croissant(float x, float y, float speed) {
    super(x, y, speed);
    croissantImg = loadImage("Croissant.png");  
    croissantImg.resize(80, 80);
  }
  
  @Override
  void fall() {
    speed = 5;         
    super.fall();      
  }

  
  void display() {
    super.display();
    image(croissantImg, position.x, position.y);
  }
  
}  
