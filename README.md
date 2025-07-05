# 🐍 Snake Game – Built with Flutter

A modern, offline remake of the classic **Snake Game**, handcrafted in **Flutter**.  
This project explores how far one can go using **just gestures**, **custom drawing**, and **game logic** without external engines like Flame.

---

## 🎯 Goal

Recreate the **principle of Snake game mechanics** in Flutter from scratch — no multiplayer, no network — just offline fun with a vision for better control and smoother gameplay.

---

## 🚀 Features So Far

- ✅ **Dynamic glowing snake body** (grows with food)
- ✅ **Apple food** (glows + relocates on eat)
- ✅ **Edge wrap-around** (snake reappears from the other side)
- ✅ **Self-collision detection** (ends game)
- ✅ **Score counter**
- ✅ **Restart dialog on game over**
- ✅ **Gesture Controls** – Tap left/right screen to rotate

---

## 🛠️ Tech Stack

- **Flutter** for UI & rendering
- **Dart Timer** for the game loop
- **CustomPainter** for drawing snake + apple
- **GestureDetector** for controls

---

## 📱 APK Download

👉 [Download APK](https://github.com/A-THIF/Snake_Game_Flutter/releases/latest)

---

## 🧠 Development Journey

### 📌 Initial Idea:
- Wanted to use **gyroscope/tilt** for movement — didn’t give good control.
- Pivoted to **gesture-based control** with left/right screen taps.

### ⚙️ Challenges Overcome:
- Snake moved only in half screen (due to screen size = 0) — fixed using `WidgetsBinding.instance.addPostFrameCallback(...)`.
- Snake disappeared on wraparound due to incorrect coordinate logic.
- Gradle & APK build errors fixed for proper release packaging.
- WhatsApp file-sharing issues (APK got corrupted) — renamed and re-packaged.
- Asset loading, screen logic, and game loop optimized.

---

## 🎮 Planned Improvements

**Controls (Experimental ideas):**
- 🔄 Touch and drag the snake — movement follows your finger
- 🔼 Classic D-Pad control (like old button phones)
- 🔁 Long tap = continuous turn in that direction

**UI Improvements:**
- 💡 Glow-up the visuals (Snake.io inspiration)
- 🍎 Animate food when eaten
- 🧱 Visual boundaries or grid

**Game Modes:**
- ☑️ Classic endless survival  
- ⏱️ Add timed mode (future)

---

## 🙋‍♂️ Developer

**Mohamed Athif (A-THIF)**  
💡 Flutter developer & IoT tinkerer  
🎮 Focused on intuitive game mechanics and embedded simplicity  
🔗 [LinkedIn](https://www.linkedin.com/in/mohamedathif)

---

## 🏷️ Tags

`#FlutterGame` `#SnakeGame` `#OfflineGame` `#GestureControls` `#OpenSource`  
`#NoMultiplayer` `#Dart` `#MobileGame` `#CustomPainter`

---

