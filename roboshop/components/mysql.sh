#!/bin/bash

COMPONENT="mysql"
LOGFILE="/tmp/${COMPONENT}.log"
MYSQL_REPO="https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mysql.repo"
SCHEMA_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"

source components/common.sh         # source will keep all the functions local to the current script that declared in other file.

echo -e "\e[35m ****** ______ $COMPONENT Configuration Is Started ****** ______ \e[0m"

echo "Disabling $COMPONENT repo :"
dnf module disable mysql -y     &>>  $LOGFILE
stat $? 

echo -n "Configuring $COMPONENT repo"
curl -s -L -o /etc/yum.repos.d/mysql.repo $MYSQL_REPO
stat $? 

echo -n "Installing $COMPONENT :"
dnf install mysql-community-server -y  &>>  $LOGFILE
stat $? 

echo -n "Starting $COMPONENT :"
systemctl enable mysqld    &>>  $LOGFILE
systemctl start mysqld     &>>  $LOGFILE
stat $? 