class Marshmallow extends Item {
    PImage marshmallowImg;
    Marshmallow(float x, float y, float speed) {
        super(x, y, speed);
        marshmallowImg = loadImage("Marshmallow.png");
        marshmallowImg.resize(800,800);
    }

    @Override
    void fall() {
    speed = 4;         
    super.fall();      
    }


    void display() {
        super.display(); 
        image(marshmallowImg, position.x, position.y, 80, 80);
    }
}
