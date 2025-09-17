import matplotlib.pyplot as plt
import numpy as np
from .UDC import UDCDevice, PLOTTER, UDC_DEVICE_NEW, UDC_DEVICE_SEND, UDC_DEVICE_COLOR, UDC_DEVICE_MODE, DEV_ERROR_DEVICE

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

        # --- Matplotlib Objects ---
        self.fig = None
        self.ax = None
        self.scatter = None

    def tick(self):
        """
        Main tick for the plotter. Handles UDC commands.
        """
        super().tick()

    def draw(self):
        """
        Keeps the matplotlib window responsive. This should be called frequently from the main loop.
        """
        if self.fig:
            try:
                self.fig.canvas.draw_idle()
                self.fig.canvas.flush_events()
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
            self.update_plot()

        elif command == UDC_DEVICE_SEND:
            # This is a Y value, X is the internal counter
            self.y_buffer.append(data)
            self.x_buffer.append(self.x_counter)
            self.x_counter += 1
            self.update_plot()

        elif command == UDC_DEVICE_COLOR:
            color_map = {0: 'black', 1: 'red', 2: 'green', 3: 'blue', 4: 'yellow', 5: 'magenta', 6: 'cyan', 7: 'white'}
            self.color = color_map.get(data, 'blue')
            if self.scatter:
                self.scatter.set_color(self.color)

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
        self.fig, self.ax = plt.subplots()
        self.fig.canvas.manager.set_window_title(f"Stern-XT Y-Plotter (Channel {self.channel})")

        if self.fig.canvas.manager.toolmanager:
            self.fig.canvas.manager.toolmanager.remove_tool("navigation")
        elif self.fig.canvas.manager.toolbar:
            self.fig.canvas.manager.toolbar.pack_forget()

        self.scatter = self.ax.scatter([], [], s=10, marker='x', c=self.color)
        self.ax.set_title(f"Y-Plotter")
        self.ax.set_xlabel("X (increment)")
        self.ax.set_ylabel("Y Value")

        margin_x = self.plot_width * 0.05
        margin_y = self.plot_height * 0.05
        self.ax.set_xlim(-margin_x, self.plot_width + margin_x)
        self.ax.set_ylim(-margin_y, self.plot_height + margin_y)
        self.ax.grid(True, linestyle='--', alpha=0.6)
        
        self.fig.canvas.flush_events()

    def update_plot(self):
        """Updates the scatter plot with the current buffer contents."""
        if not self.scatter: return
        
        min_len = min(len(self.x_buffer), len(self.y_buffer))
        offsets = np.c_[self.x_buffer[:min_len], self.y_buffer[:min_len]]
        
        self.scatter.set_offsets(offsets)

    def close_plot(self):
        """Closes the matplotlib window if it exists."""
        if self.fig:
            plt.close(self.fig)
        self.fig = None
        self.ax = None
        self.scatter = None