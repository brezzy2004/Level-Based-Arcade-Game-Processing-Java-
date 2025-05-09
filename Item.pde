class Item {
    PVector position; 
    float speed;
    
    Item(float x, float y, float speed) {
        this.position = new PVector(x, y);
        this.speed = speed;
    }
    
    void fall() {
        position.y += speed;
    }
    
    void display() {
    }
    
    boolean isCaughtBy(Player p) {
        float basketWidth = 80;  
        float basketTop = p.pos.y + p.currentImage.height/2 - 50;  // Adjust as needed
        
        float basketLeft = p.faceLeft ? p.pos.x - basketWidth : p.pos.x;
        float basketRight = p.faceLeft ? p.pos.x : p.pos.x + basketWidth;
        
        float itemLeft = position.x;
        float itemRight = position.x + 80;
        float itemBottom = position.y + 135;  
        
        boolean horizontalOverlap = (itemLeft < basketRight) && (itemRight > basketLeft);
        
        if (horizontalOverlap && itemBottom >= basketTop) {
            return true;
        }
        return false;
    }
}
