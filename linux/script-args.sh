#!/bin/bash

set -eu -o pipefail

display_usage() {
    echo "usage: create-codepipeline.sh arg1 arg2 [arg3...]"
    echo
    echo arg1  - argument 1
    echo arg2  - argument 2
    echo arg3  - argument 3 \(optional\)
    echo         Zero or more arguments
    echo
}

#####################################################################################
# Initialization
#
if [ "$#" -lt 2 ]; then
    display_usage
    echo "Error: the following arguments are required: arg1, arg2"
    exit 1
fi

if [ -z "$1" ]; then
    display_usage
    echo "Error: the following argument is required: arg1"
    exit 1
fi

if [ -z "$2" ]; then
    display_usage
    echo "Error: the following argument is required: arg2"
    exit 1
fi

#arguments are refered via $@
#arguments count ${#@}

#get all arguments starting from index 3 (first argument has index 1) index 0 is the script itself
optional_args=${@:3}
echo
echo Optional args 
echo ${optional_args[@]}

#copy all arguments starting from index 3 to a new array
optional_args_copy_array=( "${@:3}" )
echo
echo Optional args copy count
echo ${#optional_args_copy_array[@]}
echo
echo Optional args copy
echo ${optional_args_copy_array[@]}



#get full path of the directory where this script resides
this_script="$0"
this_scriptdir="$(cd $(dirname $this_script) && pwd)"
echo
echo This script directory
echo $this_scriptdir

#get name of the current script
this_scriptname="$(basename $this_script)"
echo
echo This script name
echo $this_scriptname
