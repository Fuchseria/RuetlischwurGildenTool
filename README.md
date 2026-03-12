# Rütlischwur Gilden Tool

![WoW Version](https://img.shields.io/badge/WoW-12.x%20Midnight-blue)
![Version](https://img.shields.io/badge/version-1.0.1-green)
![Author](https://img.shields.io/badge/author-Fuchseria-purple)
![AI Assisted](https://img.shields.io/badge/development-AI%20assisted-orange)

A lightweight guild management addon for **World of Warcraft Retail (Midnight 12.x)** that simplifies **promoting and demoting guild members** using an importable queue system.

Players can paste a list of names, match them automatically with the guild roster, and process promotions or demotions step-by-step.

This addon was created with **AI-assisted development**, while the concept, design, and maintenance are by **Fuchseria**.

---

# Features

• Import lists of player names
• Automatic guild roster matching
• **Promote Mode** and **Demote Mode**
• Queue system displaying:

* Player Name
* Current Rank
* Target Rank

• Automatic macro generation
• Supports names **with or without server name**
• Queue automatically updates after rank changes
• Shows the **next player in the queue**

---

# Slash Command

Open the addon window:

```
/rgt
```

---

# How It Works

1. Open the addon with `/rgt`
2. Select **Promote Mode** or **Demote Mode**
3. Choose a **target rank**
4. Paste player names into the import box
5. Click **Import Players**
6. Use the generated macros to process players
7. The queue updates automatically until all players reach the target rank

---

# Automatically Generated Macros

The addon automatically creates two macros.

### Promote Macro

```
RGT_PROMOTE
```

### Demote Macro

```
RGT_DEMOTE
```

Each macro always targets the **next player in the queue**.

---

# Installation

1. Download the addon
2. Move the addon folder to:

```
World of Warcraft/_retail_/Interface/AddOns/
```

3. Start the game
4. Enable **Rütlischwur Gilden Tool** in the addon list
5. Use `/rgt` to open the interface

---

# Requirements

• World of Warcraft Retail (12.x / Midnight)
• Guild permissions to **promote or demote members**

---

# Development

GitHub repository:

https://github.com/Fuchseria/RuetlischwurGildenTool

---

# Credits

**Author:** Fuchseria

This addon was developed with **AI-assisted programming support** while the concept and design remain by the author.
