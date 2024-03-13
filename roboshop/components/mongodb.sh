#!/bin/bash

# Check whether you're running this script with sudo or a root user or not.If not, exit the script
ID=$(id -u)
if [ $ID -ne 0 ] ; then 
    echo -e "\e[31m This script is expected to run with sudo or as a root user \e[0m   \n\t Ex:  bash scriptName compName"
    exit 1
fi 

COMPONENT="mongodb"
LOGFILE="/tmp/${COMPONENT}.log"
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo"
SCHEMA_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"

stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Success \e[0m"
    else 
        echo "\e[31m Failure \e[0m"
    fi 
}

echo -e "\e[35m ****** ______ $COMPONENT Configuration Is Started ****** ______ \e[0m"

echo -n "Configuring $COMPONENT repo"
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $? 

echo -n "Installing $COMPONENT :"
dnf install -y mongodb-org  &>>  $LOGFILE
stat $? 

echo -n "Enabling $COMPONENT Service :"
systemctl enable mongod     &>>  $LOGFILE
stat $?

echo -n "Enabling $COMPONENT Visibility :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting $COMPONENT Service :"
systemctl start mongod     &>>  $LOGFILE
stat $?

echo -n "Downloading $COMPONENT Schema File : "
curl -s -L -o /tmp/mongodb.zip $SCHEMA_URL  &>>  $LOGFILE
stat $?

echo -n "Extracting $COMPONENT Schema :"
cd /tmp
unzip -o ${COMPONENT}.zip   &>>  $LOGFILE
stat $? 

echo -n "Injecting the schema :"
cd /tmp/mongodb-main   
mongo < catalogue.js    &>>  $LOGFILE
mongo < users.js        &>>  $LOGFILE
stat $? 

echo -e "\e[35m ****** ______ $COMPONENT Configuration Is Completed ****** ______ \e[0m"