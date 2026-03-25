import socket
import struct
import argparse
import time
import random

# Constants from Sternnet Architecture
HEADER_FORMAT = '!IIII' # Big-Endian, 16 bytes: DEST(4), SRC(4), PORT(4), CONTROL(4)
HEADER_SIZE = struct.calcsize(HEADER_FORMAT)
INTERRUPT_VECTOR = 2

class VirtualNIC:
    """
    Emulates the Sternnet vNIC hardware device.
    It is a memory-mapped device that communicates with the host OS via UDP
    and with the guest OS (Stacks) via "ring buffers" in shared RAM.
    """

    def __init__(self, ram, interrupt_controller, base_address, nic_address, switch_addr=('127.0.0.1', 8888)):
        # System components
        self.ram = ram
        self.interrupt_controller = interrupt_controller
        self.base_address = base_address
        self.nic_address = nic_address
        self.switch_addr = switch_addr
        self.is_connected = False

        # MMIO Register Offsets from base_address
        # Matching Sternnet_vNIC_Spec.md
        self.REG_STATUS  = 0 # R: Bit 0=LINK_UP
        self.REG_CMD     = 1 # W: 1=RESET, 2=ENABLE
        self.REG_ADDR    = 2 # R/W: Node ID
        self.REG_RX_BASE = 3 # R/W: RX Ring Ptr
        self.REG_RX_HEAD = 4 # R: RX Head (Written by NIC)
        self.REG_RX_TAIL = 5 # R/W: RX Tail (Written by Driver)
        self.REG_TX_BASE = 6 # R/W: TX Ring Ptr
        self.REG_TX_HEAD = 7 # R/W: TX Head (Written by Driver)
        self.REG_TX_TAIL = 8 # R: TX Tail (Written by NIC)
        self.REG_RING_SZ = 9 # R/W: Ring Size

        # UDP Socket setup
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.sock.setblocking(False)
        # Bind to a random port to allow multiple NICs on one machine
        self.sock.bind(('127.0.0.1', 0))
        print(f"vNIC({hex(self.nic_address)}): Bound to UDP {self.sock.getsockname()}")
        
        # Initialize the status register. All bits are off (LINK_DOWN, etc.)
        self.ram.write(self.base_address + self.REG_STATUS, 0)
        self.ram.write(self.base_address + self.REG_ADDR, self.nic_address)

        # "Connect" the UDP socket. This doesn't create a persistent connection,
        # but it tells the OS our default destination. This allows the OS
        # to report errors like "Connection Refused" if the switch is down.
        self.sock.connect(self.switch_addr)

        # Send HELLO to register with switch immediately
        self._send_hello()

    def _send_hello(self):
        """Sends a broadcast HELLO packet to announce presence to the vSwitch."""
        try:
            # Format: DEST (0 = Management), SRC (My Address)
            # Sending to address 0 allows the switch to learn our location without disturbing other hosts.
            hello_packet = struct.pack(HEADER_FORMAT, 0x00000000, self.nic_address, 0, 0)
            # Use send() now that the socket is "connected"
            self.sock.send(hello_packet)
            # If send was successful, update the status register with the LINK_UP bit.
            current_status = self.ram.read(self.base_address + self.REG_STATUS)
            self.ram.write(self.base_address + self.REG_STATUS, current_status | 1) # Set LINK_UP bit (Bit 0)
            self.is_connected = True
        except ConnectionRefusedError:
            # This error is now catchable because the socket is connected.
            print(f"vNIC WARN: Connection to vSwitch at {self.switch_addr} refused. Network might be down.")
        except Exception as e:
            print(f"vNIC ERROR: An unexpected error occurred during network init: {e}")

    def tick(self):
        """
        Called periodically by the main emulator loop.
        Handles sending and receiving packets.
        """
        # Detect host address changes in the MMIO register (e.g. from SOCKET.init)
        current_reg_addr = self.ram.read(self.base_address + self.REG_ADDR)
        if current_reg_addr != self.nic_address:
            self.nic_address = current_reg_addr
            self._send_hello()

        # 1. Always poll the socket to catch errors (like ConnectionRefused)
        #    and to drain the OS buffer even if the NIC is disabled (drop packets).
        data = None
        try:
            data, addr = self.sock.recvfrom(1500)
        except BlockingIOError:
            pass # Normal case, no data
        except ConnectionRefusedError:
            if self.is_connected:
                print(f"vNIC WARN: Connection to vSwitch at {self.switch_addr} refused. Network is down.")
                self.is_connected = False
                # Update Link Status (Clear Bit 0)
                status = self.ram.read(self.base_address + self.REG_STATUS)
                self.ram.write(self.base_address + self.REG_STATUS, status & ~1)
            return
        except Exception as e:
            print(f"vNIC ERROR: Socket error: {e}")
            return

        # 2. Check if NIC is Enabled via MMIO
        cmd = self.ram.read(self.base_address + self.REG_CMD)
        if cmd != 2: # 2 = ENABLE
            return # NIC is disabled, ignore any received data

        self._process_tx()
        if data:
            self._process_rx_dma(data)

    def _process_tx(self):
        """
        Checks the TX ring buffer for packets to send.
        This implements the consumer side of a circular buffer.
        """
        tx_head = self.ram.read(self.base_address + self.REG_TX_HEAD)
        tx_tail = self.ram.read(self.base_address + self.REG_TX_TAIL)
        ring_size = self.ram.read(self.base_address + self.REG_RING_SZ)
        tx_base = self.ram.read(self.base_address + self.REG_TX_BASE)

        # Process all packets queued by the driver in a single tick
        while tx_head != tx_tail:
            if not tx_base or ring_size == 0: return

            # 1. Read packet length from the ring at the current tail
            len_addr = tx_base + tx_tail
            packet_len = self.ram.read(len_addr)

            # Advance tail past the length byte for data reading
            current_tail = (tx_tail + 1) % ring_size

            # 2. Read the packet data from the ring
            packet_bytes = bytearray()
            for _ in range(packet_len):
                data_addr = tx_base + current_tail
                word = self.ram.read(data_addr)
                packet_bytes.append(word & 0xFF)
                current_tail = (current_tail + 1) % ring_size

            # 3. Send the packet over UDP
            try:
                self.sock.send(packet_bytes)
                if len(packet_bytes) >= HEADER_SIZE:
                    dest, src, port, ctrl = struct.unpack(HEADER_FORMAT, packet_bytes[:HEADER_SIZE])
                    # Debug line to print a packet send
                    # print(f"vNIC({hex(self.nic_address)}): Sent {len(packet_bytes)} bytes to {hex(dest)} via {self.switch_addr}")
                else:
                    print(f"vNIC({hex(self.nic_address)}): Sent {len(packet_bytes)} bytes (Runt Packet) via {self.switch_addr}")
            except ConnectionRefusedError:
                print(f"vNIC WARN: Connection to vSwitch at {self.switch_addr} refused. Packet dropped.")
                self.is_connected = False
                break # Stop processing if switch is down
            except Exception as e:
                print(f"vNIC ERROR: Failed to send UDP packet: {e}")

            # 4. Acknowledge by updating the tail pointer to the new position
            tx_tail = current_tail
            self.ram.write(self.base_address + self.REG_TX_TAIL, tx_tail)

    def _process_rx_dma(self, data):
        """
        Places received data into the RX Ring Buffer in RAM using DMA.
        This implements the producer side of a circular buffer.
        """
        # --- Address Filtering (Hardware Level) ---
        if len(data) < HEADER_SIZE:
            return # Runt packet, drop

        dest_addr, src_addr, port, ctrl = struct.unpack(HEADER_FORMAT, data[:HEADER_SIZE])
        if dest_addr != 0xFFFFFFFF and dest_addr != self.nic_address:
            return # Packet is not for us

        # --- Ring Buffer Logic ---
        rx_head = self.ram.read(self.base_address + self.REG_RX_HEAD)
        rx_tail = self.ram.read(self.base_address + self.REG_RX_TAIL)
        ring_size = self.ram.read(self.base_address + self.REG_RING_SZ)
        rx_base = self.ram.read(self.base_address + self.REG_RX_BASE)
        if not rx_base or ring_size == 0: 
            print(f"vNIC({hex(self.nic_address)}): RX ring not configured, dropping packet.")
            return

        packet_len = len(data)
        required_space = packet_len + 1 # +1 for the length byte

        # Check for available space. The usable space is size - 1.
        free_space = (rx_tail - rx_head - 1 + ring_size) % ring_size
        if required_space > free_space:
            print(f"vNIC({hex(self.nic_address)}): RX ring full! Dropping incoming packet.")
            return

        # Truncate if packet is larger than the entire ring buffer capacity
        if packet_len > ring_size - 1:
            print(f"vNIC WARN: Truncating received packet from {packet_len} to {ring_size - 1} bytes.")
            packet_len = ring_size - 1
            data = data[:packet_len]

        # 1. Write packet length to the ring at the current head
        self.ram.write(rx_base + rx_head, packet_len)
        current_head = (rx_head + 1) % ring_size

        # 2. Write the packet data
        for byte in data:
            self.ram.write(rx_base + current_head, byte)
            current_head = (current_head + 1) % ring_size

        # 3. Signal to driver by updating the head register
        self.ram.write(self.base_address + self.REG_RX_HEAD, current_head)

        # Debug line to print a packet received
        # print(f"vNIC({hex(self.nic_address)}): Wrote {packet_len} bytes to RX Ring. Driver must poll.")


