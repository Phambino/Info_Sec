#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

cp /etc/passwd /etc/passwd2
cp /etc/passwd /etc/passwd.bak
chmod 600 /etc/passwd2 
