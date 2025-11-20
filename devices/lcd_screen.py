import time
import json
import os
import tkinter as tk
from PIL import Image, ImageTk
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
    UDC_DEVICE_FLIP, 
    DEV_ERROR_VALUE
)

class VirtualLCD(UDCDevice):
    """
    A Virtual LCD Screen device that uses tkinter and Pillow to render a 640x480 display.
    """
    def __init__(self, udc, channel):
        super().__init__(SCREEN, udc, channel)
        
        # --- Device Specifications ---
        self.width = 640
        self.height = 480
        self.scale = 1.0
        
        # --- Internal State ---
        self.x = 0
        self.y = 0
        self.mode = 0  # 0: Pixel, 1: Sprite, 2: Pixel (DB), 3: Sprite (DB)
        self.color = 0 # Default color index
        
        # --- Screen Buffers ---
        self.screen_buffer = np.zeros((self.height, self.width), dtype=np.uint8)
        self.shadow_buffer = np.zeros((self.height, self.width), dtype=np.uint8)
        
        # --- Sprite ROM ---
        self.sprites = {}
        
        # --- Tkinter Objects ---
        self.window = None
        self.canvas = None
        self.photo_image = None
        self.dirty = True

        # --- Color Palette (for PIL) ---
        # RGB values for the 16-color palette
        self.palette_data = [
            0,0,0, 255,255,255, 255,0,0, 0,255,255, 128,0,128, 0,255,0, 0,0,255, 255,255,0,
            255,128,0, 153,102,51, 255,102,102, 76,76,76, 128,128,128,
            102,255,102, 102,102,255, 178,178,178
        ]
        # Pad palette to 256 colors (768 values) as required by PIL's 'P' mode
        self.palette_data.extend([0] * (768 - len(self.palette_data)))

    def tick(self):
        """Main tick for the LCD. Handles UDC commands."""
        super().tick()

    def draw(self):
        """Draws the screen buffer to the tkinter window if it's dirty."""
        if not self.window or not self.dirty:
            return

        try:
            # Create a PIL image from the numpy buffer in Palette mode
            img = Image.fromarray(self.screen_buffer, mode='P')
            img.putpalette(self.palette_data)

            # Scale the image if a scale factor is set
            if self.scale != 1.0:
                new_size = (int(self.width * self.scale), int(self.height * self.scale))
                img = img.resize(new_size, Image.NEAREST)

            # Convert to a PhotoImage that tkinter can display
            self.photo_image = ImageTk.PhotoImage(image=img)

            # Update the canvas with the new image
            self.canvas.create_image(0, 0, image=self.photo_image, anchor=tk.NW)
            self.window.update()
            self.dirty = False
        except Exception as e:
            # This can happen if the window is closed while drawing
            print(f"Info: Could not draw to LCD window: {e}")
            self.close_tkinter_window()

    # --- UDC Hooks ---

    def on_init(self):
        """Loads the sprite ROM when the device is initialized."""
        self.load_sprite_rom()

    def on_online(self):
        """When the device is brought online, create the tkinter window."""
        self.init_tkinter_window()

    def on_offline(self):
        """When the device is brought offline, close the tkinter window."""
        self.close_tkinter_window()

    def on_reset(self):
        """Resets the device state."""
        self.close_tkinter_window()
        self.screen_buffer.fill(0)
        self.shadow_buffer.fill(0)
        self.x = 0
        self.y = 0
        self.mode = 0
        self.color = 0
        self.dirty = True

    # --- Command Handling (Unchanged) ---

    def handle_command(self, command, data):
        """Handles commands specific to the VirtualLCD."""
        if command == UDC_DEVICE_NEW:
            self.x = 0
            self.y = 0
            if self.mode in [2, 3]: # Double buffer modes
                self.shadow_buffer.fill(0)
                #self.screen_buffer.fill(0)
                self.dirty = True
            else: # Direct modes
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
            if self.mode in [0, 2]: # Pixel Modes
                self.draw_pixel(self.x, self.y, data)
            else: # Block/Sprite Modes
                self.draw_sprite_new(self.x, self.y, data)
            if self.mode not in [2, 3]:
                self.dirty = True
        elif command == UDC_DEVICE_FLIP:
            if self.mode in [2, 3]:
                np.copyto(self.screen_buffer, self.shadow_buffer)
                self.dirty = True
            else:
                self.udc.post_error(self.channel, DEV_ERROR_VALUE)
        else:
            self.udc.post_error(self.channel, DEV_ERROR_DEVICE)

    # --- Drawing Logic (Unchanged) ---

    def draw_pixel(self, x, y, color_index):
        """Draws a single pixel to the appropriate buffer."""
        buffer = self.shadow_buffer if self.mode in [2, 3] else self.screen_buffer
        if 0 <= x < self.width and 0 <= y < self.height:
            buffer[y, x] = color_index

    def draw_sprite_new(self, block_x, block_y, sprite_index):
        """Draws an 8x8 sprite to the appropriate buffer using numpy for efficiency."""
        buffer = self.shadow_buffer if self.mode in [2, 3] else self.screen_buffer
        sprite_key = str(sprite_index)
        if sprite_key not in self.sprites:
            return

        bitmap = self.sprites[sprite_key]['bitmap']
        sprite_mask = np.unpackbits(np.array(bitmap, dtype=np.uint8)[:, np.newaxis], axis=1)
        x_start, y_start = block_x * 8, block_y * 8
        x_end, y_end = x_start + 8, y_start + 8

        if x_end <= 0 or x_start >= self.width or y_end <= 0 or y_start >= self.height:
            return

        src_x_start, src_y_start = max(0, -x_start), max(0, -y_start)
        dst_x_start, dst_y_start = max(0, x_start), max(0, y_start)
        width = min(x_end, self.width) - dst_x_start
        height = min(y_end, self.height) - dst_y_start

        if width <= 0 or height <= 0: return

        sprite_part = sprite_mask[src_y_start:src_y_start+height, src_x_start:src_x_start+width]
        screen_slice = buffer[dst_y_start:dst_y_start+height, dst_x_start:dst_x_start+width]
        updated_slice = np.where(sprite_part == 1, self.color, screen_slice)
        buffer[dst_y_start:dst_y_start+height, dst_x_start:dst_x_start+width] = updated_slice

    # --- New Tkinter Window Methods ---

    def init_tkinter_window(self):
        """Initializes the tkinter window."""
        if self.window: return
        
        # This setup is to ensure tkinter plays nice when it's not the main GUI
        if tk._default_root is None:
            root = tk.Tk()
            root.withdraw()
        
        self.window = tk.Toplevel()
        self.window.title(f"Stern-XT Virtual LCD (Channel {self.channel})")
        self.window.resizable(False, False)
        self.window.protocol("WM_DELETE_WINDOW", self.close_tkinter_window)

        window_width = int(self.width * self.scale)
        window_height = int(self.height * self.scale)
        self.canvas = tk.Canvas(self.window, width=window_width, height=window_height, borderwidth=0, highlightthickness=0)
        self.canvas.pack()
        self.dirty = True

    def close_tkinter_window(self):
        """Closes the tkinter window."""
        if self.window:
            self.window.destroy()
        self.window = None
        self.canvas = None
        self.photo_image = None

    # --- Helper Methods (Unchanged) ---
    
    def load_sprite_rom(self):
        """Loads sprites from the JSON ROM file."""
        rom_path = os.path.join(os.path.dirname(__file__), 'lcd_sprites.json')
        try:
            with open(rom_path, 'r') as f:
                self.sprites = json.load(f).get("sprites", {})
        except (FileNotFoundError, json.JSONDecodeError):
            self.sprites = {}

