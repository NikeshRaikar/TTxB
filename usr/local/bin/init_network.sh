#!/bin/bash

# 1. Configure and bring up CAN interfaces
# Adjust bitrate as needed (e.g., 500000 for standard high-speed CAN)
ip link set can0 up type can bitrate 500000
ip link set can1 up type can bitrate 500000

# 2. Create the Ethernet bridge (br0)
ip link add name br0 type bridge

# 3. Bind the physical interfaces to the bridge
ip link set dev eth0 master br0
ip link set dev eth1 master br0

# 4. Bring up the Ethernet interfaces and the bridge
ip link set eth0 up
ip link set eth1 up
ip link set br0 up

exit 0