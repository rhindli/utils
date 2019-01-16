#!/bin/bash

set -eu -o pipefail

display_usage() {
    echo
    echo "Run git command recurrsively for all repositories found in first level subfolders of the indicated folder."
    echo
    echo "RunGitCmdRecursive.sh folder gitcmd"
    echo
    echo "folder     - parent folder of repositories folders"
    echo "gitcmd     - git command with params"
}



if [ "$#" -eq 0 ]; then
    display_usage
    exit 1
fi

if [ "$#" -lt 2 ]; then
    echo "Missing parameter(s). See usage"
    display_usage
    exit 1
fi


FOLDER_PATH=$1

#param number (1-based) of the git command
GIT_CMD_START_ARG=2

echo "Run \"git ${@:$GIT_CMD_START_ARG}\" on all repositories in $FOLDER_PATH"
echo

cd $FOLDER_PATH

for dir in $FOLDER_PATH/*/
do
	directory=${dir%*/}
	cd $directory
	
	if [ -d ".git" ]; then
		echo
		echo $directory
		git "${@:$GIT_CMD_START_ARG}"
	fi
	
	cd ..
done

echo

