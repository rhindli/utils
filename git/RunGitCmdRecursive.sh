#!/bin/bash

display_usage() {
    echo
    echo "Run git command recurrsively for all repositories found in first level subfolders of the indicated folder."
    echo
    echo "RunGitCmdRecursive.sh folder [git] params"
    echo
    echo "folder     - parent folder of repositories folders"
    echo "git        - optional you can include the 'git' command name"
    echo "             If not specified it is implied"
    echo "params     - git params"
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

START_ARG=2
if [ "$2" == 'git' ]; then
	START_ARG=3
fi

if [ "$START_ARG" -eq 3 ] && [ "$#" -lt 3 ]; then
    echo "Missing parameter(s). See usage"
    display_usage
    exit 1
fi

echo "Run git command on all repositories in $FOLDER_PATH"
echo

cd $FOLDER_PATH

for dir in $FOLDER_PATH/*/
do
	directory=${dir%*/}
	cd $directory
	
	if [ -d ".git" ]; then
		echo
		echo $directory
		git "${@:$START_ARG}"
	fi
	
	cd ..
done

echo "${@:$START_ARG}"

echo

