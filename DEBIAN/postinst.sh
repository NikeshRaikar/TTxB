#!/bin/bash
set -e

# The script receives arguments from dpkg. "$1" is the action being performed.
case "$1" in
    configure)
        echo "Configuring pi-network-logger..."
        
        # 1. Reload systemd to recognize the newly copied .service files
        systemctl daemon-reload
	
	# Enable the new network init service FIRST
	systemctl enable logger-network.service
        
        # 2. Enable the services so they start automatically on boot
        systemctl enable can-logger.service
        systemctl enable eth-logger.service
        
        # 3. Reload udev rules to recognize the new USB mounting rules
        udevadm control --reload-rules
        udevadm trigger
        
        # Optional: Start them immediately without needing a reboot
        # systemctl start can-logger.service
        # systemctl start eth-logger.service
        ;;
    
    abort-upgrade|abort-remove|abort-deconfigure)
        # Fallback in case of an aborted action
        ;;
        
    *)
        echo "postinst called with unknown argument \`$1'" >&2
        exit 1
        ;;
esac

exit 0