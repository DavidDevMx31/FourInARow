# Four in a Row

## Introduction

A Four in a Row game implemented with Swift and UIKit.

https://github.com/user-attachments/assets/203c2b92-ef6c-421b-95f4-42ab3a62a618

## Inspiration

This project is inspired by the Four in a Row app challenge proposed on MoureDev's web page. 

The UI design is inspired by Paul Hudson's Project 34: Four in a Row, which is part of his series "100 Days of Swift."

## Overview

The list of original requirements is:

1. 7x6 board (7 columns and 6 rows).
2. Two chip colors: red and yellow.
3. A red chip always starts the game.
4. Two players alternate turns.
5. Track the number of games won by each player.
6. Add a button to restart the current game.
7. Add a button to reset the win count.

### The Game Board UI

I created the UI using a programmatic approach by removing the storyboard and implementing the navigation manually. The game board is a StackView with seven buttons, where each button represents a column. When the user taps on a column, a chip is added if there is an available slot.

I created a subclass of UIButton with a custom configuration. This subclass allows for reusing the button style and applying it to the "Restart Round" and "Restart Win Count" buttons.

### Detecting Wins and Draws

In other example implementations (including Paul Hudson's), the algorithm checks the entire board after each move to find a run. My approach checks only the adjacent slots to determine whether the move results in a win. When the algorithm detects a different chip color or the absence of a chip, it stops searching and continues with a different orientation. When a four-chip run is detected, the algorithm returns true; otherwise, it returns false and the game continues. This approach results in better performance, as it only checks the critical slots for the current move.

## Technologies

- **Language:** Swift 
- **Framework:** UIKit

## Requirements

- Minimum iOS version: 15

## To-do

- Add a feature to select different chip colors.
- Add a feature to choose the total number of rounds.
