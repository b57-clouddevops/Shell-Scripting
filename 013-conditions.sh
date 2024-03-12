#!/bin/bash 

# Conditions helps us to execute something only if SOME-FACTOR is true 

### case
# Syntax of case 

# case $var in 
#     opt1) commands-x ;;
#     opt2) commands-y ;; 
# esac


case $ACTION in 
    start)
        echo "Starting Dispatch Service" 
        ;;
    stop)
        echo "Stopping Dispatch Service" 
        ;;
    restart)
        echo "Restarting Dispatch Service" 
        ;;
esac 