# --- Selftest (Updated for Tkinter) ---

class MockUDC:
    def post_error(self, channel, error_code):
        print(f"UDC Error on channel {channel}: {error_code}")

if __name__ == '__main__':
    print("Starting Virtual LCD Selftest...")
    mock_udc = MockUDC()
    lcd = VirtualLCD(udc=mock_udc, channel=7)

    def run_test(title, duration_sec):
        print(title)
        lcd.draw()
        end_time = time.time() + duration_sec
        while time.time() < end_time:
            if lcd.window:
                lcd.window.update()
            time.sleep(0.01)

    lcd.on_init()
    lcd.on_online()
    print("LCD Online. Drawing...")

    # Test Pixel Mode
    lcd.handle_command(UDC_DEVICE_MODE, 0)
    for y in range(100):
        for x in range(100):
            lcd.handle_command(UDC_DEVICE_X, 150 + x)
            lcd.handle_command(UDC_DEVICE_Y, 50 + y)
            lcd.handle_command(UDC_DEVICE_DRAW, (x + y) % 16)
    run_test("Pixel test. Displaying for 5 seconds...", 5)

    # Test Sprite Mode
    lcd.handle_command(UDC_DEVICE_NEW, 0)
    lcd.handle_command(UDC_DEVICE_MODE, 1)
    lcd.handle_command(UDC_DEVICE_COLOR, 15)
    text_to_draw = "HELLO TKINTER WORLD!"
    for i, char in enumerate(text_to_draw):
        lcd.handle_command(UDC_DEVICE_X, 25 + i)
        lcd.handle_command(UDC_DEVICE_Y, 25)
        lcd.handle_command(UDC_DEVICE_DRAW, ord(char))
    run_test("Text drawing test. Displaying for 5 seconds...", 5)

    # --- Character Set Test ---
    lcd.handle_command(UDC_DEVICE_NEW, 0)
    lcd.handle_command(UDC_DEVICE_MODE, 1)
    lcd.handle_command(UDC_DEVICE_COLOR, 15)
    for i in range(256):
        char_x = (i % 32) * 2 + 5
        char_y = (i // 32) * 2 + 5
        lcd.handle_command(UDC_DEVICE_X, char_x)
        lcd.handle_command(UDC_DEVICE_Y, char_y)
        lcd.handle_command(UDC_DEVICE_DRAW, i)
    run_test("Character set test. Displaying for 5 seconds...", 5)

    # --- Color Palette Test ---
    lcd.handle_command(UDC_DEVICE_NEW, 0)
    lcd.handle_command(UDC_DEVICE_MODE, 0)
    for c in range(16):
        col = c % 4
        row = c // 4
        start_x = col * 120 + 80
        start_y = row * 100 + 40
        for y in range(start_y, start_y + 80):
            for x in range(start_x, start_x + 100):
                lcd.handle_command(UDC_DEVICE_X, x)
                lcd.handle_command(UDC_DEVICE_Y, y)
                lcd.handle_command(UDC_DEVICE_DRAW, c)
    run_test("Color palette test. Displaying for 5 seconds...", 5)


    lcd.on_offline()
    print("LCD Offline. Selftest complete.")