#!/bin/bash

COMPONENT="catalogue"
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"
APPUSER_DIR="/home/roboshop/${COMPONENT}"

source components/common.sh         # source will keep all the functions local to the current script that declared in other file.

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
id $APPUSER     &>>  $LOGFILE
if [ $? -ne 0 ]; then 
    useradd $APPUSER
    stat $? 
else 
    echo -e "\e[35m SKIPPING \e[0m"
fi 

echo -n "Downloading the $COMPONENT Component: "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $? 

echo -n "Performing $COMPONENT Cleanup :"
rm -rf ${APPUSER_DIR}  &>>  $LOGFILE
stat $? 

echo -n "Extracting $COMPONENT :"
cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip  &>>  $LOGFILE
stat $? 

echo -n "Configuring Permissions :"
mv /home/roboshop/${COMPONENT}-main ${APPUSER_DIR} &>>  $LOGFILE
chown -R ${APPUSER}:${APPUSER} ${APPUSER_DIR}      &>>  $LOGFILE
stat $? 

echo -n "Generating $COMPONENT Artifacts :"
cd ${APPUSER_DIR}
npm install  &>>  $LOGFILE
stat $? 

echo -n "Configuring $COMPONENT Service: "
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' ${APPUSER_DIR}/systemd.service
mv ${APPUSER_DIR}/systemd.service   /etc/systemd/system/${COMPONENT}.service
stat $? 

echo -n "Starting $COMPONENT Service :"
systemctl enable $COMPONENT     &>>  $LOGFILE
systemctl restart $COMPONENT     &>>  $LOGFILE
stat $? 

echo -e "\e[35m ****** ______ $COMPONENT Configuration Is Completed ****** ______ \e[0m"