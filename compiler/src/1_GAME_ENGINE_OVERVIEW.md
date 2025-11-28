# 1. The Stacks Tile Game Engine: Overview

Congratulations on choosing the Stacks Tile Game Engine! You have a powerful, fast, and fun game engine at your fingertips. This document explains the core philosophy behind the engine.

## The Big Idea: How the Engine Thinks

Imagine you have a super-smart robot. You don't want to tell it *how* to move its legs or use its sensors every single time. You just want to give it simple commands like "go to the kitchen" or "pick up the ball."

Our game engine works the same way. It's built in three simple layers:

1.  **The Senses (`handle_input`):** This is the robot's eyes and ears. It checks for keyboard presses and detects if you bump into anything. It doesn't make decisions; it just creates a "Physics Report" about what it sensed.

2.  **The Mechanics (`process_events`):** This is the robot's arms and legs. It reads the Physics Report and does the "hard work." If the report says "a collision happened," this part handles the mechanics, like deleting a tile or transforming it. It then creates a simple "Gameplay Report" like "an object was collected."

3.  **The Brain (`main` loop):** **This is you!** This is your script. You get the simple Gameplay Report from the Mechanics and decide what it means for your game. If the report says "an object was collected," you can decide to add 10 points to the score.

Your job as the game developer is to write the script for the Brain in the `main` function.

---

## Next Steps

Now that you understand the philosophy, you're ready to start building.

*   To build your first game step-by-step, read **`2_TUTORIAL_FIRST_GAME.md`**.
*   For a detailed list of all available functions and constants, see **`3_API_REFERENCE.md`**.

---

*This documentation is for the Stacks Game Engine.*