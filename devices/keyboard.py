import pygame

class Keyboard:
    """
    Simulates a keyboard peripheral. It listens for Pygame key events,
    writes the character's ASCII value to a specified memory address,
    and triggers an interrupt.
    """
    def __init__(self, memory, interrupt_controller, data_addr=4033, vector=0):
        self.memory = memory
        self.interrupt_controller = interrupt_controller
        self.data_addr = data_addr
        self.vector = vector

    def handle_key_event(self, event):
        """
        Processes a Pygame KEYDOWN event.
        """
        # We only care about key down events
        if event.type != pygame.KEYDOWN:
            return

        # Check if the key has a printable character representation
        if event.unicode:
            char_code = ord(event.unicode)
            print(f"Keyboard: Key '{event.unicode}' pressed (ASCII: {char_code}). Triggering interrupt vector {self.vector}.")
            
            # Write the character's ASCII value to the designated memory location
            self.memory.write(self.data_addr, char_code)
            
            # Trigger the interrupt on the controller
            self.interrupt_controller.trigger(self.vector)
