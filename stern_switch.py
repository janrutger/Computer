#!/usr/bin/env python

import socket
import struct
import argparse
import random
import time

# --- Constants ---
HOST = '127.0.0.1'
PORT = 8888
BROADCAST_ADDR = 0xFFFFFFFF
HEADER_FORMAT = '!II8x' # Big-Endian, 16 bytes: DEST(4), SRC(4), Reserved(8)
HEADER_SIZE = struct.calcsize(HEADER_FORMAT)

def main():
    """
    Implements the Sternnet vSwitch, a Layer 2 learning switch.
    It learns the location of nodes based on their source address and forwards
    packets to the correct destination.
    """
    parser = argparse.ArgumentParser(description="Sternnet Virtual Switch")
    parser.add_argument(
        '--chaos',
        action='store_true',
        help="Enable Chaos Mode to simulate an unreliable network."
    )
    args = parser.parse_args()

    if args.chaos:
        print("CHAOS MODE ENABLED: Simulating packet loss, latency, and duplication.")
        CHAOS_CONFIG = {
            "drop_rate": 0.10,      # 10% chance to drop a packet
            "latency_ms": 100,      # 100ms artificial delay
            "duplication_rate": 0.05 # 5% chance to duplicate a packet
        }
    else:
        CHAOS_CONFIG = None

    # Table to map Sternnet 32-bit addresses to UDP (ip, port) tuples
    switching_table = {}

    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
        s.bind((HOST, PORT))
        print(f"vSwitch listening on {HOST}:{PORT}")

        while True:
            try:
                data, addr = s.recvfrom(1024) # Buffer size 1024 bytes

                # --- Chaos Mode Simulation ---
                if CHAOS_CONFIG:
                    # 1. Simulate Packet Loss
                    if random.random() < CHAOS_CONFIG["drop_rate"]:
                        print(f"CHAOS: Dropped packet from {addr}")
                        continue

                    # # 2. Simulate Latency
                    # time.sleep(CHAOS_CONFIG["latency_ms"] / 1000.0)

                    # # 3. Simulate Duplication
                    # if random.random() < CHAOS_CONFIG["duplication_rate"]:
                    #     print(f"CHAOS: Duplicating packet from {addr}")
                    #     s.sendto(data, addr) # This will be processed as a separate packet

                if len(data) < HEADER_SIZE:
                    print(f"WARN: Received runt packet from {addr}, ignoring.")
                    continue

                # Unpack the header to get DEST and SRC addresses
                dest_addr, src_addr = struct.unpack(HEADER_FORMAT, data[:HEADER_SIZE])

                # --- Learning Phase (Last Seen Wins) ---
                if src_addr in switching_table and switching_table[src_addr] != addr:
                    print(f"INFO: Address {hex(src_addr)} has moved from {switching_table[src_addr]} to {addr}. Possible reboot or duplicate ID.")
                
                if src_addr not in switching_table:
                    # Check for Port Takeover: Is this UDP port already used by another ID?
                    # This happens if the OS changes its NIC_ADDR at runtime (e.g. driver reload).
                    # We must remove the old ID to prevent "ghost" traffic.
                    stale_ids = [id for id, port in switching_table.items() if port == addr]
                    for stale_id in stale_ids:
                        print(f"INFO: Port Takeover: Removing stale address {hex(stale_id)} from {addr}.")
                        del switching_table[stale_id]

                    print(f"INFO: Learned new address {hex(src_addr)} is at {addr}")

                switching_table[src_addr] = addr

                # --- Forwarding Phase ---
                if dest_addr == BROADCAST_ADDR:
                    # Broadcast to all known clients. In a single-client self-test,
                    # this ensures the broadcast is sent back to the sender, allowing
                    # the vNIC's RX path to be verified.
                    print(f"FORWARD: Broadcasting packet from {hex(src_addr)} to all.")
                    for client_addr, client_udp_addr in switching_table.items():
                        s.sendto(data, client_udp_addr)

                elif dest_addr in switching_table:
                    # Unicast to a known destination
                    target_udp_addr = switching_table[dest_addr]
                    print(f"FORWARD: Unicasting packet from {hex(src_addr)} to {hex(dest_addr)} at {target_udp_addr}")
                    s.sendto(data, target_udp_addr)

                elif dest_addr == 0:
                    # Management packet, already processed in Learning Phase.
                    print(f"MGMT: Handled management/registration packet from {hex(src_addr)}")

                else:
                    # Unknown unicast destination, drop the packet
                    print(f"DROP: Dropping packet from {hex(src_addr)} to unknown destination {hex(dest_addr)}")

            except Exception as e:
                print(f"ERROR: An exception occurred in the switch loop: {e}")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nvSwitch stopping...")