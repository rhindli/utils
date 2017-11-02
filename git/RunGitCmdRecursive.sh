#!/bin/sh

#Run git command recurrsively for all repositories
#found in first level subfolders of the indicated folder.
#
#Parameters
# $1 - folder name
# $2


FOLDER_PATH=$1

#read arguments

if [[ $2 == 'git' ]]; then
	shift
fi

ARG1=$2
ARG2=$3
ARG3=$4
ARG4=$5
ARG5=$6
ARG6=$7
ARG7=$8
ARG8=$9

shift
ARG9=$9
shift
ARG10=$9

shift
if [ ! -z "$9" ]; then
	echo Maximum 10 git arguments accepted
	exit 1
fi

echo Run git command on all repositories in "$FOLDER_PATH"
echo

cd $FOLDER_PATH

for dir in $FOLDER_PATH/*/
do
	directory=${dir%*/}
	cd $directory
	
	if [ -d ".git" ]; then
		echo
		echo $directory
		git $ARG1 $ARG2 $ARG3 $ARG4 $ARG5 $ARG6 $ARG7 $ARG8 $ARG9 $ARG10
	fi
	
	cd ..
done

echo

