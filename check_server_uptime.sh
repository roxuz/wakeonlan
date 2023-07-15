#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <server_ip> <mac_address>"
    exit 1
fi

server_ip=$1  # <server_ip> with the IP address of your server
mac_address=$2  # <mac_address> with your server's MAC address
start_date=$(date +%s)

# Determine OS and Send Wake-on-LAN packet
OS=$(uname)
if [ "$OS" == "Linux" ]; then
    # Assuming 'etherwake' tool is installed on Ubuntu/Linux
    etherwake $mac_address
elif [ "$OS" == "Darwin" ]; then
    # Assuming 'wakeonlan' tool is installed on MacOS
    wakeonlan $mac_address
else
    echo "Unsupported OS"
    exit 1
fi

ping -c 1 -W 1 $server_ip > /dev/null 2>&1

while [ $? -ne 0 ]
do
    sleep 1
    ping -c 1 -W 1 $server_ip > /dev/null 2>&1
done

end_date=$(date +%s)

diff=$(($end_date-$start_date))
echo "Server came online after: $diff seconds"
