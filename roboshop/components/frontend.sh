#!/bin/bash


# Check whether you're running this script with sudo or a root user or not.If not, exit the script
ID=$(id -u)
if [ $ID -ne 0 ] ; then 
    echo -e "\e[31m This script is expected to to run with sudo\e[0m   \n\t Ex:  bash scriptName compMame"
    exit 1
fi 

echo "Intalling Nginx Web Server"
dnf install nginx -y 

echo "Enabling the service"
systemctl enable nginx

echo "Starting the Web Server"
systemctl start nginx