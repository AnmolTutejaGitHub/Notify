#!/bin/bash
username=""
password=""
DATABASE="notesdb"

login_data=$(yad --form \
    --title="Login" \
    --center \
    --width=300 \
    --height=100 \
    --field="Username" \
    --field="Password")

if [ $? -eq 0 ]; then
    echo "Checking Database"
    echo "$login_data"
    username=$(echo "$login_data" | cut -d '|' -f1)
    password=$(echo "$login_data" | cut -d '|' -f2)
    echo "$username"
    echo "$password"
   
    result=$(mysql --defaults-file=~/.db.cnf -N -s -D $DATABASE -e "
        SELECT COUNT(*) FROM users WHERE username='$username' AND password='$password';
    ")

    if [ "$result" -eq 1 ]; then
        echo "Login successful"
        chmod +x  ./CRUD/all_notes.sh
        ./CRUD/all_notes.sh "$username"
    else
        yad --center --title="Error" --text="Invalid credentials" --button=OK
        exit 1
    fi
else echo "terminated"
fi