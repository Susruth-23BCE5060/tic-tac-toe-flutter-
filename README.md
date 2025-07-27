# 🤖 Tic Tac Toe with Bot - Flutter App

A simple Tic Tac Toe game built using Flutter, where **Player X** is the user and **Player O** is a basic bot with winning/blocking logic.

---

## 📱 Features

- Turn-based game: Player X (you) vs Bot O
- Bot uses logic to **win or block the player**
- Scoreboard tracking wins for each player
- Reset button to clear the game and the scoreboard
- Responsive layout using `GridView` and `GestureDetector`

---

## 🎮 Gameplay

- You always play as **X**
- After your move, the bot (O) automatically plays
- Bot logic:
  - First, tries to **win**
  - Then, tries to **block your win**
  - Else, makes a **random move**
- Game ends with a dialog for **Win, Loss, or Draw**

---

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK (>= 3.0.0)
- Android Studio / VS Code
- Device or Emulator

### Run Locally

```bash
git clone https://github.com/yourusername/tic_tac_toe_bot.git
cd tic_tac_toe_bot
flutter pub get
flutter run
