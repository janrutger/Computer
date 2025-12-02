# 2. Tutorial: Your First Game

This guide will walk you through creating a simple game from scratch using the Stacks Game Engine. We will create a player, a wall, and a coin.

## Step 1: Basic Setup

Every game starts with the same two lines. First, `INCLUDE` the engine library. Then, inside your `main` function, call `init_game_lib` to set up the engine's internal systems.

```stacks
INCLUDE game_lib

DEF main {
    init_game_lib

    # Game setup goes here...

    # Main game loop goes here...
}

main
```

## Step 2: Create Your Game's Look (Assets)

Tiles need a visual representation. We define these using `LIST` and `ASM` blocks. Let's create a simple block for a wall and a star for a coin.

```stacks
# A solid block for our wall
LIST tile_data_wall 11
ASM { % $tile_data_wall 3 3 203 203 203 203 203 203 203 203 203 }
&tile_data_wall AS wall_sprite

# A star for our coin
LIST tile_data_coin 6
ASM { % $tile_data_coin 2 2 42 42 42 42 }
&tile_data_coin AS coin_sprite
```

## Step 3: Create the Game Objects (Tiles)

Now we use `init_single_tile` to place our objects in the world. We'll create three tiles:
1.  The player (a purple block).
2.  A solid wall (an orange block).
3.  A collectible coin (a yellow star).

```stacks
# --- Inside your main function, after init_game_lib ---

# The Player (ID 0)
0 10 10 wall_sprite purple REACT_BLOCK 0 init_single_tile

# The Wall (ID 1)
1 20 10 wall_sprite orange REACT_BLOCK 0 init_single_tile

# The Coin (ID 2)
2 30 10 coin_sprite yellow REACT_OVERWRITE 0 init_single_tile
```

## Step 4: Tell the Engine How Many Tiles to Manage

After creating your tiles, you must set the `active_tile_count`. Since we made three tiles (IDs 0, 1, and 2), the count is 3.

```stacks
3 AS active_tile_count
```

You also need to tell the engine which tile the player controls.

```stacks
0 AS KEYBOARD_TILE # The player is tile 0
```

## Step 5: The Main Game Loop

This is the heart of your game. It continuously senses input, processes game mechanics, applies your rules, and redraws the screen.

```stacks
# --- Inside your main function, after setting up tiles ---

1 AS running
WHILE running DO
    handle_input          # 1. Senses
    process_events        # 2. Mechanics

    # 3. Your Logic (The Brain)
    AS interacted_id
    AS game_event

    game_event GAME_EVENT_OVERWRITE_ACTION == IF
        # An object was collected. Was it the coin?
        interacted_id 2 == IF
            # It was the coin! Add 10 points to the score.
            score 10 + AS score
        END
    END

    redraw_all_moved_tiles # 4. Hands
DONE
```

## Step 6: Draw the Initial Screen

Before the loop starts, you need to draw everything for the first time. The `draw_all_tiles` helper function does this for you.

```stacks
# --- Inside main, just before the game loop ---
draw_all_tiles
```

## You're Done!

That's it! You have a complete, simple game. The player can move, bump into the wall, and collect the coin to increase their score. You now have all the building blocks to create much more complex games.

For a detailed list of all available functions, see **`3_API_REFERENCE.md`**.