# 3. Stacks Game Engine: API Reference

This document is a technical reference for all constants, variables, and functions available in the `game_lib` library.

---

## Engine Setup

### `INCLUDE game_lib`
Must be the first line in your game file. Makes all engine features available.

### `init_game_lib`
Must be the first function call inside `main`. Initializes the engine's internal systems.

---

## Core Engine Globals

### Constants

*   `MAX_TILES`: The maximum number of tiles the engine can manage (currently `8`).
*   `TILE_OBJ_SIZE`: The size in memory of a single tile's data structure (currently `11`).

### Variables

*   `active_tile_count`: **You must set this.** The number of tiles your game is currently using. The engine will only process this many tiles.
*   `KEYBOARD_TILE`: **You must set this.** The `tile_id` of the tile that should be controlled by the player's keyboard input.

---

## Tile Object Structure

These constants are offsets used to access data within a tile's internal structure. You will likely not need these directly, but they are available for advanced use.

*   `TILE_X`, `TILE_Y`: Current X/Y coordinates.
*   `TILE_OLD_X`, `TILE_OLD_Y`: X/Y coordinates from the previous frame (for erasing).
*   `TILE_OLD_W`, `TILE_OLD_H`: Width/Height from the previous frame (for erasing).
*   `TILE_IS_MOVED`: A flag (`1` or `0`) indicating if the tile has moved.
*   `TILE_COLOR`: The tile's color.
*   `TILE_DATA`: A pointer to the tile's sprite data.
*   `TILE_REACTION`: The tile's collision reaction code.
*   `TILE_REPLACE_DATA_PTR`: A pointer to the tile's replacement data structure.

---

## Gameplay Constants

### Collision Reactions
Used with `init_single_tile` to define a tile's behavior.

*   `REACT_BLOCK`: The tile is a solid wall.
*   `REACT_OVERWRITE`: The tile is collectible/destroyable. The actor moves into its space.
*   `REACT_REPLACE`: The tile transforms into something else upon collision.

### Game Events
Returned by `process_events` to inform your game logic what happened.

*   `GAME_EVENT_NONE`: No event occurred.
*   `GAME_EVENT_BLOCK_ACTION`: An actor was blocked by a `REACT_BLOCK` tile.
*   `GAME_EVENT_OVERWRITE_ACTION`: An actor overwrote a `REACT_OVERWRITE` tile.
*   `GAME_EVENT_REPLACE_ACTION`: An actor triggered a `REACT_REPLACE` tile.

---

## Engine Functions

### `init_single_tile`
Creates a game object (tile).
*   **Stack Input:** `[replace_ptr, reaction, color, data_ptr, start_y, start_x, tile_id]`

### `define_replacement`
A helper to easily set up data for a `REACT_REPLACE` tile.
*   **Stack Input:** `[new_reaction, new_color, new_sprite_data_ptr, replacement_data_ptr]`

### `is_timer_ready`
A reusable timer function for creating periodic events. Returns `1` when the timer is ready, `0` otherwise. Automatically resets.
*   **Stack Input:** `[cooldown_duration, timer_variable_pointer]`

### `tile_move`
Instantly moves a tile to a new position and marks it for redraw.
*   **Stack Input:** `[new_x, new_y, tile_id]`

### `delete_tile`
Effectively deletes a tile by moving it off-screen and marking it for redraw (to erase it from its old position).
*   **Stack Input:** `[tile_id]`

### `replace_tile`
Internal function used by `process_events` to handle a `REACT_REPLACE` event. You will likely not call this directly.
*   **Stack Input:** `[tile_id]`

---

## Drawing Functions

### `redraw_all_moved_tiles`
The main drawing function for your game loop. Efficiently erases and redraws only the tiles that have moved since the last frame, then flips the screen buffer.

### `draw_all_tiles`
Draws every active tile at its current position and flips the screen buffer. Useful for the initial screen draw at the start of your game.

### `draw_tile_by_id`
Draws a single tile specified by its ID. Does **not** flip the screen buffer.
*   **Stack Input:** `[tile_id]`

### `refresh_tiles`
A simple helper that just flips the screen buffer.

### `clear_rect`
Draws a solid rectangle of a single sprite character.
*   **Stack Input:** `[sprite_id, height, width, start_y, start_x]`