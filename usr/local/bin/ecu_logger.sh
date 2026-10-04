#!/bin/bash

CAPTURE_DIR="/data/pcap"

mkdir -p "$CAPTURE_DIR"
sudo chmod a+rw $CAPTURE_DIR/


# Wait for bridge interface
while ! ip link show br0 >/dev/null 2>&1
do
    sleep 2
done

echo "$(date) Starting capture on br0"
exec sudo tcpdump \
    -i br0 \
    -s 0 \
    -n \
    -B 8192 \
    -C 20 \
    -W 1000 \
    -w "$CAPTURE_DIR/ethernet_capture__$(date +%Y%m%d_%H%M%S).pcap"
