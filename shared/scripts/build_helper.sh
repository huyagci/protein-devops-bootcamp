#!/bin/bash

#############################################
# Script Name   : Build Helper              #
# File          : build_helper.sh           #
# Usage         : ./build_helper.sh         #
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
CDGRAY='\033[1;30m'
# Underlined 
UORANGE='\033[4;33m'
# Blinking
BBLUE='\033[5;36m'

# Current directory of the user.
CURRENT_DIR=$(pwd)

# Project directory.
TARGET_DIR=/opt/project/java

# Accepted compressed archive formats can be "zip", "tar.gz" and null. In case of null default "tar.gz" will be used.
ACCEPTED_FORMATS=("" "zip" "tar.gz")

# Change directory to target directory if the script executed from another directory.
cd $TARGET_DIR

# Default state of maven build command. Test skipping is true.
BUILD="mvn package -q -Dmaven.test.skip=true"

# Usage message of the script.
USAGE_MSG="
Usage: $(basename $0) [OPTION] <ARGUMENT> ...

OPTIONS:    ARGUMENTS:         DESCRIPTION:                             DEFAULT VALUE:

[-b]        <branch_name>      Branch name to get the build from.       Current Branch
[-f]        <zip|tar.gz>       Compress format of the artifact.         tar.gz
[-p]        <artifact_path>    Output path of compressed artifacts.     Current Directory
[-n]        <new_branch>       Creates a new branch if applied.

[-q]        <true|false>       Enable or disable quiet mode.            Enabled
[-d]        <true|false>       Enable or disable debug mode.            Disabled
[-t]        <true|false>       Apply or skip tests.                     Skip

[-c]                           Cleans the maven project if applied.
[-h]                           Shows usage/help.
"

# Empty line after command execution.
echo

# Usage function to prompt usage message.
usage() {
    echo "${USAGE_MSG}"
    exit 1
}

# This command cleans the maven project in quiet mode by deleting the target directory.
clean_maven() {
    echo -e "${CCYAN}[INFO]${COFF} Cleaning the project..."
    echo $(mvn clean -q)
    echo -e "${CGREEN}[SUCCESS]${COFF} Cleaning completed.\n"
    exit 0
}

# Adds "-X" to build command if specified.
debug_mode() {
    if [ -n "${OPTARG}" ] && [ "${OPTARG}" == "true" ]
    then
        BUILD+=" -X"
        echo -e "${CCYAN}[INFO]${COFF} Debug mode is enabled."
        sleep 1.5
    fi
}

# Creates a new branch if argument is specified.
new_branch() {
    if [ -n "${OPTARG}" ]
    then
        git branch ${OPTARG}
        echo -e "${CYELLOW}[CAUTION]${COFF} New Branch: ${OPTARG}"
    fi
}

# Changes the test skipping satete to false by changing the build command parameter to "-Dmaven.test.skip=false"
tests() {
    if [ -n "${OPTARG}" ] && [ "${OPTARG}" == "true" ]
    then
        BUILD=$(echo $BUILD | sed "s/"-Dmaven.test.skip=true"/"-Dmaven.test.skip=false"/g")
        echo -e "${CCYAN}[INFO]${COFF} Tests will be applied."
        sleep 1.5
    fi 
}

quiet_mode() {
    if [ -n "${OPTARG}" ] && [ "${OPTARG}" == "false" ]
    then
        BUILD=$(echo $BUILD | sed "s/"-q"/""/g")
        echo -e "${CCYAN}[INFO]${COFF} Quiet mode disabled."
        sleep 1.5
    fi 
}

# Main build function.
build() {

    # If archive format is not in accepted formats, warn the user and stop execution. 
    if ! [[ "${ACCEPTED_FORMATS[*]}" =~ "${ARCHIVE_FORMAT}" ]]
    then
        echo -e "${CRED}[ERROR]${COFF} You must provide a valid format. Must be 'zip' or 'tar.gz"
        usage
        exit 1
    else
        # Get the available git branches in target directory and save it as an array.
        BRANCH_LIST=( $(git branch | tr -d ' ,*') )

        # Check the current branch in target directory.
        CURRENT_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

        # If branch name is not specified by "-b" flag accept current branch as selected branch for build.
        if [ -z "${SELECTED_BRANCH}" ]; then SELECTED_BRANCH=${CURRENT_BRANCH}; fi

        # Check if the selected branch is exists in branch list.
        if [[ "${BRANCH_LIST[*]}" =~ "${SELECTED_BRANCH}" ]]
        then
            # Standart info message.
            echo -e "${CCYAN}[INFO]${COFF} Selected Branch: ${SELECTED_BRANCH}"

            # Warn the users if building from "main" or "master" branch.
            if [[ "$SELECTED_BRANCH" == "main" || "$SELECTED_BRANCH" == "master" ]]
            then
                echo -e "${CORANGE}[WARNING]${COFF} You are building on ${UORANGE}${SELECTED_BRANCH}${COFF} branch!"
                sleep 3
            fi

            # If selected branch is the current branch, continue to build and invoke compress function.
            if [ "${SELECTED_BRANCH}" == "${CURRENT_BRANCH}" ]
            then
                echo -e "${CCYAN}[INFO]${COFF} Building..."
                eval $BUILD
                compress
            else
                # If selected branch is not the current branch, switch branch first, build the project and invoke compress function.
                git switch -q ${SELECTED_BRANCH}
                echo -e "${CCYAN}[INFO]${COFF} Building..."
                eval $BUILD
                compress
            fi
        else

        # If the selected branch does not exists in branch list, warn the user about creating a new branch.
            echo -e "${CRED}[ERROR]${COFF} Requested branch does not exists!"
            echo -e "${CCYAN}[INFO]${COFF} Add '${BBLUE}-n $SELECTED_BRANCH${COFF}' argument if you want a build on a new branch."
            usage
            exit 1
        fi
    fi
}

