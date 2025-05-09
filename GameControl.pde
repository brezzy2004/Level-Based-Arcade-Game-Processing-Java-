import ddf.minim.*;
import controlP5.*;


Player player;
ArrayList<Item> items;
ArrayList<handGlove> gloves;
ArrayList<Projectile> projectiles;
int score = 0;
int lives = 3;
int currentLevel = 1;  
PFont myFont;
PImage bgImage, screen1, screen2, level1, level2, level3, picnic, appleImg, gameOver, playerWalking, playerStandImg;
int gameState = 0; 
int lastScore = 0;

Minim minim;
AudioPlayer scoreSound;
AudioPlayer levelCompletion;
AudioPlayer losing;
AudioPlayer kiteProjectile;
AudioPlayer backgroundMusic;

ControlP5 cp5;

int levelTransitionStart = -1;
int levelTransitionDelay = 3000;

void setup() {
  size(1000, 800);
    
  
  minim = new Minim(this);
  scoreSound = minim.loadFile("collected.mp3");
  levelCompletion = minim.loadFile("levelcompletion.mp3");
  losing = minim.loadFile("losing.mp3");
  kiteProjectile = minim.loadFile("Kite.mp3");
  backgroundMusic = minim.loadFile("Background.mp3");
  backgroundMusic.loop();



  playerStandImg = loadImage("player.png");
  playerStandImg.resize(300,300);
  
  playerWalking = loadImage("walking.png");
  playerWalking.resize(260,260);
  
  screen1 = loadImage("STARTING1.png");
  screen1.resize(1000, 800);
  
  screen2 = loadImage("STARTING2.png");
  screen2.resize(1000, 800);
  
  level1 = loadImage("LEVEL1.png");
  level1.resize(1000, 800);
  
  level2 = loadImage("LEVEL2.png");
  level2.resize(1000, 800);
  
  level3 = loadImage("LEVEL3.png");
  level3.resize(1000, 800);
  
  bgImage = loadImage("background.png");
  bgImage.resize(1000, 800);
  
  picnic = loadImage("PICNIC.png");
  picnic.resize(1000, 800);
  
  appleImg = loadImage("apple.png");
  appleImg.resize(40, 40);  
  
  gameOver = loadImage("GameOver.png");
  gameOver.resize(1000,800);

  myFont = loadFont("DansHandWriting-68.vlw");
  textFont(myFont);
  
  

  // Initialize game objects
  player = new Player();
  items = new ArrayList<Item>();
  gloves = new ArrayList<handGlove>();
  projectiles = new ArrayList<Projectile>();
}

void draw() {
  if (lives <= 0) {
    image(gameOver, 0, 0); 
    noLoop(); 
    return; 
  }
  
  
  switch(gameState) {
    case 0:
      Screen1();
      break;
    case 1:  
      Screen2();
      break;
    case 2:  
      LEVELOne();
      break;
    case 3:  
      LEVELS2And3(level2, 2);
      break;
    case 5:  
      LEVELS2And3(level3, 3);
      break;
    case 4:  
      runGameplay();
      break;
  } 
}

void Screen1() {
  image(screen1, 0, 0);
}

void Screen2() {
  image(screen2, 0, 0);
}

void LEVELOne() {
  image(level1, 0, 0);
}

void LEVELS2And3(PImage levelScreen, int nextLevel) {
  image(levelScreen, 0, 0);
  if (millis() - levelTransitionStart >= levelTransitionDelay) {
    if (nextLevel == 2) {
      resetLevel2();
    } else if (nextLevel == 3) {
      resetLevel3();
    }
    currentLevel = nextLevel;
    gameState = 4;   
    levelTransitionStart = -1;
  }
}

