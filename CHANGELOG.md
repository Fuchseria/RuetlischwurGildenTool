# Rütlischwur Gilden Tool – Changelog

Author: Fuchseria (vibe code)

---

# Version 1.0

Official Public Release

## Core Features

* Import player list (one name per line)
* Automatic guild roster matching
* Automatic realm name detection
* Promotion queue system
* Demotion queue system
* Target rank dropdown selection

## Queue System

The addon creates a queue containing:

Player Name
Current Rank
Target Rank

Players remain in the queue until they reach the selected target rank.

## Macro System

The addon automatically generates two macros:

RGT_PROMOTE
RGT_DEMOTE

Example:

#showtooltip
/gpromote Player-Realm

The macros automatically update to always target the next player in the queue.

## Automatic Queue Updates

The queue updates automatically when a player's guild rank changes.

Detected through:

GUILD_ROSTER_UPDATE

When a promotion or demotion happens:

* queue updates
* next player becomes active
* macros update automatically

## UI Features

* movable addon window
* ESC closes the window
* scrollable import box
* queue display
* next player display
* promote / demote mode selection

## Slash Command

/rgt

Opens or closes the addon window.

---

This version represents the first stable public release of the addon.
