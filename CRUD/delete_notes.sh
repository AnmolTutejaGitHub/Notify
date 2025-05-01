#!/bin/bash
username=$1
title=$2
DATABASE="notesdb"

yad --text-info \
    --title="Delete" \
    --width=500 \
    --height=400 \
    --center \
    --text="Are you sure you want to delete '$title'?" \
    --button="Delete:1" \
    --button="Cancel:0"

response=$?

if [ "$response" -eq 1 ]; then
    mysql --defaults-file=~/.db.cnf -D "$DATABASE" -e "
        DELETE FROM notes WHERE username='$username' AND title='$title';
    "
    mysql --defaults-file=~/.db.cnf -D "$DATABASE" -e "
       INSERT INTO logs (username, log) 
       VALUES ('$username', '$title is deleted');
    "
    echo "Note deleted."
    chmod +x  ./CRUD/all_notes.sh
    ./CRUD/all_notes.sh "$username"
else
    echo "Cancelled."
    chmod +x  ./CRUD/all_notes.sh
    ./CRUD/all_notes.sh "$username"
fi