# Rütlischwur Gilden Tool

**Author:** Fuchseria
**Version:** 1.0.1
**Game:** World of Warcraft (Retail / Midnight 12.x)

Rütlischwur Gilden Tool is a guild management addon that simplifies **promoting and demoting guild members** using an importable queue system.

Player names can be pasted directly into the addon, matched with the guild roster, and processed step-by-step using automatically generated macros.

This addon was created with **AI-assisted development**, while the concept, design, and maintenance are by **Fuchseria**.

---

## Features

* Import a list of player names
* Automatic guild roster matching
* Supports **Promote Mode** and **Demote Mode**
* Queue display showing:

  * Player Name
  * Current Rank
  * Target Rank
* Automatic macro generation for the next player
* Supports player names **with or without server name**
* Queue automatically updates after promotions or demotions
* Displays the **next player in the queue**

---

## Slash Command

Open the addon window with:

```
/rgt
```

---

## How It Works

1. Open the addon using `/rgt`
2. Select **Promote Mode** or **Demote Mode**
3. Choose the **target rank**
4. Paste player names into the import box
5. Click **Import Players**
6. Use the generated macros to process players
7. The queue updates automatically until all players reach the target rank

---

## Automatically Generated Macros

The addon creates two macros automatically:

**Promotion macro**

```
RGT_PROMOTE
```

**Demotion macro**

```
RGT_DEMOTE
```

Each macro always targets the **next player in the queue**.

---

## Installation

1. Download the addon
2. Place the addon folder into:

```
World of Warcraft/_retail_/Interface/AddOns/
```

3. Start World of Warcraft
4. Enable the addon in the AddOn list
5. Use `/rgt` to open the interface

---

## Requirements

* World of Warcraft Retail (12.x / Midnight)
* Guild permissions to **promote or demote members**

---

## Development

GitHub:
https://github.com/Fuchseria/RuetlischwurGildenTool

---

## Credits

Author: **Fuchseria**
AI-assisted development support used during implementation.
