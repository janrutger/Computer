import time
import json
import os
import matplotlib.pyplot as plt
import numpy as np
from .UDC import (
    UDCDevice, 
    SCREEN,
    UDC_DEVICE_NEW, 
    UDC_DEVICE_COLOR, 
    UDC_DEVICE_MODE, 
    UDC_DEVICE_X,
    UDC_DEVICE_Y,
    UDC_DEVICE_DRAW,
    DEV_ERROR_DEVICE, 
    DEV_ERROR_VALUE
)

class VirtualLCD(UDCDevice):
    """
    A Virtual LCD Screen device that uses matplotlib to render a 640x480 display.
    It supports a high-resolution pixel mode and a low-resolution block/sprite mode.
    """
    def __init__(self, udc, channel):
        super().__init__(SCREEN, udc, channel)
        
        # --- Device Specifications ---
        self.width = 640
        self.height = 480
        
        # --- Internal State ---
        self.x = 0
        self.y = 0
        self.mode = 0  # 0 for Pixel Mode, 1 for Block/Sprite Mode
        self.color = 0 # Default color index
        
        # --- Screen Buffer ---
        # Use a NumPy array for efficient pixel manipulation
        self.screen_buffer = np.zeros((self.height, self.width), dtype=np.uint8)
        
        # --- Sprite ROM ---
        self.sprites = {}
        
        # --- Matplotlib Objects ---
        self.fig = None
        self.ax = None
        self.image = None
        self.dirty = True
        self.last_draw_time = 0

    def tick(self):
        """Main tick for the LCD. Handles UDC commands."""
        super().tick()

    def draw(self):
        """Keeps the matplotlib window responsive. Called from the main loop."""
        current_time = time.time()
        if current_time - self.last_draw_time < 0.1: # Limit redraw rate
            return

        if self.fig and self.dirty:
            try:
                self.update_plot()
                self.fig.canvas.draw_idle()
                self.fig.canvas.flush_events()
                self.dirty = False
                self.last_draw_time = current_time
            except Exception:
                self.close_plot()

    # --- UDC Hooks ---

    def on_init(self):
        """Loads the sprite ROM when the device is initialized."""
        self.load_sprite_rom()

    def on_online(self):
        """When the device is brought online, create the plot window."""
        self.init_plot()

    def on_offline(self):
        """When the device is brought offline, close the plot window."""
        self.close_plot()

    def on_reset(self):
        """Resets the device state."""
        self.close_plot()
        self.screen_buffer.fill(0)
        self.x = 0
        self.y = 0
        self.mode = 0
        self.color = 0
        self.dirty = True

    # --- Command Handling ---

    def handle_command(self, command, data):
        """Handles commands specific to the VirtualLCD."""
        if command == UDC_DEVICE_NEW:
            self.screen_buffer.fill(0)
            self.dirty = True

        elif command == UDC_DEVICE_MODE:
            self.mode = data
            
        elif command == UDC_DEVICE_COLOR:
            self.color = data

        elif command == UDC_DEVICE_X:
            self.x = data

        elif command == UDC_DEVICE_Y:
            self.y = data

        elif command == UDC_DEVICE_DRAW:
            if self.mode == 0: # Pixel Mode
                self.draw_pixel(self.x, self.y, data)
            else: # Block/Sprite Mode
                self.draw_sprite(self.x, self.y, data)
            self.dirty = True
            
        else:
            self.udc.post_error(self.channel, DEV_ERROR_DEVICE)

    # --- Drawing Logic ---

    def draw_pixel(self, x, y, color_index):
        """Draws a single pixel to the screen buffer."""
        if 0 <= x < self.width and 0 <= y < self.height:
            self.screen_buffer[y, x] = color_index

    def draw_sprite(self, block_x, block_y, sprite_index):
        """Draws an 8x8 sprite to the screen buffer."""
        sprite_key = str(sprite_index)
        if sprite_key not in self.sprites:
            print(f"Sprite with index {sprite_index} not found in ROM.")
            return

        bitmap = self.sprites[sprite_key]['bitmap']
        pixel_x_start = block_x * 8
        pixel_y_start = block_y * 8

        for i, row_bits in enumerate(bitmap):
            for j in range(8):
                if (row_bits >> (7 - j)) & 1:
                    px = pixel_x_start + j
                    py = pixel_y_start + i
                    if 0 <= px < self.width and 0 <= py < self.height:
                        self.screen_buffer[py, px] = self.color

    # --- Plotting Methods ---

    def init_plot(self):
        """Initializes the matplotlib window."""
        if self.fig: return
        
        plt.ion()
        self.fig, self.ax = plt.subplots(figsize=(self.width/100, self.height/100), dpi=100)
        self.fig.canvas.manager.set_window_title(f"Stern-XT Virtual LCD (Channel {self.channel})")

        # Hide toolbar and axes
        if self.fig.canvas.manager.toolmanager:
            self.fig.canvas.manager.toolmanager.remove_tool("navigation")
        elif self.fig.canvas.manager.toolbar:
            self.fig.canvas.manager.toolbar.pack_forget()
        self.ax.set_axis_off()

        # Define a 16-color map
        colors = [
            (0,0,0), (1,1,1), (1,0,0), (0,1,1), (0.5,0,0.5), (0,1,0), (0,0,1), (1,1,0),
            (1,0.5,0), (0.6,0.4,0.2), (1,0.4,0.4), (0.3,0.3,0.3), (0.5,0.5,0.5),
            (0.4,1,0.4), (0.4,0.4,1), (0.7,0.7,0.7)
        ]
        from matplotlib.colors import ListedColormap
        cmap = ListedColormap(colors)

        # Use imshow for efficient image rendering
        self.image = self.ax.imshow(self.screen_buffer, cmap=cmap, interpolation='nearest', vmin=0, vmax=15)
        
        self.fig.tight_layout(pad=0)
        self.fig.canvas.flush_events()

    def update_plot(self):
        """Updates the plot with the current screen buffer."""
        if not self.image: return
        self.image.set_data(self.screen_buffer)

    def close_plot(self):
        """Closes the matplotlib window."""
        if self.fig:
            plt.close(self.fig)
        self.fig = None
        self.ax = None
        self.image = None

    # --- Helper Methods ---
    
    def load_sprite_rom(self):
        """Loads sprites from the JSON ROM file."""
        rom_path = os.path.join(os.path.dirname(__file__), 'lcd_sprites.json')
        try:
            with open(rom_path, 'r') as f:
                data = json.load(f)
                self.sprites = data.get("sprites", {})
        except (FileNotFoundError, json.JSONDecodeError):
            # If the file doesn't exist or is invalid, continue with no sprites
            self.sprites = {}







