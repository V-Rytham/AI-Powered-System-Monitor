#!/bin/bash

# Set the output file to store data
OUTPUT_FILE="/mnt/d/AI_powered_system_monitor/system_usage.csv"

# Add a header to the CSV file if it doesn't exist
if [ ! -f "$OUTPUT_FILE" ]; then
    echo "timestamp,cpu_usage,memory_usage,disk_usage" > "$OUTPUT_FILE"
fi

# Capture the current timestamp
timestamp=$(date +%s)
Timestamp=$(date -d @$timestamp)

# Get CPU usage (percentage of CPU in use)
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Get memory usage (percentage of memory in use)
memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Get disk usage (percentage of disk used on root partition "/")
disk_usage=$(df -h / | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 }' | sed 's/%//g')

#    # Write the data to the CSV file
echo "$Timestamp,$cpu_usage,$memory_usage,$disk_usage" >> "$OUTPUT_FILE"
#    
