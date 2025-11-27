# The Stacks Tile Game Engine: Your First Game Manual!

Congratulations, you're about to build a game! You have a powerful, fast, and fun game engine at your fingertips. This guide will show you how to use it to bring your ideas to life.

## The Big Idea: How the Engine Thinks

Imagine you have a super-smart robot. You don't want to tell it *how* to move its legs or use its sensors every single time. You just want to give it simple commands like "go to the kitchen" or "pick up the ball."

Our game engine works the same way. It's built in three simple layers:

1.  **The Senses (`handle_input`):** This is the robot's eyes and ears. It checks for keyboard presses and detects if you bump into anything. It doesn't make decisions; it just creates a "Physics Report" about what it sensed.

2.  **The Mechanics (`process_events`):** This is the robot's arms and legs. It reads the Physics Report and does the "hard work." If the report says "a collision happened," this part handles the mechanics, like deleting a tile or transforming it. It then creates a simple "Gameplay Report" like "an object was collected."

3.  **The Brain (`main` loop):** **This is you!** This is your script. You get the simple Gameplay Report from the Mechanics and decide what it means for your game. If the report says "an object was collected," you can decide to add 10 points to the score.

Your job as the game developer is to write the script for the Brain in the `main` function.

---

## Your Toolbox: Creating the Game World

Before you can write your script, you need to set up your game world. You do this by creating **Tiles**. Each tile is an object on the screen with its own look and rules.

### Creating a Tile

You create tiles in the `main` function using `init_single_tile`. You put the properties for the tile on the stack and then call the function.

Here are the properties you need to define for each tile:

```stacks
# [ tile_id, start_x, start_y, data_ptr, color, reaction, replace_ptr ]
```

*   **`tile_id`**: A unique number for this tile (e.g., `0`, `1`, `2`...).
*   **`start_x`, `start_y`**: Where the tile appears on the screen.
*   **`data_ptr`**: A pointer to the sprite data that defines what the tile looks like (e.g., `tile`, `tile1`, `tile2`).
*   **`color`**: The color of the tile (e.g., `purple`, `orange`).
*   **`reaction`**: **This is the magic!** This tells the engine how the tile should behave when it gets hit.
*   **`replace_ptr`**: If the tile can be replaced, this points to its new look. If not, just use `0`.

### Collision Reactions (The Magic!)

The `reaction` property is the most important part of your game design.

*   **`REACT_BLOCK`**: The tile is a solid wall. Nothing can pass through it.
    ```stacks
    # This tile is a solid purple wall
    1 20 30 tile1 purple REACT_BLOCK 0 init_single_tile
    ```

*   **`REACT_OVERWRITE`**: The tile can be collected or destroyed. When you hit it, it disappears, and you move into its space. Perfect for coins, power-ups, or weak enemies.
    ```stacks
    # This tile is a yellow coin that can be collected
    2 50 10 tile2 yellow REACT_OVERWRITE 0 init_single_tile
    ```

*   **`REACT_REPLACE`**: The tile transforms into something else when you hit it. You can't pass through it. Perfect for locked doors, switches, or treasure chests that open.
    ```stacks
    # This tile is a locked door that can be opened
    0 40 30 tile orange REACT_REPLACE &locked_door_replacement init_single_tile
    ```

### Setting up a `REPLACE` Action

A tile with `REACT_REPLACE` needs to know what it will turn into. You define this in a separate `LIST` structure.

**Step 1: Create the replacement data `LIST`**
This list holds the new look and rules for the tile after it's been replaced.

```stacks
# Format: [new_sprite_pointer, new_color, new_reaction]
LIST locked_door_replacement 3
```

**Step 2: Fill the `LIST` with the new properties**

```stacks
0 AS temp_ptr
&locked_door_replacement AS temp_ptr
&tile_data2 AS *temp_ptr       # It will now look like tile2

&locked_door_replacement 1 + AS temp_ptr
green AS *temp_ptr             # It will turn green

&locked_door_replacement 2 + AS temp_ptr
REACT_BLOCK AS *temp_ptr       # After it's replaced, it becomes a solid wall
```

**Step 3: Use the pointer in `init_single_tile`**
Notice the `&locked_door_replacement` at the end of the line. This tells the "locked door" tile where to find its "open door" data.

```stacks
0 40 30 tile orange REACT_REPLACE &locked_door_replacement init_single_tile
```

---

## Writing Your Game: The `main` Function Script

This is where you, the game developer, write your story. The `main` function has a game loop that runs forever. Inside this loop is where your script goes.

```stacks
# ------------------------------------------------------------------
# Main Game Loop (The "Game Developer's Script")
# ------------------------------------------------------------------
1 AS running
WHILE running DO
    handle_input          # 1. The Senses check for input and collisions.
    process_events        # 2. The Mechanics do the hard work and give you a report.

    # 3. Your Logic: Apply game rules based on the report.
    AS interacted_id
    AS game_event

    game_event GAME_EVENT_OVERWRITE_ACTION == IF
        # Rule: An object was overwritten. What does this mean?
        # I know that tile 0 is a coin.
        interacted_id 0 == IF
            # It was the coin! Add 10 to the score.
            score 10 + AS score
        END
    END

    game_event GAME_EVENT_BLOCK_ACTION == IF
        # Rule: The player was blocked by an object.
        # Maybe play a "thud" sound here in the future.
    END

    game_event GAME_EVENT_REPLACE_ACTION == IF
        # Rule: A tile was replaced. What does this mean?
        # I know that tile 0 is a locked door.
        interacted_id 0 == IF
            # The door opened! Add 1 to the score.
            score 1 + AS score
        END
    END

    redraw_all_moved_tiles # 4. The Hands update the screen.

DONE
```

### Understanding the Gameplay Report

After `process_events` runs, it gives you a two-part report on the stack:

1.  **`game_event`**: A code that tells you what *mechanic* just happened.
    *   `GAME_EVENT_BLOCK_ACTION`: You bumped into something solid.
    *   `GAME_EVENT_OVERWRITE_ACTION`: An object was collected/destroyed.
    *   `GAME_EVENT_REPLACE_ACTION`: An object was transformed.

2.  **`interacted_id`**: The `tile_id` of the object you just interacted with.

Your job is to check these two values and apply your game's rules. As you can see in the example, you can check `IF` the event was an `OVERWRITE` and `IF` the ID was `0` to know that the player just collected the main coin.

That's it! You now have everything you need to design your levels and write your game's story. Have fun!

```