if __name__ == '__main__':
    # This block allows the vNIC to be run as a standalone script for testing.
    # It simulates the CPU/Driver interaction to send and receive a packet.

    class MockRAM:
        def __init__(self, size=32768): self.mem = {}
        def write(self, addr, val): self.mem[addr] = int(val)
        def read(self, addr): return self.mem.get(addr, 0)

    class MockInterruptController:
        def trigger(self, vector, data=None): print(f"✅ [INT] Interrupt raised on vector {vector}!")

    # --- Argument Parsing for Self-Test ---
    parser = argparse.ArgumentParser(description="vNIC Self-Test Utility")
    parser.add_argument(
        '--fixed-addr',
        type=lambda x: int(x, 0), # Allow hex (0x...) or decimal input
        default=None,
        help="Use a fixed Sternnet address for testing (e.g., 0xDEADBEEF) instead of a random one."
    )
    args = parser.parse_args()

    # --- Test Setup ---
    print("--- vNIC Self-Test Utility ---")
    ram = MockRAM()
    ic = MockInterruptController()

    NIC_ADDR = args.fixed_addr if args.fixed_addr is not None else random.randint(0, 0xFFFFFFFF)

    MMIO_BASE = 0x47C7
    TX_RING_BASE = 20000
    RX_RING_BASE = 21000

    print(f"Simulating NIC with address: {hex(NIC_ADDR)}")
    nic = VirtualNIC(ram, ic, base_address=MMIO_BASE, nic_address=NIC_ADDR)

    # --- Driver Simulation ---
    print("\n[Driver] Initializing vNIC registers...")
    ram.write(MMIO_BASE + nic.REG_TX_BASE, TX_RING_BASE)
    ram.write(MMIO_BASE + nic.REG_RX_BASE, RX_RING_BASE)
    ram.write(MMIO_BASE + nic.REG_RING_SZ, 256)
    ram.write(MMIO_BASE + nic.REG_CMD, 2) # ENABLE
    print("[Driver] vNIC is configured and online.")

    # --- Pre-Test Drain ---
    print("\n[Driver] Waiting for network settle (draining HELLO echo)...")
    start_drain = time.time()
    while time.time() - start_drain < 0.5:
        nic.tick()
        rx_head = ram.read(MMIO_BASE + nic.REG_RX_HEAD)
        rx_tail = ram.read(MMIO_BASE + nic.REG_RX_TAIL)
        if rx_head != rx_tail:
            print(f"[Driver] Drained packet (len {rx_head}) from RX Ring.")
            ram.write(MMIO_BASE + nic.REG_RX_TAIL, rx_head)
        time.sleep(0.01)

    # --- Test 1: Send a Broadcast Packet ---
    print("\n--- Test 1: Sending a 'HELLO' Broadcast ---")
    dest_addr = 0xFFFFFFFF
    payload = b"HELLO_VNIC_TEST"
    target_port = 100 # Match the port used in net_test.stacks
    control_word = 0  # SDP (Type 0)
    packet_to_send = struct.pack(HEADER_FORMAT, dest_addr, NIC_ADDR, target_port, control_word) + payload
    packet_len = len(packet_to_send)

    # Simulate Driver: Write [LENGTH] [DATA] to TX Ring
    tx_head = ram.read(MMIO_BASE + nic.REG_TX_HEAD)
    
    print(f"[Driver] Writing Length ({packet_len}) to TX Ring @ {hex(TX_RING_BASE + tx_head)}...")
    ram.write(TX_RING_BASE + tx_head, packet_len)
    
    current_head = (tx_head + 1) % 256
    
    print(f"[Driver] Writing {packet_len} bytes to TX Ring...")
    for byte in packet_to_send:
        ram.write(TX_RING_BASE + current_head, byte)
        current_head = (current_head + 1) % 256

    ram.write(MMIO_BASE + nic.REG_TX_HEAD, current_head)
    print(f"[Driver] Updated TX_HEAD to {current_head}. Packet is ready for NIC.")

    # --- NIC Tick Simulation ---
    tx_tail = ram.read(MMIO_BASE + nic.REG_TX_TAIL)
    while tx_tail != current_head:
        nic.tick()
        tx_tail = ram.read(MMIO_BASE + nic.REG_TX_TAIL)
        time.sleep(0.01)

    print("✅ [NIC] Acknowledged send by updating TX_TAIL. Packet is on the wire.")

    # --- Test 2: Receive a Packet ---
    print("\n--- Test 2: Listening for a response ---")
    print("INFO: Sending an explicit broadcast to verify RX path (HELLO is now silent).")

    start_time = time.time()
    packet_received = False
    while time.time() - start_time < 5:
        nic.tick()

        rx_head = ram.read(MMIO_BASE + nic.REG_RX_HEAD)
        rx_tail = ram.read(MMIO_BASE + nic.REG_RX_TAIL)

        if rx_head != rx_tail:
            print(f"✅ [Driver] Detected incoming packet! RX_HEAD={rx_head}, RX_TAIL={rx_tail}")
            
            # 1. Read Length
            r_len = ram.read(RX_RING_BASE + rx_tail)
            current_tail = (rx_tail + 1) % 256
            
            # 2. Read Data
            received_bytes = bytearray()
            for _ in range(r_len):
                received_bytes.append(ram.read(RX_RING_BASE + current_tail))
                current_tail = (current_tail + 1) % 256

            # 3. Update Tail
            ram.write(MMIO_BASE + nic.REG_RX_TAIL, current_tail)
            print(f"[Driver] Read {len(received_bytes)} bytes. Updated RX_TAIL to {current_tail}.")

            try:
                r_dest, r_src, r_port, r_ctrl = struct.unpack(HEADER_FORMAT, received_bytes[:HEADER_SIZE])
                r_payload = received_bytes[HEADER_SIZE:]
                print(f"[Driver] Decoded Packet: DEST={hex(r_dest)}, SRC={hex(r_src)}, PORT={r_port}, CTRL={r_ctrl}, PAYLOAD='{r_payload.decode(errors='ignore')}'")

                if r_src == NIC_ADDR and r_payload == payload:
                    print("✅ [Driver] Success! Received our own test broadcast.")
                    packet_received = True
                    break
                else:
                    print("⚠️ [Driver] Received packet does not match sent packet (likely initial HELLO). Continuing...")

            except Exception as e:
                print(f"❌ [Driver] Error decoding received packet: {e}")

        time.sleep(0.01)

    if not packet_received:
        print("❌ Failure: Did not receive a packet within the timeout.")
        print("Hint: Is stern_switch.py running in a separate terminal?")

    print("\n--- Self-Test Complete ---")