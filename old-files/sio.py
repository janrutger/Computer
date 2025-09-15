#!/usr/bin/env python
#
# SIO (Serial I/O) device placeholder
# This will eventually drive the y-plotter.

import threading

class SIO(threading.Thread):
    def __init__(self, memory, interrupt_controller, vector=1):
        super().__init__()
        self.memory = memory
        self.interrupt_controller = interrupt_controller
        self.vector = vector
        self.daemon = True
        self._running = True

    def run(self):
        while self._running:
            # In the future, this thread will check for commands in memory
            # written by the CPU and draw to the plotter window.
            pass

    def stop(self):
        self._running = False
