#!/bin/bash
username=$1
title=$2
DATABASE="notesdb"

note=$(mysql --defaults-file=~/.db.cnf -D "$DATABASE" -N -s -e "
    SELECT content FROM notes WHERE username='$username' AND title='$title';
")

updated=$(echo "$note" | yad --text-info \
  --title="$title" \
  --editable \
  --width=500 \
  --height=400 \
  --center \
  --button="Update:0" \
  --button="Cancel:1")

if [ $? -eq 0 ]; then
   mysql --defaults-file=~/.db.cnf -D "$DATABASE" -e "
        UPDATE notes SET content='$updated'
        WHERE username='$username' AND title='$title';
    "
    echo "Note updated"
    mysql --defaults-file=~/.db.cnf -D "$DATABASE" -e "
       INSERT INTO logs (username, log) 
       VALUES ('$username', '$title is updated');
    "
else
    echo "Cancelled"
fi

chmod +x ./CRUD/all_notes.sh
./CRUD/all_notes.sh "$username"