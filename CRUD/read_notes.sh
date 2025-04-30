#!/bin/bash
username=$1
title=$2

DATABASE="notesdb"

result=$(mysql --defaults-file=~/.db.cnf -D "$DATABASE" -N -s -e "
    SELECT content FROM notes WHERE username='$username' AND title='$title';
")

yad --text-info \
    --title="$title" \
    --width=500 \
    --height=400 \
    --center \
    --text="$result" \
    --button="Close:1"

chmod +x  ./CRUD/all_notes.sh
./CRUD/all_notes.sh "$username"