# Compressed archive function.
compress() {

    # Selection of archive format. Depending on given, or not given arguments.
    case $ARCHIVE_FORMAT in

        # If not provided, use "tar.gz" as default.
        "")
        ARCHIVE_FORMAT="tar.gz"
        echo -e "${CCYAN}[INFO]${COFF} Archive Format: $ARCHIVE_FORMAT ${CDGRAY}(Not specified, using default)${COFF}"
        ;;

        # If provided, use the specified format.
        "zip" | "tar.gz")
        ARCHIVE_FORMAT=$ARCHIVE_FORMAT
        echo -e "${CCYAN}[INFO]${COFF} Archive Format: $ARCHIVE_FORMAT"
        ;;
    esac
    
    # Check if "-p" argument is specified.
    if [ -z "${ARTIFACT_PATH}" ]
    then
        # If the "-p" argument is not specified, use the current directory as output directory and inform the user.
        ARTIFACT_PATH=${CURRENT_DIR}
        echo -e "${CCYAN}[INFO]${COFF} Output Directory: $CURRENT_DIR ${CDGRAY}(Not specified, using current)${COFF}"
    else
        # If the "-p" argument is specified, set the output directory of the archive.
        ARTIFACT_PATH=${ARTIFACT_PATH}
        echo -e "${CCYAN}[INFO]${COFF} Output Directory: $ARTIFACT_PATH"
    fi

    # Find artifacts using ".jar" or ".war" files under target directory.
    TARGET_FILE=$(find $TARGET_DIR/target/ -type f -name "*SNAPSHOT.jar" -or -name "*SNAPSHOT.war" )

    # If "zip" format is requested;
    if [ "${ARCHIVE_FORMAT}" == "zip" ]
    then
        # Compress it using "zip" in quiet mode. "-j" flag provides it does not store directory names.
        zip -q -j ${ARTIFACT_PATH}/${SELECTED_BRANCH}.${ARCHIVE_FORMAT} ${TARGET_FILE}
        echo -e "${CCYAN}[INFO]${COFF} Archive File: ${SELECTED_BRANCH}.${ARCHIVE_FORMAT}"
    fi

    # If "tar.gz" format is requested;
    if [ "${ARCHIVE_FORMAT}" == "tar.gz" ]
    then
        #Compress it using "tar" utility. "-C" flag and "$(basename ${...})" provides changing the directory first then archive only the file.
        tar -C $(dirname "${TARGET_FILE}") -Pczf ${ARTIFACT_PATH}/${SELECTED_BRANCH}.${ARCHIVE_FORMAT} $(basename "${TARGET_FILE}")
        echo -e "${CCYAN}[INFO]${COFF} Archive File: ${SELECTED_BRANCH}.${ARCHIVE_FORMAT}"
    fi
}

# While loop and case block.

# ":" sign before the flags gives control of the unspecified flags to case itself.
# Therefore "illegal option" error will not be triggered.

# ":" signs after the flags indicates that flags can take arguments.
# "-c" and "-h" are the only flags that can be used without an argument.
while getopts ":b:f:p:n:q:d:t:ch" options 
do
    case "${options}" in
        b) SELECTED_BRANCH=${OPTARG};;
        f) ARCHIVE_FORMAT=${OPTARG};;
        p) ARTIFACT_PATH=${OPTARG};;
        n) new_branch;;
        q) quiet_mode;;
        d) debug_mode;;
        t) tests;;
        c) clean="true";;
        h) usage;;
        ?) echo -e "${CRED}[ERROR]${COFF} Invalid Option: -${OPTARG}"; usage;;
    esac
done

# If "-c" flag is specified, clean the maven project else start building.
if [ ! $clean ]
then
    # Build the project.
    build
    echo -e "${CGREEN}[SUCCESS]${COFF} Build completed.\n"
else
    # Clean the project.
    clean_maven
fi

# Change directory to previous directory if executed from another directory.
cd - &>/dev/null