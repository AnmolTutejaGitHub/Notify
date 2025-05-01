#!/bin/bash

username=$1

DATABASE="notesdb" 

result=$(mysql --defaults-file=~/.db.cnf -D $DATABASE -N -s -e "
        SELECT log,timestamp FROM logs WHERE username='$username';
    ")
echo "$result"

IFS=$'\n' array=($result) 

yad --title "logs" \
    --center \
    --width=500 \
    --height=400 \
    --list --column="Logs" "${array[@]}" \
    --button="Close:1"


response=$?
if [ $response -eq 1 ]; then
   echo "Cancelled"
    chmod +x  ./CRUD/all_notes.sh
    ./CRUD/all_notes.sh "$username"
fi