# --- Selftest ---

class MockUDC:
    def post_error(self, channel, error_code):
        print(f"UDC Error on channel {channel}: {error_code}")

if __name__ == '__main__':
    print("Starting Virtual LCD Selftest...")

    # 1. Setup
    mock_udc = MockUDC()
    lcd = VirtualLCD(udc=mock_udc, channel=7)

    # 2. Initialize and bring online
    lcd.on_init() # Loads sprites
    lcd.on_online() # Creates plot
    print("LCD Online. Drawing...")

    # 3. Test Pixel Mode (Mode 0)
    lcd.handle_command(UDC_DEVICE_MODE, 0)
    # Draw a colorful square
    for y in range(100):
        for x in range(100):
            lcd.handle_command(UDC_DEVICE_X, 150 + x)
            lcd.handle_command(UDC_DEVICE_Y, 50 + y)
            lcd.handle_command(UDC_DEVICE_DRAW, (x + y) % 16)
    lcd.draw() # Update display
    plt.pause(5) # Show for 2 seconds

    # 4. Test Block/Sprite Mode (Mode 1)
    lcd.handle_command(UDC_DEVICE_NEW, 0) # Clear screen
    lcd.handle_command(UDC_DEVICE_MODE, 1)
    # Draw a pattern of sprites
    for i in range(10):
        for j in range(10):
            lcd.handle_command(UDC_DEVICE_COLOR, (i + j) % 16)
            lcd.handle_command(UDC_DEVICE_X, 5 + i)
            lcd.handle_command(UDC_DEVICE_Y, 5 + j)
            # Draw sprite '49' (the character '1')
            lcd.handle_command(UDC_DEVICE_DRAW, 49)
    lcd.draw()
    print("Sprite test. Displaying for 5 seconds...")
    plt.pause(5)

    # 5. Test Text Drawing
    lcd.handle_command(UDC_DEVICE_NEW, 0) # Clear screen
    lcd.handle_command(UDC_DEVICE_MODE, 1)
    lcd.handle_command(UDC_DEVICE_COLOR, 15) # A light color
    
    text_to_draw = "HELLO STERN XT WORLD!"
    start_x = 25
    start_y = 25
    
    char_x = start_x
    
    for char in text_to_draw:
        if char == ' ':
            char_x += 1
            continue
            
        sprite_index = ord(char)
        
        lcd.handle_command(UDC_DEVICE_X, char_x)
        lcd.handle_command(UDC_DEVICE_Y, start_y)
        lcd.handle_command(UDC_DEVICE_DRAW, sprite_index)
        
        char_x += 1
        
    lcd.draw()
    print("Text drawing test. Displaying for 5 seconds...")
    plt.pause(2)

    text_to_draw = "HELLO STERN XT WORLD!"
    start_x = 25
    start_y = 26
    
    char_x = start_x
    
    for char in text_to_draw:
        if char == ' ':
            char_x += 1
            continue
            
        sprite_index = ord(char)
        
        lcd.handle_command(UDC_DEVICE_X, char_x)
        lcd.handle_command(UDC_DEVICE_Y, start_y)
        lcd.handle_command(UDC_DEVICE_DRAW, sprite_index)
        
        char_x += 1
        
    lcd.draw()
    print("Text drawing test. Displaying for 5 seconds...")
    plt.pause(5)

    # 6. Display all sprites
    lcd.handle_command(UDC_DEVICE_NEW, 0) # Clear screen
    lcd.handle_command(UDC_DEVICE_MODE, 1)
    lcd.handle_command(UDC_DEVICE_COLOR, 1) # White

    sprite_keys = sorted(lcd.sprites.keys(), key=int)
    
    start_x = 1
    start_y = 1
    char_x = start_x
    char_y = start_y
    max_width = 80 - 2

    for key in sprite_keys:
        sprite_index = int(key)
        
        lcd.handle_command(UDC_DEVICE_X, char_x)
        lcd.handle_command(UDC_DEVICE_Y, char_y)
        lcd.handle_command(UDC_DEVICE_DRAW, sprite_index)
        
        char_x += 2
        if char_x >= max_width:
            char_x = start_x
            char_y += 2

    lcd.draw()
    print("Displaying all sprites for 5 seconds...")
    plt.pause(10)

    # 7. Test Offline/Cleanup
    lcd.on_offline()
    print("LCD Offline. Selftest complete.")