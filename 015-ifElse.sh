#!/bin/bash 

echo -e "Demo on if, if else, else if conditions Usage"

ACTION=$1

if [ "$ACTION" = "start" ] ; then 
    echo -e "\e[32m Starting Dispatch Service \e[0m" 
fi 
