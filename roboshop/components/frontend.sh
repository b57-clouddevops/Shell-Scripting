#!/bin/bash

echo "Intalling Nginx Web Server"
dnf install nginx -y 

echo "Enabling the service"
systemctl enable nginx

echo "Starting the Web Server"
systemctl start nginx