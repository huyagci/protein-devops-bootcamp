#!/bin/bash

# Target directory of the script
TARGET_DIR=/opt/project

# Clear the previous outputs. Stay at the top
clear

# Welcome & Feature messages
echo "This script will help you manage the git instances for the main script."
echo "It can search, initiliaze, and terminate git instances on all sub folders of the target directory simultaneously."
echo
echo "Target Directory: ${TARGET_DIR}/"
echo

# Prompt Message
PS3="Make a selection: "

# Script Options
OPTIONS=(
    "Search for Git"
    "Initialize Git"
    "Terminate Git"
    "Quit"
)

while true
do
    select selection in "${OPTIONS[@]}"; do
        case $selection in
            "Search for Git")
                FIND_GIT=$(find $TARGET_DIR/ -type d -name '*.git*')
                echo
                echo "Found Git under:"
                echo
                for DIR in ${FIND_GIT[@]}
                do
                    echo $(dirname $DIR)
                done
                echo
                break
                ;;
            "Initialize Git")
                FIND_DIRS=$(find $TARGET_DIR/* -maxdepth 0 -type d)
                for DIR in ${FIND_DIRS[@]}
                do
                    echo
                    echo "Initializing Git instances..."
                    echo
                    (cd "$DIR" && git config --global --add safe.directory $DIR)
                    (cd "$DIR" && git init -q && git add . && git commit -q -m "Initial commit")
                    echo "Git is initialized under $DIR directory."
                done
                echo
                break
                ;;
            "Terminate Git")
                FIND_GIT=$(find $TARGET_DIR/ -type d -name '*.git*')
                echo
                echo "Terminating all Git instances..."
                echo
                for DIR in ${FIND_GIT[@]}
                do
                    (cd "$(dirname $DIR)" && rm -rf .git/)
                    echo "Git instance under $(dirname $DIR) is terminated."
                done
                echo
                break
                ;;
            "Quit")
                echo
                echo "Goodbye."
                echo
                exit
                ;;
            *) 
                echo
                echo "$REPLY is an invalid option. Select '1 - 4'" >&2
                echo
                break
                ;;
        esac
    done
done