import time
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator, MultipleLocator
import numpy as np
from .UDC import UDCDevice, PLOTTER, UDC_DEVICE_NEW, UDC_DEVICE_SEND, UDC_DEVICE_FLIP, UDC_DEVICE_DRAW, UDC_DEVICE_COLOR, UDC_DEVICE_MODE, DEV_ERROR_DEVICE

# ======================================================================
# |
# |                        Y-Plotter Device                            |
# |
# ======================================================================

class Plotter(UDCDevice):
    """
    A Y-Plotter device that uses matplotlib to draw points.
    It receives Y values and increments its own internal X-counter for each point.
    It communicates with the CPU via the UDC.
    """
    def __init__(self, udc, channel):
        super().__init__(PLOTTER, udc, channel)
        self.plot_width = 640
        self.plot_height = 480
        
        self.x_buffer = []
        self.y_buffer = []
        self.color = 'blue'
        self.x_counter = 0

        self.dirty = True
        self.max_lenght = 1000     # was 1024, but 1000 reamains scaling
        self.last_draw_time = 0

        # --- Matplotlib Objects ---
        self.fig = None
        self.ax = None
        self.line = None

    def tick(self):
        """
        Main tick for the plotter. Handles UDC commands.
        """
        super().tick()

    def draw(self):
        """
        Keeps the matplotlib window responsive. This should be called frequently from the main loop.
        """
        current_time = time.time()
        # if current_time - self.last_draw_time < 1: # Only draw once every 1 second
        #     return

        if self.fig and self.dirty:
            try:
                self.update_plot()
                self.fig.canvas.draw_idle()
                # self.fig.canvas.draw()
                self.fig.canvas.flush_events()
                self.dirty = False
                self.last_draw_time = current_time
            except (AttributeError, TypeError):
                self.close_plot()

    # --- UDC Hooks ---

    def on_online(self):
        """When the plotter is brought online, create the plot window."""
        self.init_plot()

    def on_offline(self):
        """When the plotter is brought offline, close the plot window."""
        self.close_plot()

    def on_reset(self):
        """Resets the plotter state."""
        self.close_plot()
        self.x_buffer.clear()
        self.y_buffer.clear()
        self.color = 'blue'
        self.x_counter = 0

    # --- Command Handling ---

    def handle_command(self, command, data):
        """
        Handles commands specific to the Plotter.
        """
        if command == UDC_DEVICE_NEW:
            self.x_buffer.clear()
            self.y_buffer.clear()
            self.x_counter = 0
            #self.dirty = True
            #self.draw()

        elif command == UDC_DEVICE_SEND:
            # This is a Y value, X is the internal counter
            self.y_buffer.append(data)
            self.x_buffer.append(self.x_counter)
            self.x_counter += 1
            # self.dirty = True
        
        elif command == UDC_DEVICE_FLIP:
            self.dirty = True
            self.draw()

        elif command == UDC_DEVICE_DRAW:
            # This is a Y value, X is the internal counter
            self.y_buffer.append(data)
            self.x_buffer.append(self.x_counter)
            self.x_counter += 1
            self.dirty = True
            self.draw()


        elif command == UDC_DEVICE_COLOR:
            color_map = {0: 'black', 1: 'red', 2: 'green', 3: 'blue', 4: 'yellow', 5: 'magenta', 6: 'cyan', 7: 'white'}
            self.color = color_map.get(data, 'blue')
            if self.line:
                self.line.set_color(self.color) # Use self.line
                # self.dirty = True

        elif command == UDC_DEVICE_MODE:
            # Placeholder for future mode changes
            pass

        else:
            self.udc.post_error(self.channel, DEV_ERROR_DEVICE)

    # --- Plotting Methods ---

    def init_plot(self):
        """Initializes the matplotlib plot window."""
        if self.fig: return
        
        plt.ion()
        self.fig, self.ax = plt.subplots(figsize=(8, 5))
        self.fig.canvas.manager.set_window_title(f"Stern-XT Y-Plotter (Channel {self.channel})")

        if self.fig.canvas.manager.toolmanager:
            self.fig.canvas.manager.toolmanager.remove_tool("navigation")
        elif self.fig.canvas.manager.toolbar:
            self.fig.canvas.manager.toolbar.pack_forget()

        self.line, = self.ax.plot([], [], linestyle='none', markersize=4, marker='.', color=self.color)
        self.ax.set_title(f"PLOTTER")
        self.ax.set_xlabel("(X) Time")
        self.ax.set_ylabel("(Y) Value")

        self.ax.xaxis.set_major_locator(MaxNLocator(integer=True))
        # self.ax.xaxis.set_major_locator(MultipleLocator(10))
        self.ax.yaxis.set_major_locator(MaxNLocator(integer=True))

        self.ax.grid(True, linestyle='--', alpha=0.6)
        
        self.fig.canvas.flush_events()

    def update_plot(self):
        """Updates the scatter plot with the current buffer contents."""
        if not self.line: return

        # Use set_data for line plots
        self.line.set_data(self.x_buffer[-self.max_lenght:], self.y_buffer[-self.max_lenght:])

        # Adjust plot limits efficiently
        self.ax.relim() # Recalculate data limits based on the *current* line data
        #self.ax.autoscale_view(True, True, True)  # and quite CPU comsuming
        
        # Autoscale Y-axis and set X-axis to scroll with the data
        self.ax.autoscale_view(scalex=False, scaley=True)
        if self.x_buffer:
            x_min = self.x_buffer[-self.max_lenght] if len(self.x_buffer) > self.max_lenght else self.x_buffer[0]
            x_max = self.x_buffer[-1]
            self.ax.set_xlim(x_min, x_max + 1) # Add 1 for padding


    def close_plot(self):
        """Closes the matplotlib window if it exists."""
        if self.fig:
            plt.close(self.fig)
        self.fig = None
        self.ax = None
        self.line = None