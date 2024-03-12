#!/bin/bash 

# There are 4 types of commands available : 

# 1) Binary                         ( /bin , /sbin )
# 2) Aliases                        ( Aliases are shortcuts alias net="netstat -tulpn")
# 3) Shell Built-In Commands        ( cd , pwd, exit, export, alias )  
# 4) Functions                      ( Use functions when you have a common patther and this pattern using functions can be effectively)

# How to declare a function ?
f() {
    echo hello 
}

# How to you call a function ?

f               # calling a function 

echo "Today we are learning bash"
echo "Today is day 2 of bash"
f 