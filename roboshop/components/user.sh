#!/bin/bash

COMPONENT="user"
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"
APPUSER_DIR="/home/roboshop/${COMPONENT}"

source components/common.sh         # source will keep all the functions local to the current script that declared in other file.

echo -e "\e[35m ****** ______ $COMPONENT Configuration Is Started ______  ******* \e[0m"

# CALLING NODEJS FUNCTION
NODEJS 

echo -n "Configuring Permissions :"
mv /home/roboshop/${COMPONENT}-main ${APPUSER_DIR} &>>  $LOGFILE
chown -R ${APPUSER}:${APPUSER} ${APPUSER_DIR}      &>>  $LOGFILE
stat $? 

echo -n "Generating $COMPONENT Artifacts :"
cd ${APPUSER_DIR}
npm install  &>>  $LOGFILE
stat $? 

echo -n "Configuring $COMPONENT Service: "
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' ${APPUSER_DIR}/systemd.service
mv ${APPUSER_DIR}/systemd.service   /etc/systemd/system/${COMPONENT}.service
stat $? 

echo -n "Starting $COMPONENT Service :"
systemctl enable $COMPONENT     &>>  $LOGFILE
systemctl restart $COMPONENT     &>>  $LOGFILE
stat $? 

echo -e "\e[35m ****** ______ $COMPONENT Configuration Is Completed ****** ______ \e[0m"