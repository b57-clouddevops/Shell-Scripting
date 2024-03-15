#!/bin/bash

mysql_root_password=$2

if [ -z "$mysql_root_password" ]; then
    echo "mysql_root_password is missing"
    exit 8
fi

echo printing $mysql_root_password
bash -x components/$1.sh