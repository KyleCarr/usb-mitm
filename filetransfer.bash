#!/bin/bash

password=$(<password.txt)
username=$(<username.txt)
IP=$(<IP.txt)
maxSize=5000000

mkdir -p /file_holder
for FILE in /mnt/mydrive/*; do
    cp "$FILE" /file_holder
done

IFS=$'\n'
for FILE in $(ls -S /file_holder*); do
    fileSize=$(wc -c /file_holder/"$FILE" | awk '{print $1}')
    if ((fileSize < $maxSize)); then
        sshpass -p "$password" scp /file_holder/"$FILE" "$username"@"$IP":~/files
    fi
    rm /file_holder/"$FILE"
done