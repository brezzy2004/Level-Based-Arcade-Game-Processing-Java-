class TrashItem extends Item {
    PImage TrashImg;
    
    TrashItem(float x, float y, float speed) {
        super(x, y, speed);  
        TrashImg = loadImage("TrashItem.png");
        TrashImg.resize(120, 120);
    }
    
    // Aggregation
    Item item;
   
    @Override
    void display() {
        image(TrashImg, position.x, position.y);
    }
    
    @Override
    boolean isCaughtBy(Player p) {
        int playerLeft = (int)(p.pos.x - p.currentImage.width / 2);
        int playerTop = (int)(p.pos.y - p.currentImage.height / 2);
        
        int trashLeft = (int)(position.x);
        int trashTop = (int)(position.y);
        
        int overlapLeft = max(playerLeft, trashLeft);
        int overlapTop = max(playerTop, trashTop);
        int overlapRight = min(playerLeft + p.currentImage.width, trashLeft + TrashImg.width);
        int overlapBottom = min(playerTop + p.currentImage.height, trashTop + TrashImg.height);
        
        if (overlapRight <= overlapLeft || overlapBottom <= overlapTop) {
            return false;
        }
        
        for (int i = overlapLeft; i < overlapRight; i++) {
            for (int j = overlapTop; j < overlapBottom; j++) { 
                int playerImgX = i - playerLeft;
                int playerImgY = j - playerTop;
                int trashImgX  = i - trashLeft;
                int trashImgY  = j - trashTop;
                
                int playerPixel = p.currentImage.get(playerImgX, playerImgY);
                int trashPixel  = TrashImg.get(trashImgX, trashImgY);
                
                if (alpha(playerPixel) > 0 && alpha(trashPixel) > 0) {
                    return true;
                }
            }
        }
        
        return false;
    }
}
