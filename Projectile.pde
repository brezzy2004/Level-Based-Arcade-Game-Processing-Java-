class Projectile {
    PVector pos;
    PVector vel;
    PImage kiteImg;

    Projectile(float x, float y) {
        pos = new PVector(x, y);
        vel = new PVector(0, -10);
        kiteImg = loadImage("Kite.png");
        kiteImg.resize(70, 0);
    }

    void update() {
        pos.add(vel);
    }

    void display() {
        image(kiteImg, pos.x, pos.y);
    }

    boolean hits(handGlove c) {
        
        float kiteLeft = pos.x - kiteImg.width / 2;
        float kiteRight = pos.x + kiteImg.width / 2;
        float kiteTop = pos.y - kiteImg.height / 2;
        float kiteBottom = pos.y + kiteImg.height / 2;

        float crowLeft = c.position.x - c.crowImg.width / 2;
        float crowRight = c.position.x + c.crowImg.width / 2;
        float crowTop = c.position.y - c.crowImg.height / 2;
        float crowBottom = c.position.y + c.crowImg.height / 2;

        // Check for overlap
        return !(kiteRight < crowLeft || kiteLeft > crowRight || kiteBottom < crowTop || kiteTop > crowBottom);
    }
}
