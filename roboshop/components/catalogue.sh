#!/bin/bash

COMPONENT="catalogue"
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"
APPUSER_DIR="/home/roboshop/${COMPONENT}"

source components/common.sh         # source will keep all the functions local to the current script that declared in other file.

echo -e "\e[35m **************** ______ $COMPONENT Configuration Is Started ______  **************** \e[0m"

# CALLING NODEJS FUNCTION
NODEJS 

echo -e "\e[35m ****** ______ $COMPONENT Configuration Is Completed ****** ______ \e[0m"