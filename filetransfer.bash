#!/bin/bash

password=$(<password.txt)
username=$(<username.txt)
IP=$(<IP.txt)

mkdir -p /file_holder
for FILE in /mnt/mydrive/*; do
    cp "$FILE" /file_holder
done

IFS=$'\n'
for FILE in $(ls -S /file_holder*); do
    sshpass -p "$password" scp /file_holder/"$FILE" "$username"@"$IP":~/files
done