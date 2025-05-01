#!/bin/bash

DATABASE="notesdb"

mysql --defaults-file=~/.db.cnf -e "CREATE DATABASE IF NOT EXISTS $DATABASE;"

mysql --defaults-file=~/.db.cnf -D $DATABASE -e "
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username  VARCHAR(50),
    path  VARCHAR(100),
    title VARCHAR(100),
    content TEXT
);

CREATE TABLE IF NOT EXISTS logs(
    id INT AUTO_INCREMENT PRIMARY KEY,
    username  VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    log TEXT
)
"

echo "DONE"