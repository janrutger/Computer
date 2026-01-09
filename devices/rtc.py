import time

class RTC:
    """
    Simulates a Real Time Clock (RTC) for the Stern-XT computer.
    The RTC generates an interrupt every 0.2 seconds, providing a time value
    that represents the current time scaled to milliseconds, with a rollover
    period of approximately one month.
    """

    def __init__(self, interrupt_controller, vector=1):
        self.interrupt_controller = interrupt_controller
        self.vector = vector

        self.last_interrupt_time = 0
        self.interrupt_interval = 0.2  # 200 miliseconds

        # We will represent time in milliseconds.
        self.scale_factor = 1000

        # Calculate the rollover value for approximately 31 days in milliseconds.
        # 31 days * 24 hours/day * 60 minutes/hour * 60 seconds/minute * 1000 ms/second
        self.rollover_period_ms = 31 * 24 * 60 * 60 * self.scale_factor

    def tick(self):
        current_time = time.time()
        if current_time - self.last_interrupt_time >= self.interrupt_interval:
            # Scale the current time to milliseconds
            scaled_time = int(current_time * self.scale_factor)

            # Apply the rollover
            time_value = scaled_time % self.rollover_period_ms

            self.interrupt_controller.trigger(self.vector, time_value)
            self.last_interrupt_time = current_time

            # for debug reasons
            # print(f"RTC interrupt! Time value: {time_value}")