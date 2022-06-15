#!/bin/bash

#############################################
# Script Name   : Sailboat                  #
# File          : sailboat.sh               #
# Usage         : sailboat [OPTS] [ARGS]    #
# Created       : 08/06/2022                #
# Author        : Hasan Umut Yagci          #
# Email         : hasanumutyagci@gmail.com  #
#############################################

# Configurations directory
source /opt/scripts/configs/sailboat.cfg

# Change directory to target directory if the script executed from another directory.
cd $TARGET_DIR

# Usage message
usage() {
    echo "${USAGE_MSG}"
}

# Mode checker function.
mode_check() {
    # If mode argument is not provided, prompt the usage message and exit.
    if [ -z $MODE ]
    then echo -e "${CRED}[ERROR]${COFF} Operation Mode is not specified!"
        usage
        exit 1
    else
        # If mode is selected, go to specified function.
        mode_selection
    fi
}

# Mode selection block. Select related mode depending on given arguments.
mode_selection() {
    case $MODE in
        # Build mode block.
        "build")
            # If image name is not provided, show usage and exit.
            if [[ -z $IMAGE_NAME ]]; then echo -e "${CRED}[ERROR]${COFF} Image name is not defined!"; usage; exit 1; 

            # If image tag is not provided, show usage and exit.
            elif [[ -z $IMAGE_TAG ]]; then echo -e "${CRED}[ERROR]${COFF} Image tag is not defined!"; usage; exit 1;
            else
                # Append image and tag names at the end of build command.
                BUILD_CMD=$(echo $BUILD_CMD | sed "s/$/ -t $IMAGE_NAME:$IMAGE_TAG ./")

                # Build the image.
                eval $BUILD_CMD
                echo -e "${CGREEN}[SUCCESS]${COFF} Image build completed.\n"

                # If "--registry" argument is not empty select requested container registry provider.
                if [[ -n $PUSH_REGISTRY ]]
                then
                    case $PUSH_REGISTRY in
                        "dockerhub")
                            # Get the username to be used in image tag.
                            echo -e "${CYELLOW}[INPUT]${COFF} What is your Docker Hub username?"
                            read USERNAME
                            
                            # Re-tag the image according to dockerhub and username provided.
                            TAG_CMD+=" $IMAGE_NAME:$IMAGE_TAG $USERNAME/$IMAGE_NAME:$IMAGE_TAG"
                            eval $TAG_CMD

                            # Push image to the docker hub.  (Login to registry is required)
                            PUSH_CMD+=" $USERNAME/$IMAGE_NAME:$IMAGE_TAG"
                            eval $PUSH_CMD
                        ;;

                        "gitlab")
                            # Get the username to be used in image tag.
                            echo -e "${CYELLOW}[INPUT]${COFF} What is your Gitlab username?"
                            read USERNAME

                            # Re-tag the image according to gitlab registry and username provided.
                            TAG_CMD+=" $IMAGE_NAME:$IMAGE_TAG registry.gitlab.com/$USERNAME/$IMAGE_NAME:$IMAGE_TAG"
                            eval $TAG_CMD

                            # Push image to the gitlab registry. (Login to registry is required)
                            PUSH_CMD+=" registry.gitlab.com/$USERNAME/$IMAGE_NAME:$IMAGE_TAG"
                            eval $PUSH_CMD
                        ;;

                        *)
                            # If anything else than docker hub or gitlab is provided, show usage and exit.
                            echo -e "${CRED}[ERROR]${COFF} You must select a valid image registry. Must be Docker Hub or Gitlab"
                            usage
                            exit 1
                        ;;
                    esac
                fi
            fi
        ;;

        # Deploy mode block.
        "deploy")
            # If image name is not provided, show usage and exit.
            if [[ -z $IMAGE_NAME ]]; then echo -e "${CRED}[ERROR]${COFF} Image name is not defined!"; usage; exit 1;
            
            # If tag name is not provided, show usage and exit.
            elif [[ -z $IMAGE_TAG ]]; then echo -e "${CRED}[ERROR]${COFF} Image tag is not defined!"; usage; exit 1;
            else
                # If container name is specified, append it to docker run command.
                if [[ -n $CONTAINER_NAME ]]; then DEPLOY_CMD+=" --name $CONTAINER_NAME"; fi

                # If cpu limit is specified, append it to docker run command.
                if [[ -n $CPU_LIMIT ]]; then DEPLOY_CMD+=" --cpus=$CPU_LIMIT"; fi

                # If memory is specified, append it to docker run command.
                if [[ -n $MEMORY_LIMIT ]]; then DEPLOY_CMD+=" --memory=$MEMORY_LIMIT"; fi

                # Append image and tag names at the end of build command.
                DEPLOY_CMD=$(echo $DEPLOY_CMD | sed "s/$/ $IMAGE_NAME:$IMAGE_TAG/")

                # Run the docker image.
                eval $DEPLOY_CMD
            fi
        ;;

        # Template mode case.
        "template")
            # Select the specified case depending on user input.
            case $APPLICATION_NAME in
                "mongo")
                    echo -e "${CCYAN}[INFO]${COFF} MongoDB selected as a database service."
                    # Use docker compose file with mongo db in detached mode.
                    TEMPLATE_CMD+=" -f mongo.yaml up -d"
                    eval $TEMPLATE_CMD
                ;;

                "mysql")
                    echo -e "${CCYAN}[INFO]${COFF} MySQL selected as a database service."
                    # Use docker compose file with mysql db in detached mode.
                    TEMPLATE_CMD+=" -f mysql.yaml up -d"
                    eval $TEMPLATE_CMD
                ;;

                "")
                    # If appication name is not specified, show usage and exit.
                    echo -e "${CRED}[ERROR]${COFF} Application name is not specified!"
                    usage
                    exit 1
                ;;

                *)
                    # If invalid application name is specified, show usage and exit.
                    echo -e "${CRED}[ERROR]${COFF} You must provide a valid application name. Must be 'mongo' or 'mysql'"
                    usage
                    exit 1
                ;;
            esac
        ;;

        "")
            # If an operation mode is not specified, show usage and exit.
            echo -e "${CRED}[ERROR]${COFF} Operation mode is not selected!"
            usage
            exit 1
        ;;

        *)
            # If an invalid operation mode is specified, show usage and exit.
            echo -e "${CRED}[ERROR]${COFF} Invalid Mode: ${ARG}"
            usage
            exit 1
        ;;
    esac
}

