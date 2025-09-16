import random
from .UDC import UDCDevice, SENSOR_TYPE, UDC_DEVICE_GET, DEV_ERROR_DEVICE

# ======================================================================
# |                                                                    |
# |                      Example Sensor Device                         |
# |                                                                    |
# ======================================================================

class Sensor(UDCDevice):
    """
    A simple sensor device that returns a random value when read.
    """
    def __init__(self, udc, channel):
        # Call the parent class's __init__ to set up the device type and UDC connection
        super().__init__(SENSOR_TYPE, udc, channel)
        self._internal_value = 0

    def tick(self):
        # First, run the standard base class tick to handle incoming commands
        super().tick()
        
        # A device can also have its own logic that runs on every tick.
        # Here, we simulate a fluctuating sensor reading.
        if self.online:
            # Update value occasionally
            if random.random() < 0.1: 
                self._internal_value = random.randint(0, 255)

    def handle_command(self, command, data):
        """
        Handles commands specific to the Sensor.
        """
        if command == UDC_DEVICE_GET:
            # The CPU is requesting our value. Post it to the UDC receive cache.
            self.udc.post_data(self.channel, self._internal_value)
        else:
            # This device is online but received a command it doesn't support.
            self.udc.post_error(self.channel, DEV_ERROR_DEVICE)