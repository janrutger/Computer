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
DEV_ERROR_UNKOWN    = 0     # an none specific error
DEV_ERROR_DEVICE    = 1     # incorrect device request
DEV_ERROR_VALUE     = 2     # invalid value for this device
DEV_ERROR_INDEX     = 3     # unknown idex value for this device

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


# Device type defintion
GENERIC_TYPE        = 0     # the generic instructions
YPLOT_TYPE          = 1     # Type is an Y-plotter
XYPLOT_TYPE         = 2     # Type is an XY-plotter
SENSOR_TYPE         = 3     # Type is an sensor


class UDC:
    def __init__(self, memory, baseadres):
        self.memory     = memory
        self.baseadres  = baseadres

        self.channels       = 8         # max number of channel

        # Send Caches for each channel
        self.cpu_snd_cache = [deque(maxlen=256) for _ in range(self.channels)]
        self.cpu_rcv_cache = [deque(maxlen=256) for _ in range(self.channels)]
        

        # easy find the device components
        self.device_types = [YPLOT_TYPE, XYPLOT_TYPE, SENSOR_TYPE]
        self.device_type_instructions = {}

        self.device_type_instructions[GENERIC_TYPE] = [UDC_DEVICE_INIT, UDC_DEVICE_ONLINE, UDC_DEVICE_OFFLINE, UDC_DEVICE_RESET]
        self.device_type_instructions[YPLOT_TYPE]   = [UDC_DEVICE_NEW, UDC_DEVICE_SEND, UDC_DEVICE_COLOR]
        self.device_type_instructions[XYPLOT_TYPE]  = [UDC_DEVICE_NEW, UDC_DEVICE_SEND, UDC_DEVICE_COLOR]
        self.device_type_instructions[SENSOR_TYPE]  = [UDC_DEVICE_GET]


        # setting up registers
        self.channel_register              = baseadres + 0
        self.status_register               = baseadres + 1
        self.command_register              = baseadres + 2
        self.data_register                 = baseadres + 3

        self.device_type_0                = baseadres + 4
        self.device_type_1                = baseadres + 5
        self.device_type_2                = baseadres + 6
        self.device_type_3                = baseadres + 7
        self.device_type_4                = baseadres + 8
        self.device_type_5                = baseadres + 9
        self.device_type_6                = baseadres + 10
        self.device_type_7                = baseadres + 11
        
        self.memory.write(self.command_register, -1)
        self.memory.write(self.device_type_0, GENERIC_TYPE)
        self.memory.write(self.device_type_1, GENERIC_TYPE)
        self.memory.write(self.device_type_2, GENERIC_TYPE)
        self.memory.write(self.device_type_3, GENERIC_TYPE)
        self.memory.write(self.device_type_4, GENERIC_TYPE)
        self.memory.write(self.device_type_5, GENERIC_TYPE)
        self.memory.write(self.device_type_6, GENERIC_TYPE)
        self.memory.write(self.device_type_7, GENERIC_TYPE)

        self.memory.write(self.status_register, UDC_WAITING)

    


    def tick(self):
        if self.memory.read(self.status_register) == UDC_WAITING:
            return          # there is nothing to do
        
        channel = self.memory.read(self.channel_register)
        status  = self.memory.read(self.status_register)
        command = self.memory.read(self.command_register)
        data    = self.memory.read(self.data_register)

        device_type = self.memory.read(self.device_type_0 + channel)

        # Check the channel register
        if not (0 <= channel < self.channels):
            self.memory.write(self.status_register, UDC_ERROR_UDC)
            self.memory.write(self.data_register, DEV_ERROR_INDEX)
            return
        
        # Check the status register
        # If status is UDC_CPU_WAITING, then do so
        # assembly an outgoing packace and place on the correct send queue
        if status == UDC_CPU_WAITING:
            if command in self.device_type_instructions[GENERIC_TYPE]:
                if command == UDC_DEVICE_INIT:
                    self.cpu_snd_cache[channel].append((command, data))
                    self.memory.write(self.status_register, UDC_WAITING)
                elif command == UDC_DEVICE_ONLINE:
                    self.cpu_snd_cache[channel].append((command, data))
                    self.memory.write(self.status_register, UDC_WAITING)
                elif command == UDC_DEVICE_OFFLINE:
                    self.cpu_snd_cache[channel].append((command, data))
                    self.memory.write(self.status_register, UDC_WAITING)
                elif command == UDC_DEVICE_RESET:
                    self.cpu_snd_cache[channel].append((command, data))
                    self.memory.write(self.status_register, UDC_WAITING)
            elif command in self.device_type_instructions[device_type]:
                self.cpu_snd_cache[channel].append((command, data))
                self.memory.write(self.status_register, UDC_WAITING)
            else:
                self.memory.write(self.status_register, UDC_ERROR_UDC)
                self.memory.write(self.data_register, DEV_ERROR_DEVICE)
                return
            