# Transform long options to short options.
for ARG in "$@"; do
    shift
    case "${ARG}" in
        '--mode')               set -- "$@" '-m'     ;;
        '--image-name')         set -- "$@" '-n'     ;;
        '--image-tag')          set -- "$@" '-t'     ;;
        '--registry')           set -- "$@" '-r'     ;;
        '--container-name')     set -- "$@" '-c'     ;;
        '--cpu')                set -- "$@" '-p'     ;;
        '--memory')             set -- "$@" '-s'     ;;
        '--application-name')   set -- "$@" '-a'     ;;
        '--help')               set -- "$@" '-h'     ;;
        *)                      set -- "$@" "${ARG}" ;;
    esac
done

# While loop and switch case for short options.

# ":" sign before the flags gives control of the unspecified flags to case itself.
# Therefore "illegal option" error will not be triggered.

# ":" signs after the flags indicates that flags can take arguments.
# So in this case, all flags can take an argument except for "-h | --help"
while getopts ":m:n:t:r:c:p:s:a:h" OPTIONS
do
    case "${OPTIONS}" in
    m) MODE=${OPTARG};;
    n) IMAGE_NAME=${OPTARG};;
    t) IMAGE_TAG=${OPTARG};;
    r) PUSH_REGISTRY=${OPTARG};;
    c) CONTAINER_NAME=${OPTARG};;
    p) CPU_LIMIT=${OPTARG};;
    s) MEMORY_LIMIT=${OPTARG};;
    a) APPLICATION_NAME=${OPTARG};;
    h) usage; exit 0;;
    *) echo -e "${CRED}[ERROR]${COFF} Invalid Option: ${ARG}"; usage; exit 1;;
  esac
done

# Parse short options.
OPTIND=1

# Remove options from positional parameters.
shift $(expr $OPTIND - 1)

# Check which mode is requested.
mode_check

# Change directory to previous directory if executed from another directory.
cd -