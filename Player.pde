class Player {
    PVector pos;
    float speed = 5;
    int snacksCollected = 0; 
    PImage currentImage;
    boolean faceLeft = false; 
    boolean isMoving = false;

    Player() {
        pos = new PVector(width / 2, height - 130);
        currentImage = playerStandImg;
    }
    
    void move() {
    if (keyPressed) {
        if (keyCode == LEFT) {
            pos.x -= speed;
            faceLeft = true;
            isMoving = true;
            currentImage = playerWalking;
        } else if (keyCode == RIGHT) {
            pos.x += speed;
            faceLeft = false;
            isMoving = true;
            currentImage = playerWalking;
        } else {
            isMoving = false;
            currentImage = playerStandImg;
        }
    } else {
        isMoving = false;  
        currentImage = playerStandImg;
    }

    pos.x = constrain(pos.x, currentImage.width/2, width - currentImage.width/2);
}

    void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    if (faceLeft) {
        scale(-1, 1);
        image(currentImage, -currentImage.width/2, -currentImage.height/2);
    } else {
        image(currentImage, -currentImage.width/2, -currentImage.height/2);
    }
    popMatrix();
}

}
