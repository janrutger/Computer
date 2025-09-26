from collections import deque

# Define the UDC status Register values
UDC_WAITING         = 0     # default status after powerup
                            # UDC waits for the CPU 
UDC_CPU_WAITING     = 1     # CPU set the Command.register and Value.register
                            # and set status.register, and waits for ack by UDC_WAITING
UDC_UDC_WAITING     = 2     # UDC is waiting for an responce of the device
                            # eg. device type, or an sensor value, when the CPU ask for it
                            # CPU must wait before new command can be send
UDC_ERROR_UDC       = 3     # for exceptions in the UDC logic
UDC_ERROR_DEVICE    = 4     # for exceptions in the device logic
                            # value.register shows the error code

# Known device errors
DEV_ERROR_UNKNOWN   = 0     # an none specific error
DEV_ERROR_DEVICE    = 1     # incorrect device request
DEV_ERROR_VALUE     = 2     # invalid value for this device
DEV_ERROR_INDEX     = 3     # unknown idex value for this device
DEV_ERROR_OFFLINE   = 4     # device is offline

# Generic UDC commands, not devicetype specific
UDC_DEVICE_INIT     = 0     # to initialize the device and get the Devicce_type
UDC_DEVICE_ONLINE   = 1     # to set an device online
UDC_DEVICE_OFFLINE  = 2     # to set an device offline
UDC_DEVICE_RESET    = 3     # to reset an device, after reset the device must be re-init


# All UDC device command, as complete list
UDC_DEVICE_NEW      = 10    # The CPU request to start over, like an new plot
UDC_DEVICE_SEND     = 11    # The CPU send 'just' data to the device
UDC_DEVICE_GET      = 12    # The CPU request data from the device, the value register can give an argumment
UDC_DEVICE_COLOR    = 13    # Sets color of something, like the color of the plotted dot
UDC_DEVICE_MODE     = 14    # sets the device in a mode, eg Yplotter/XYplotter, 
UDC_DEVICE_X        = 15    # sets the X-ax parameter of the device
UDC_DEVICE_Y        = 16    # sets the Y-ax parameter of the device
UDC_DEVICE_DRAW     = 17    # Draw the XY-point on the device
UDC_DEVICE_FLIP     = 18    # Flips screenbuffer in dual buffer mode


# Device type defintion
GENERIC         = 0  # generic type
PLOTTER         = 1  # A plotter
SENSOR          = 2  # A sensor
SCREEN          = 3  # A screen (like an virtual 480x640 screen)



class UDC:
    def __init__(self, memory, baseadres):
        self.memory     = memory
        self.baseadres  = baseadres

        self.channels       = 8         # max number of channel

        # Send Caches for each channel
        self.cpu_snd_caches = [deque(maxlen=256) for _ in range(self.channels)]
        self.cpu_rcv_caches = [deque(maxlen=256) for _ in range(self.channels)]
        

        # easy find the device components
        self.device_types = [GENERIC, PLOTTER, SENSOR, SCREEN]
        self.device_type_instructions = {}

        self.device_type_instructions[GENERIC]   = [UDC_DEVICE_INIT, UDC_DEVICE_ONLINE, UDC_DEVICE_OFFLINE, UDC_DEVICE_RESET]
        self.device_type_instructions[PLOTTER]   = [UDC_DEVICE_NEW, UDC_DEVICE_SEND, UDC_DEVICE_COLOR, UDC_DEVICE_MODE]
        self.device_type_instructions[SENSOR]    = [UDC_DEVICE_GET]
        self.device_type_instructions[SCREEN]    = [UDC_DEVICE_NEW, UDC_DEVICE_DRAW, UDC_DEVICE_COLOR, UDC_DEVICE_MODE, UDC_DEVICE_X, UDC_DEVICE_Y, UDC_DEVICE_FLIP]



        # setting up registers
        self.channel_register              = baseadres + 0
        self.status_register               = baseadres + 1
        self.command_register              = baseadres + 2
        self.data_register                 = baseadres + 3

        self.device_type_registers = [baseadres + 4 + i for i in range(self.channels)]
        
        self.memory.write(self.command_register, -1)
        for i in range(self.channels):
            self.memory.write(self.device_type_registers[i], GENERIC)
        self.memory.write(self.status_register, UDC_WAITING)

    # --- Public API for Devices ---

    def get_command(self, channel):
        """Called by a device to get the next command from its queue."""
        if self.cpu_snd_caches[channel]:
            return self.cpu_snd_caches[channel].popleft()
        return None

    def post_data(self, channel, data):
        """Called by a device to post data to the CPU's receive queue."""
        self.cpu_rcv_caches[channel].append(data)
    
    def post_error(self, channel, error_code):
        """Called by a device to post an error."""
        self.memory.write(self.status_register, UDC_ERROR_DEVICE)
        self.memory.write(self.data_register, error_code)

    # --- Main simulation tick ---

    def tick(self):
        status = int(self.memory.read(self.status_register))
        if status == UDC_WAITING:
            return
        
        channel = int(self.memory.read(self.channel_register))
        
        if not (0 <= channel < self.channels):
            self.memory.write(self.status_register, UDC_ERROR_UDC)
            self.memory.write(self.data_register, DEV_ERROR_INDEX)
            return

        if status == UDC_CPU_WAITING:
            command = int(self.memory.read(self.command_register))
            data    = int(self.memory.read(self.data_register))
            
            if command == UDC_DEVICE_RESET:
                self.memory.write(self.device_type_registers[channel], GENERIC)
                self.cpu_snd_caches[channel].append((command, data))
                self.memory.write(self.status_register, UDC_WAITING)
                return

            device_type = int(self.memory.read(self.device_type_registers[channel]))
            is_generic = command in self.device_type_instructions[GENERIC]
            is_valid_for_type = device_type in self.device_type_instructions and \
                                command in self.device_type_instructions[device_type]

            if is_generic or is_valid_for_type:
                self.cpu_snd_caches[channel].append((command, data))
                if command == UDC_DEVICE_GET or command == UDC_DEVICE_INIT:
                    self.memory.write(self.status_register, UDC_UDC_WAITING)
                else:
                    self.memory.write(self.status_register, UDC_WAITING)
                    self.memory.write(self.data_register, 0)
            else:
                self.memory.write(self.status_register, UDC_ERROR_DEVICE)
                self.memory.write(self.data_register, DEV_ERROR_DEVICE)
            return

        elif status == UDC_UDC_WAITING:
            if self.cpu_rcv_caches[channel]:
                data_from_device = self.cpu_rcv_caches[channel].popleft()
                original_command = int(self.memory.read(self.command_register))
                
                if original_command == UDC_DEVICE_INIT:
                    self.memory.write(self.device_type_registers[channel], data_from_device)
                else:
                    self.memory.write(self.data_register, data_from_device)
                
                self.memory.write(self.status_register, UDC_WAITING)
            return
        
        else:
            self.memory.write(self.status_register, UDC_ERROR_UDC)


