#!/bin/bash

#############################################
# Script Name   : Git Helper                #
# File          : git_helper.sh             #
# Usage         : ./git_helper.sh           #
# Created       : 01/06/2022                #
# Author        : Hasan Umut Yagci          #
# Email         : hasanumutyagci@gmail.com  #
#############################################

# Colors
COFF='\033[0m'
CRED='\033[1;31m'
CGREEN='\033[0;32m'
CYELLOW='\033[1;33m'
CCYAN='\033[0;36m'
CORANGE='\033[0;33m'

# Target directory of this script.
TARGET_DIR=/opt/project

# Clear the previous outputs. Stay at the top.
clear

# Welcome & feature messages.
echo "This script will help you manage the git instances for the main script."
echo "It can search, initiliaze, and terminate git instances on all sub folders of the target directory simultaneously."
echo
echo -e "${CCYAN}[INFO]${COFF} Target Directory: ${TARGET_DIR}/"
echo

# Prompt message.
PS3="Make a selection: "

# Script options.
OPTIONS=(
    "Search for Git"
    "Initialize Git"
    "Terminate Git"
    "Quit"
)

# While loop. As long as user does not exits, it will stay open.
while true
do
    select selection in "${OPTIONS[@]}"; do
        case $selection in
            "Search for Git")

                # Find all git instances under "/opt/project" directory and prompt to user.
                FIND_GIT=$(find $TARGET_DIR/ -type d -name '*.git*')
                echo
                echo -e "${CCYAN}[INFO]${COFF} Found Git under:"
                echo
                # Loop through all sub-directories where a git instance is found.
                for DIR in ${FIND_GIT[@]}
                do
                    # Prompt directory information to the user.
                    echo $(dirname $DIR)
                done
                echo
                break
                ;;
            "Initialize Git")

                # Find the first directories under "/opt/project" directory.
                FIND_DIRS=$(find $TARGET_DIR/* -maxdepth 0 -type d)

                # Loop through all sub-directories of the "/opt/project" directory.
                for DIR in ${FIND_DIRS[@]}
                do
                    echo
                    echo -e "${CCYAN}[INFO]${COFF} Initializing Git instances..."
                    echo

                    # Change directory and add as safe directory to git config in order to prevent user permission issues.
                    (cd "$DIR" && git config --global --add safe.directory $DIR)

                    # Initialize git and make the first commit in quiet mode then prompt to the user.
                    (cd "$DIR" && git init -q && git add . && git commit -q -m "Initial commit")
                    echo -e "${CGREEN}[SUCCESS]${COFF} Git is initialized under $DIR directory."
                done
                echo
                break
                ;;
            "Terminate Git")

                # Find all git instances under "/opt/project" directory and prompt to user.
                FIND_GIT=$(find $TARGET_DIR/ -type d -name '*.git*')
                echo
                echo -e "${CYELLOW}[CAUTION]${COFF} Terminating all Git instances..."
                echo

                # Loop through all sub-directories where a git instance is found.
                for DIR in ${FIND_GIT[@]}
                do
                    # Change directory and remove ".git" directory recursively.
                    (cd "$(dirname $DIR)" && rm -rf .git/)

                    # Prompt information to the user.
                    echo -e "${CGREEN}[SUCCESS]${COFF} Git instance under $(dirname $DIR) is terminated."
                done
                echo
                break
                ;;
            "Quit")
                echo
                echo -e "${CORANGE}Goodbye.${COFF}"
                echo
                exit
                ;;
            *) echo

                # Wildcard. Prompt incorrect selection and the basic usage to the user.
                echo -e "${CRED}[ERROR]${COFF} $REPLY is an invalid option. Select '1 - 4'" >&2
                echo
                break
                ;;
        esac
    done
done