void runGameplay() {
  background(bgImage);
  
  if (frameCount % 100 == 0) {
    if (currentLevel == 2) {
      items.add(new Croissant(random(width), 0, 5));
    } else if (currentLevel == 3) {
      items.add(new Chocolate(random(width), 0, 6));
    } else {
      if (random(1) > 0.4) {
        items.add(new Marshmallow(random(width), 0, 3));
      } 
    }
  }

  if (frameCount % 400 == 0) {
    gloves.add(new handGlove(random(width), 2));
  }

  // Process falling items
    for (int i = items.size() - 1; i >= 0; i--) {
      Item it = items.get(i);
      it.fall();
      it.display();

      if (it.isCaughtBy(player)) {
        if (it instanceof Marshmallow || it instanceof Croissant || it instanceof Chocolate) {
          score += 10;
          player.snacksCollected++;
        } else if (it instanceof TrashItem) {
          lives--;
        }
        items.remove(i);
      }
      else if (it.position.y > height) {
        items.remove(i);
      }
    }

    for (int i = gloves.size() - 1; i >= 0; i--) {
        handGlove glove = gloves.get(i);
        glove.move();
        glove.display();
        glove.dropTrash(items);
    }
    
    // Update and display all projectiles
    for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile projectile = projectiles.get(i);
    projectile.update();
    projectile.display();

    // Check for collision with each crow
    for (int j = gloves.size() - 1; j >= 0; j--) {
        handGlove glove = gloves.get(j);
        if (projectile.hits(glove)) {
            // If a crow is hit, and we've lost any lives, restore one life.
            // Here we assume a maximum of 3 lives.
            if (lives < 3) {
                lives++;
            }
            gloves.remove(j);  // Remove the crow from the game
            projectiles.remove(i);  // Optionally remove the projectile as well
            break;  // Exit the inner loop after handling collision
        }
    }
}

  player.move();
  player.display();

   if (currentLevel == 1 && score >= 100) {
    levelCompletion.play(); 
    gameState = 3;
    levelTransitionStart = millis();
    levelTransition();
  }
  if (currentLevel == 2 && score >= 150) {
    levelCompletion.rewind();
    levelCompletion.play(); 
    gameState = 5;
    levelTransitionStart = millis();
    levelTransition();
  }
  if (currentLevel == 3 && score >= 200) {
    levelCompletion.rewind();
    levelCompletion.play(); 
    image(picnic, 0, 0);
    fill(255);
    levelTransition();
  }

  if (lives <= 0) {
    losing.play(); 
    image(gameOver, 0, 0);
    noLoop();
    return;
  }

  if (score >= lastScore + 10) {
        scoreSound.rewind();
        scoreSound.play();
        lastScore += 10;
    }

  
  
  ScoresLives();

  if (lives <= 0) {
    fill(0);
    gameOver = loadImage("GameOver.png");
    gameOver.resize(1000,800);
  }

  if (key == ' ' && player.snacksCollected >= 5) {
    projectiles.add(new Projectile(player.pos.x + 20, player.pos.y));
    player.snacksCollected = 0; 
  }

  if (currentLevel == 1 && score >= 100) {
    gameState = 3;
    levelTransitionStart = millis();
    return;
  }
  if (currentLevel == 2 && score >= 150) {
    gameState = 5;
    levelTransitionStart = millis();
    return;
  }
  if (currentLevel == 3 && score >= 200) {
    image(picnic, 0, 0);
    fill(255);
    noLoop();
  }
}

void ScoresLives() {
  textSize(50);
  String scoreText = "Score: " + score;
  
  float textW = textWidth(scoreText);
  float padding = 10;
  
  noStroke();
  fill(255);
  rect(10, 5, textW + padding * 2, 60); 
  
  fill(0);
  text(scoreText, 10 + padding, 50);

  int startX = 155; 
  int startY = 290; 
  
  //spacing between apples
  int verticalSpacing = 60; 

  for (int i = 0; i < lives; i++) {
    // Calculate bobbing effect using a sine wave
    float bobbingAmplitude = 8; 
    float bobbing = sin(frameCount * 0.1 + i) * bobbingAmplitude; 
    image(appleImg, startX, startY + i * verticalSpacing + bobbing);
  }
}

void keyPressed() {
    if (key == ' ') {
        if (player.snacksCollected >= 5) {
            projectiles.add(new Projectile(player.pos.x + 20, player.pos.y));
            player.snacksCollected = 0; 

            kiteProjectile.rewind();  
            kiteProjectile.play();
        }
    } else if (key == ENTER || key == RETURN) {
        if (gameState == 0) {
            gameState = 1;  
        } else if (gameState == 1) {
            gameState = 2;  
        } else if (gameState == 2) {
            resetGame();
            currentLevel = 1;
            gameState = 4;
        }
    }
}

void resetGame() {
  items.clear();
  gloves.clear();
  projectiles.clear();
  score = 0;
  lives = 3;
  lastScore = 0;
  player.snacksCollected = 0;
}

void resetLevel2() {
  items.clear();
  gloves.clear();
  projectiles.clear();
  score = 0;
  lives = 3;
  lastScore = 0;
  player.snacksCollected = 0;
}

void resetLevel3() {
  items.clear();
  gloves.clear();
  projectiles.clear();
  score = 0;
  lives = 3;
  lastScore = 0;
  player.snacksCollected = 0;
}

void levelTransition() {
    lastScore = score - (score % 10);
}