# ======================================================================
#                                                                      #
#                       UDC Device Base Class                          #
#                                                                      #
# ======================================================================

class UDCDevice:
    """
    Base class for all Universal Device Controller (UDC) compatible devices.
    It handles the common logic for communicating with the UDC.
    """
    def __init__(self, device_type, udc, channel):
        self.device_type = device_type
        self.udc = udc
        self.channel = channel
        self.initialized = False
        self.online = False

    def tick(self):
        """
        Main device loop. Called by the simulator on every cycle.
        Checks for commands from the UDC and processes them.
        It processes multiple commands per tick to improve performance, but stops
        for commands that require synchronization with the CPU.
        """
        # Process up to 256 commands from the queue per tick to avoid blocking the GUI loop for too long.
        for _ in range(256):
            command_tuple = self.udc.get_command(self.channel)
            if not command_tuple:
                # No more commands in the queue for this tick.
                return

            command, data = command_tuple
            
            # --- Handle Generic Commands ---
            # These commands change the device's state in a fundamental way,
            # so we process one and return, allowing the CPU to react.
            if command == UDC_DEVICE_INIT:
                self.initialized = True
                self.online = False
                self.udc.post_data(self.channel, self.device_type)
                self.on_init()
                return
            
            if command == UDC_DEVICE_ONLINE:
                if self.initialized:
                    self.online = True
                    self.on_online()
                else:
                    self.udc.post_error(self.channel, DEV_ERROR_DEVICE)
                return

            if command == UDC_DEVICE_OFFLINE:
                self.online = False
                self.on_offline()
                return

            if command == UDC_DEVICE_RESET:
                self.online = False
                self.initialized = False
                self.on_reset()
                return

            # --- Handle Device-Specific Commands ---
            if not self.online:
                # Device must be online for device-specific commands.
                self.udc.post_error(self.channel, DEV_ERROR_OFFLINE)
                # Stop processing and let the CPU bring the device online first.
                return

            self.handle_command(command, data)

            # UDC_DEVICE_GET is a synchronizing command that requires the device
            # to post data and wait for the CPU. Stop processing more commands.
            if command == UDC_DEVICE_GET:
                return

    def handle_command(self, command, data):
        """
        To be implemented by subclasses. This method is called when a
        device-specific command is received.
        """
        raise NotImplementedError("Subclasses must implement handle_command")

    

    def on_init(self):
        """Can be overridden by subclasses for custom logic when brought online."""
        pass

    def on_online(self):
        """Can be overridden by subclasses for custom logic when brought online."""
        pass

    def on_offline(self):
        """Can be overridden by subclasses for custom logic when brought online."""
        pass

    def on_reset(self):
        """
        Can be overridden by subclasses for custom reset logic.
        """
        pass
