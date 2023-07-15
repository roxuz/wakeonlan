#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <server_ip>"
    exit 1
fi

server_ip=$1  # <server_ip> with the IP address of your server
start_date=$(date +%s)

ping -c 1 -W 1 \$server_ip > /dev/null 2>&1

while [ $? -eq 0 ]
do
    sleep 1
    ping -c 1 -W 1 $server_ip > /dev/null 2>&1
done

end_date=$(date +%s)

diff=$(($end_date-$start_date))
echo "Server downtime started after: $diff seconds"
