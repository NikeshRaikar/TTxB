#!/bin/bash

# Device name passed by udev (e.g., sda1)
DEVICE=$1
MOUNT_POINT="/mnt/usb_$DEVICE"
CAN_LOG_DIR="/data/can_logs"
ETH_LOG_DIR="/data/pcap"

# Ensure we are dealing with a valid block device
if [ -z "$DEVICE" ]; then
    exit 1
fi

# Create mount point and mount the USB
mkdir -p "$MOUNT_POINT"
mount "/dev/$DEVICE" "$MOUNT_POINT"
if [ $? -ne 0 ]; then
    # Exit silently if mount fails (e.g., unsupported filesystem)
    rmdir "$MOUNT_POINT"
    exit 1
fi

# Enable nullglob so empty directories don't return the literal wildcard string
shopt -s nullglob
CAN_LOGS=("$CAN_LOG_DIR"/candump-*.log)
ETH_LOGS=("$ETH_LOG_DIR"/*.pcap*)

# Check if there are actually logs to move
if [ ${#CAN_LOGS[@]} -eq 0 ] && [ ${#ETH_LOGS[@]} -eq 0 ]; then
    # No logs found, unmount and exit
    umount "$MOUNT_POINT"
    rmdir "$MOUNT_POINT"
    exit 0
fi

# Stop loggers temporarily so we can safely move the active files
systemctl stop can-logger.service
systemctl stop eth-logger.service

# Create a timestamped directory on the USB to prevent file collisions
DEST_DIR="$MOUNT_POINT/combined_logs_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$DEST_DIR"

# Move the CAN logs to the USB if they exist
if [ ${#CAN_LOGS[@]} -gt 0 ]; then
    mv "$CAN_LOG_DIR"/candump-*.log "$DEST_DIR/"
fi

# Move the Ethernet logs to the USB if they exist
if [ ${#ETH_LOGS[@]} -gt 0 ]; then
    mv "$ETH_LOG_DIR"/*.pcap* "$DEST_DIR/"
fi

# Restart loggers to start fresh captures
systemctl start can-logger.service
systemctl start eth-logger.service

# Flush filesystem buffers to guarantee data is physically written to the USB
sync

# Safely unmount and clean up
umount "$MOUNT_POINT"
rmdir "$MOUNT_POINT"
