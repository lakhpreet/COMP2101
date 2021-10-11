#!/bin/bash
#
# this script displays some host identification information for a simple Linux machine
#
# Sample output:
#   Hostname        : hostname
#   LAN Address     : 192.168.2.2
#   LAN Hostname    : host-name-from-hosts-file
#   External IP     : 1.2.3.4
#   External Name   : some.name.from.our.isp

# Task 1: Clean up this script by moving the commands that generate the output to separate lines
#         that put each command's output into variables. Once you have that done, Use those variables
#         in the output section at the end of the script. If the commands included in this script
#         don't make sense to you, feel free to create your own commands to find your ip addresses,
#         host names, etc.

echo 'Task 1'
part=`ip a |awk '/: e/{gsub(/:/,"");print $2}'`
lanAddress=`ip a s $part |awk '/inet /{gsub(/\/.*/,"");print $2}'`
lanName=`getent hosts $lanAddress | awk '{print $2}'`
externalAddress=`curl -s icanhazip.com`
externalName=`getent hosts $externalAddress | awk '{print $2}'`

cat <<EOF
Hostname        : $(hostname)
LAN Address     : $lanAddress
LAN Hostname    : $lanName
External IP     : $externalAddress
External Name   : $externalName
EOF


# Task 2: Add variables for the default router's name and IP address.
#         Add a name for the router's IP address to your /etc/hosts file.
#         The router's name and address must be obtained by dynamically
#         finding the router IP address from the route table, and looking
#         up the router's hostname using its IP address, not by just
#         printing out literal text.

echo 'Task 2'
routAddress=$(echo $lanAddress | awk -F "." '{print $1 "." $2 "." $3 ".1"}')
routName=$(getent hosts $routAddress | awk '{print $2}')

cat <<EOF
Router Address  : $routAddress
Router Hostname : $routName
EOF

echo 'End'
