#!/bin/bash

mysql_root_password=$2

if [ "$1" -eq "mysql" ]
    if [ -z "$mysql_root_password" ]; then
    echo "mysql_root_password is missing"
    exit 8
    fi
fi

echo printing $mysql_root_password
bash components/$1.sh