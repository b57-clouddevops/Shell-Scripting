#/bin/bash

# This is a file to host all the COMMON PATTERN's or the common functions.
# This can be imported in any of the scripts with the help of source

ID=$(id -u)
if [ $ID -ne 0 ] ; then 
    echo -e "\e[31m This script is expected to run with sudo or as a root user \e[0m   \n\t Ex:  bash scriptName compName"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Success \e[0m"
    else 
        echo -e "\e[31m Failure \e[0m"
    fi 
}

# Declaring Create User Function
CREATE_USER() {
    echo -n "Creating $APPUSER user account: "
    id $APPUSER     &>>  $LOGFILE
    if [ $? -ne 0 ]; then 
        useradd $APPUSER
        stat $? 
    else 
        echo -e "\e[35m SKIPPING \e[0m"
    fi 
}

# Declaring a Nodejs Function : 
NODEJS() {
    echo -n "Disabling  Default NodeJS Version :"
    dnf module disable nodejs -y      &>>  $LOGFILE
    stat $? 

    echo -n "Enabling NodeJS Version 18 :"
    dnf module enable nodejs:18 -y    &>>  $LOGFILE
    stat $?

    echo -n "Installing NodeJS :"
    dnf install nodejs -y             &>>  $LOGFILE
    stat $?    

    CREATE_USER         # Calling function from another function
}