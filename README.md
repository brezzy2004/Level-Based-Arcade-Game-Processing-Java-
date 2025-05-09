# ☕ Snack Collector Cup Game – A Processing Arcade Project

## 🎮 Overview
A fun, level-based arcade game developed using the Processing IDE. The player controls a **cup** to catch delicious falling treats — **croissants**, **chocolates**, and **marshmallows** — while **avoiding trash** and a flying **hand glove**. The game increases in difficulty with each level, adding speed and complexity to the falling items.

## 🕹️ Gameplay Features
- **Player Character**:  
  - A **cup** controlled via arrow keys (← ↑ ↓ →).
- **Items to Collect**:
  - 🥐 Croissants  
  - 🍫 Chocolates  
  - ☁️ Marshmallows  
- **Obstacles to Avoid**:
  - 🗑️ **Trash Items**: Reduce score when collected.  
  - 🧤 **Hand Glove**: Deducts a life on collision.
- **Game Flow**:
  - Start with limited lives.
  - Gain points by collecting treats.
  - Lose points or lives by catching trash or hitting gloves.
  - Advance to higher levels where items fall faster.
- **Game Screens**:
  - Start Screen
  - Gameplay Screen
  - Game Over Screen

## ⚙️ Technologies Used
- **Processing IDE (Java-based)**
- Object-Oriented Programming for modular game element design
- Frame-based game loop and real-time input handling

## 🧠 Concepts Practiced
- Collision Detection for treats, trash, and glove  
- Game State Management (Start, Game, Game Over)  
- Level Scaling with increasing item speed  
- Encapsulation using custom classes (Cup, Item, Glove, Trash)

## 📁 File Structure
- `MainGame.pde` – Controls setup, draw loop, and level logic  
- `Cup.pde` – Handles player logic  
- `FoodItem.pde` – Parent class for croissant, chocolate, marshmallow  
- `Trash.pde` – Trash item behavior  
- `Glove.pde` – Glove enemy logic  
- `GameScreen.pde` – Manages different game states/screens

## ✅ How to Play
1. Open the sketch in **Processing IDE**.
2. Press **Run**.
3. Use **arrow keys** to move the cup.
4. **Collect** only the treats.
5. **Avoid** trash and glove to stay alive.
6. Survive and score high across increasingly harder levels.

## 🌟 Future Features
- Power-ups (e.g., slow motion, extra life)
- Background sound effects and music
- Animated item effects
- Pause and resume functionality

## 👤 Author
*Your Name* – Computer Engineering Student  
Created as an academic/personal project to showcase game development and design skills.

