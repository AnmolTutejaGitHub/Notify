#!/bin/bash

username=$1
DATABASE="notesdb"

cd ~
mkdir Notes
cd Notes


timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
mkdir "notes-$timestamp"
cd "notes-$timestamp"

result=$(mysql --defaults-file=~/.db.cnf -D "$DATABASE" -N -s -e "
    SELECT title, content FROM notes WHERE username='$username';
")

echo "$result"


IFS=$'\n'
for row in $result; do
    title=$(echo "$row" | cut -f1)
    content=$(echo "$row" | cut -f2-)

    echo "$content" > "$title.txt"
done

open .