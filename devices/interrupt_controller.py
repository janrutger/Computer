import threading
import queue

class InterruptController:
    """
    Manages and queues interrupt requests for the CPU.
    This ensures that rapid-fire interrupts are not lost.
    """
    def __init__(self):
        # A thread-safe queue to hold incoming interrupt vectors.
        self.pending_interrupts = queue.Queue()
        
        # The CPU can set this to False to ignore all interrupts.
        self.master_enabled = True 

    def trigger(self, vector):
        """Called by a peripheral to queue an interrupt."""
        if self.master_enabled:
            self.pending_interrupts.put(vector)

    def has_pending(self):
        """Lets the CPU check if any interrupts are waiting."""
        return not self.pending_interrupts.empty()

    def acknowledge(self):
        """
        Called by the CPU to get the next interrupt from the queue.
        Returns None if no interrupt is pending.
        """
        if not self.has_pending():
            return None
        try:
            # Get the next interrupt from the queue.
            return self.pending_interrupts.get_nowait()
        except queue.Empty:
            return None
