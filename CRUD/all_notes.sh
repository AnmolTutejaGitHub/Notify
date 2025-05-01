#!/bin/bash

username=$1
echo "$username"

DATABASE="notesdb"

result=$(mysql --defaults-file=~/.db.cnf -D $DATABASE -N -s -e "
        SELECT title FROM notes WHERE username='$username';
    ")
echo "$result"

IFS=$'\n' array=($result) 

notes_response=$(yad --title="notes" \
    --center \
    --width=500 \
    --height=400 \
    --button="New Note:1" \
    --button="logs:2" \
    --button="store locally:3" \
    --list --column="Notes" "${array[@]}"
   )

response=$?

if [ "$response" -eq 1 ]; then
    echo "create notes"
    chmod +x  ./CRUD/create_notes.sh
    ./CRUD/create_notes.sh "$username"
fi 

if [ "$response" -eq 2 ]; then
    echo "logs"
    chmod +x  ./Logs/Logs.sh
    ./Logs/Logs.sh "$username"
fi 

if [ "$response" -eq 3 ]; then
    chmod +x  ./CRUD/store_locally.sh
    ./CRUD/store_locally.sh "$username"
fi 

if [ "$response" -eq 0 ]; then
    echo 
    note=$(echo "$notes_response" | cut -d'|' -f1)
    chmod +x ./CRUD/note_option.sh
    ./CRUD/note_option.sh "$username" "$note"
fi


