#!/bin/bash 

echo -e "Demo on if, if else, else if conditions Usage"

ACTION=$1

if [ "$ACTION" = "start" ] ; then 
    echo -e "\e[32m Starting Dispatch Service \e[0m" 
else 
    echo -e "\e[35m Valid options is start only \e[0m"
fi
