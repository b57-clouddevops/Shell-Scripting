#!/bin/bash

COMPONENT="shipping"
source components/common.sh         
echo -e "\e[35m ****** ______ $COMPONENT Configuration Is Started ______  ****** \e[0m"
# CALLING NODEJS FUNCTION
MAVEN 
echo -e "\e[35m ****** ______ $COMPONENT Configuration Is Completed ****** ______ \e[0m"