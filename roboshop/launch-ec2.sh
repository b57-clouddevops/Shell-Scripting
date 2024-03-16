#!/bin/bash 

# This script creates Ec2

AMI_ID="ami-072983368f2a6eab5"
SGID="sg-03b4d0f3339fdc89c"               # Create your own Security Group that allows allows all and then add your SGID 
COMPONENT=$1

if [ -z $1 ] ; then
    echo -e "\e[31m   COMPONENT NAME IS NEEDED: \e[0m"
    echo -e "\e[36m \t\t Example Usage : \e[0m  bash launch-ec2 ratings"
    exit 1
fi 

aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SGID --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]'

