#! /bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt/scripts

#############################################
# Script Name   : Backup Home Directories   #
# File          : backup_home_dirs.sh       #
# Usage         : ./backup_home_dirs.sh     #
# Created       : 26/05/2022                #
# Author        : Hasan Umut Yagci          #
# Email         : hasanumutyagci@gmail.com  #
#############################################

# Directory configurations
source ./backup.conf

# Fetch all UID's & save it as an array
UID_LIST=( $(awk -F ':' '{print $3}' /etc/passwd) )

# Loop through UID's
for UUID in "${UID_LIST[@]}"
do
    # Return only normal users
    if ((UUID <= 60000 && UUID >= 1000))
    then
        # Get usernames and home dirs
        USER=$( awk -F ':' -v UID="${UUID}" '$3==UID {print $1}'  /etc/passwd )
        HOME_DIR=$( awk -F ':' -v UID="${UUID}" '$3==UID {print $6}'  /etc/passwd )

        # Create compressed archives of all dirs
        ARCHIVE_NAME_FORMAT=${BACKUP_DEST_DIR/$'\r'/}/${USER}--${DATE_TIME_FORMAT/$'\r'/}.tar.gz
        tar -C $( dirname "${HOME_DIR}" ) -Pczf ${ARCHIVE_NAME_FORMAT} $( basename "${HOME_DIR}" )
        echo "Backup completed."

        # Generate a md5 hash of all archives
        md5sum ${ARCHIVE_NAME_FORMAT} > ${ARCHIVE_NAME_FORMAT}.md5.txt
        echo "MD5 created."
    fi
done

# Last runtime log
stat -c '%x' ./${0}| awk -F '.' '{print $1}' >> ${LOGS_DEST_DIR/$'\r'/}/${0/'.sh'/}_script_lastrun.log