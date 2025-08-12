import threading
import queue

class InterruptController:
    """
    Manages and queues interrupt requests for the CPU.
    This ensures that rapid-fire interrupts are not lost.
    """
    def __init__(self, memory):
        # A thread-safe queue to hold incoming interrupt vectors and their associated data.
        self.pending_interrupts = queue.Queue()
        self.memory = memory
        # Dictionary to map interrupt vectors to their corresponding data memory addresses
        self.vector_data_addresses = {}
        
        # The CPU can set this to False to ignore all interrupts.
        self.master_enabled = True 

    def register_data_address(self, vector, address):
        """Registers a memory address where data for a specific interrupt vector should be written."""
        self.vector_data_addresses[vector] = address

    def trigger(self, vector, data=None):
        """Called by a peripheral to queue an interrupt with optional data."""
        if self.master_enabled:
            self.pending_interrupts.put((vector, data))

    def has_pending(self):
        """Lets the CPU check if any interrupts are waiting."""
        return not self.pending_interrupts.empty()

    def acknowledge(self):
        """
        Called by the CPU to get the next interrupt (vector, data) from the queue.
        Returns (None, None) if no interrupt is pending.
        """
        if not self.has_pending():
            return None, None
        try:
            # Get the next interrupt (vector, data) from the queue.
            return self.pending_interrupts.get_nowait()
        except queue.Empty:
            return None, None

    def handle_acknowledged_interrupt(self, vector, data):
        """
        Called by the CPU after acknowledging an interrupt.
        This method writes the associated data to the registered memory address.
        """
        if vector in self.vector_data_addresses and data is not None:
            self.memory.write(self.vector_data_addresses[vector], data)
