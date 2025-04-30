#!/bin/bash
username=$1
title=$2

action=$(yad --title="Note Options" \
    --center \
    --width=300 \
    --height=100 \
    --text="$title" \
    --button="Read:0" \
    --button="Update:1" \
    --button="Delete:2" \
    --button="Cancel:3")

response=$?

case $response in
  0)
    chmod +x  ./CRUD/read_notes.sh
    ./CRUD/read_notes.sh "$username" "$title"
    ;;
  1)
    chmod +x  ./CRUD/update_notes.sh
    ./CRUD/update_notes.sh "$username" "$title"
    ;;
  2)
    chmod +x  ./CRUD/delete_notes.sh
    ./CRUD/delete_notes.sh "$username" "$title"
    ;;
  *)
    echo "closed"
    chmod +x  ./CRUD/all_notes.sh
    ./CRUD/all_notes.sh "$username"
    ;;
esac