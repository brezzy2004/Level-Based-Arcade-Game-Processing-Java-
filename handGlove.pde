class handGlove {
  PVector position;  
  PVector velocity;  
  PImage gloveImg;
  int trashDropCooldown = 0; 

  handGlove(float x, float speed) {
    position = new PVector(x, 0); 
    velocity = new PVector(speed, 0); 
    gloveImg = loadImage("handGlove.png");
    gloveImg.resize(150, 150);
  }

  void move() {
    position.add(velocity);
    
    if (position.x < 0) {
      position.x = 0;
      velocity.x *= -1;
    }
    if (position.x > width - gloveImg.width) {
      position.x = width - gloveImg.width;
      velocity.x *= -1;
    }
    
    if (trashDropCooldown > 0) {
      trashDropCooldown--;
    }
  }
  
  void dropTrash(ArrayList<Item> items) {
    float dropChance;
    int cooldown;
    
    if (currentLevel == 1) {
      dropChance = 0.01;  
      cooldown = 300;
    } else if (currentLevel == 2) {
      dropChance = 0.02;  
      cooldown = 200;
    } else if (currentLevel == 3) {
      dropChance = 0.04;  
      cooldown = 150;
    } else {
      dropChance = 0.01;
      cooldown = 300;
    }
    
    if (trashDropCooldown == 0 && random(1) < dropChance) {
      if (currentLevel == 2) {
        items.add(new TrashApple(position.x, position.y + gloveImg.height, 6));
      } else if (currentLevel == 3) {
        items.add(new TrashBanana(position.x, position.y + gloveImg.height, 4));
      } else {
        items.add(new TrashItem(position.x, position.y + gloveImg.height, 2));
      }
      trashDropCooldown = cooldown;
    }
  }
  
  void display() {
    image(gloveImg, position.x, position.y);
  }
}
