#!/bin/bash


# Check whether you're running this script with sudo or a root user or not.If not, exit the script
ID=$(id -u)
if [ $ID -ne 0 ] ; then 
    echo -e "\e[31m This script is expected to run with sudo or as a root user \e[0m   \n\t Ex:  bash scriptName compName"
    exit 1
fi 

echo -n "Intalling Nginx Web Server"
dnf install nginx -y        &>>  /tmp/frontend.log
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else 
    echo "\e[31m Failure \e[0m"
fi 

echo -n "Enabling the service"
systemctl enable nginx      &>>  /tmp/frontend.log
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else 
    echo "\e[31m Failure \e[0m"
fi 

echo -n "Starting the Web Server"
systemctl start nginx       &>>  /tmp/frontend.log
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else 
    echo "\e[31m Failure \e[0m"
fi 