#!/bin/bash

DISK_USAGE=$(df -hT | grep -vE 'tmp|File')
DISK_THRESHOLD=1
message=""

while IFS= read -r line
do
    usage=$(echo $line | awk '{print $6}' | cut -d % -f1)
    partition=$(echo $line | awk '{print $1}')
    if [ "$usage" -ge "$DISK_THRESHOLD" ]
    then
        message+="High Disk Usage on $partition: $usage%<br>"
    fi
done <<< "$DISK_USAGE"

echo -e "Message: $message"

# Send the email using mail.sh script
sh disk-usage-mail.sh "DevOps Team" "High Disk Usage" "$message" "ravikumardarsi390@gmail.com" "ALERT High Disk Usage" "palsonroy123@gmail.com"
