#!/bin/sh
# (C) 2024 Siltesa

# Paths
# /sys/class/net/phy0-ap0
# /sys/devices/platform/soc/5311000.usb/usb3/3-1/3-1:1.0/net/phy0-ap0

path=$(readlink -f /sys/class/net/phy1-ap0/device)

if [ -n "$path" ]; then
   path="${path##/sys/devices/}"

   uci set wireless.radio1.path="$path"
   uci -q commit wireless
fi

# Check if the 'mm' interface is up
mm_status=$(ubus call network.interface.wwan status | jq -r '.up')

# Check if the 'intel_xmm' interface is up
intel_xmm_status=$(ubus call network.interface.wan status | jq -r '.up')

# Check if either interface is up
if [ "$mm_status" = "true" ] || [ "$intel_xmm_status" = "true" ]; then
    # Get the status of radio1
    radio1_status=$(wifi status | jq -r '.radio1.up')

    # Check if radio1 is down and execute the command
    if [ "$radio1_status" = "false" ]; then
        echo "Setting up wireless hat"
		wifi up radio1
    fi
fi
