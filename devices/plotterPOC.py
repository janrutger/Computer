import matplotlib.pyplot as plt
import numpy as np


class Plotter:
    def __init__(self):
        self.plot_width   = 640
        self.plot_height = 480

        self.x_buffer = [1,2,3,4,5,6,7,8,9,10]
        self.y_buffer = [1,2,3,4,5,6,7,8,9,10]
        
        # --- Matplotlib Objects ---
        self.fig = None
        self.ax = None
        self.scatter = None


    def init_plot(self):
        plt.ion()
        self.fig, self.ax = plt.subplots()

        # --- Optional: Remove Toolbar ---
        if self.fig.canvas.manager.toolmanager:
            self.fig.canvas.manager.toolmanager.remove_tool("navigation")
        elif self.fig.canvas.manager.toolbar:
            self.fig.canvas.manager.toolbar.pack_forget()
        # --- End Remove ---

        self.scatter = self.ax.scatter([], [], s=1, marker='.', c='blue')

        # self.ax.set_title(f"XY Plotter (Channel {self.channel})")
        self.ax.set_xlabel("X Coordinate")
        self.ax.set_ylabel("Y Coordinate")

        # Add a small margin if desired, e.g., 5%
        margin_x = self.plot_width * 0.05
        margin_y = self.plot_height * 0.05
        self.ax.set_xlim(-margin_x, self.plot_width + margin_x)
        self.ax.set_ylim(-margin_y, self.plot_height + margin_y)

        #self.fig.canvas.draw_idle()
        self.fig.canvas.flush_events()

    def update_plot(self):
        # Combine x and y buffers into a 2D array of coordinates
        # This is the efficient way to update scatter plots
        offsets = np.c_[self.x_buffer, self.y_buffer]
        self.scatter.set_offsets(offsets)
        
        self.fig.canvas.draw_idle()
        self.fig.canvas.flush_events()

    def close_plot(self):
        if self.fig:
            plt.close(self.fig)
            self.fig = None


# plotter = Plotter()
# plotter.init_plot()
# N = 10
# while N != 0:
#     plotter.update_plot()
#     print(N)
#     N = N - 1