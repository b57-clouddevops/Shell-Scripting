#!/bin/bash


# Check whether you're running this script with sudo or a root user or not.If not, exit the script
ID=$(id -u)
if [ $ID -ne 0 ] ; then 
    echo -e "\e[31m This script is expected to run with sudo or as a root user \e[0m   \n\t Ex:  bash scriptName compName"
    exit 1
fi 

COMPONENT="catalogue"
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"

stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Success \e[0m"
    else 
        echo -e "\e[31m Failure \e[0m"
    fi 
}

echo -e "\e[35m **************** ______ $COMPONENT Configuration Is Started ______  **************** \e[0m"
echo -n "Disabling  Default NodeJS Version :"
dnf module disable nodejs -y      &>>  $LOGFILE
stat $? 

echo -n "Enabling NodeJS Version 18 :"
dnf module enable nodejs:18 -y    &>>  $LOGFILE
stat $?

echo -n "Installing NodeJS :"
dnf install nodejs -y             &>>  $LOGFILE
stat $? 

echo -n "Creating $APPUSER user account: "
useradd $APPUSER
stat $?