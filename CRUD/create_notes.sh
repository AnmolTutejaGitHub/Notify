#!/bin/bash
username=$1

DATABASE="notesdb" 

title=$(yad --entry \
    --title="Note Title" \
    --center \
    --width=400 \
    --text="Enter title:" \
    --button="Next:0" \
    --button="Cancel:1")

if [ $? -ne 0 ]; then
    echo "Cancelled"
    exit
fi

note=$(yad --text-info \
  --title="Write your Note" \
  --editable \
  --width=500 \
  --height=400 \
  --center \
  --button="Save:0" \
  --button="Cancel:1")

response=$?

if [ "$response" -eq 0 ]; then
    uuid=$(uuidgen)

    mysql --defaults-file=~/.db.cnf -D "$DATABASE" -e "
       INSERT INTO notes (username, title, content) 
       VALUES ('$username', '$title-$uuid', '$note');
    "
    mysql --defaults-file=~/.db.cnf -D "$DATABASE" -e "
       INSERT INTO logs (username, log) 
       VALUES ('$username', '$title-$uuid is created');
    "
    chmod +x  ./CRUD/all_notes.sh
    ./CRUD/all_notes.sh "$username"
    echo "Note saved"
else
    echo "Cancelled"
    chmod +x  ./CRUD/all_notes.sh
    ./CRUD/all_notes.sh "$username"
fi