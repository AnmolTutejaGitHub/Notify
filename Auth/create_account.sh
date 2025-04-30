#!/bin/bash
DATABASE="notesdb"

create_account=$(yad --form \
    --title="Create Account" \
    --center \
    --width=300 \
    --height=100 \
    --field="Username" \
    --field="Password"
)

if [ $? -eq 0 ]; then
    username=$(echo "$create_account" | cut -d '|' -f1)
    password=$(echo "$create_account" | cut -d '|' -f2)
    if [ -z "$username" ] || [ -z "$password" ]; then
        echo "Username or password can't be blank"
        exit
    fi
    
   result=$(mysql --defaults-file=~/.db.cnf -N -s -D $DATABASE -e "SELECT COUNT(*) FROM users WHERE username = '$username'")

    if [ "$result" -gt 0 ]; then
        yad --center --title="Error" --text="Username already exists" --button=OK
        echo "Username already exists"
        exit 1
    fi

    mysql --defaults-file=~/.db.cnf -D $DATABASE -e "INSERT INTO users (username, password) VALUES ('$username', '$password')"
    if [ $? -eq 0 ]; then
        yad --center --title="Success" --text="Account created successfully" --button=OK
        echo "Account created successfully"
        chmod +x ./Auth/login.sh
        ./Auth/login.sh
    else
        yad --center --title="Error" --text="Error creating account" --button=OK
        echo "Error creating account"
        exit 1
    fi
fi
