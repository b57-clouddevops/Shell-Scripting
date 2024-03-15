#!/bin/bash

COMPONENT="mysql"
LOGFILE="/tmp/${COMPONENT}.log"
MYSQL_REPO="https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mysql.repo"
SCHEMA_URL="https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/shipping.sql"
MYSQL_PWD=${2}

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

echo -n "Fetching $COMPONENT root passowrd: "
DEFAULT_ROOT_PASS=$(grep "temporary password" /var/log/mysqld.log | awk -F " " '{print $NF}')
stat $? 

echo "show databases;" | mysql -uroot -pRoboShop@1 &>>  $LOGFILE
if [ $? -ne 0 ] ; then 
    echo -n "Changing default root password :"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'" | mysql --connect-expired-password -uroot -pRoboShop@1
    stat $? 
fi 

echo "show plugins;" | mysql -uroot -p${MYSQL_PWD}| grep validate_password &>>  $LOGFILE
if [ $? -eq 0 ] ; then 
    echo -n "Uninstalling plugins:"
    echo "uninstall plugin validate_password;" | mysql -uroot -p${MYSQL_PWD}
    stat $? 
    echo "show databases;" | mysql -uroot -pRoboShop@1 &>>  $LOGFILE
fi 

echo -n "Downloading $COMPONENT Schema File : "
cd /tmp/
wget $SCHEMA_URL  &>>  $LOGFILE
stat $? 

echo -n "Injecting the schema :"
mysql -u root -pRoboShop@1 </tmp/shipping.sql &>>  $LOGFILE 
stat $?