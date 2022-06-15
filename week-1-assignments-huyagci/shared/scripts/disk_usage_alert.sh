#! /bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt/scripts

#############################################
# Script Name   : Disk Usage Alert          #
# File          : disk_usage_alert.sh       #
# Usage         : ./disk_usage_alert.sh     #
# Created       : 28/05/2022                #
# Author        : Hasan Umut Yagci          #
# Email         : hasanumutyagci@gmail.com  #
#############################################

# Timestamp format
DATE_TIME=$(date +"%d/%m/%Y - %H":"%M")

# Get partition name
PARTITION=$(df / | grep / | awk '{print $1}')

# Get current usage of selected partition
CURRENT=$(df / | grep / | awk '{print $5}' | sed 's/%//g')

# Declare total amount to calculate remaining space
declare -i TOTAL=100
REMAINING=$(( $TOTAL - $CURRENT ))

# Set a threshold of critical level
THRESHOLD=90

# If current space exceeds threshold level
if [ "$CURRENT" -ge "$THRESHOLD" ]
then
    # Email headers
    SUBJECT="Disk Usage Warning!"
    TO="devopsweek1@gmail.com"

    # Body message of the email
    BODY="Be advised, free space of $PARTITION partition on your $HOSTNAME machine is critical!\r\rSpace Left: $REMAINING%\rTimestamp: $DATE_TIME"
    
    # Sent an email to specified address with given information
    echo -e $BODY | mail -s "$SUBJECT" $TO
fi