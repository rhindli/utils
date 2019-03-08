#!/bin/bash

set -eu -o pipefail

VAR1=""

#check VAR1 is empty
if [ -z "$VAR1" ]; then
	echo "VAR1 is empty"
fi

#check VAR1 is not empty
if [ -n "$VAR1" ]; then
	echo "VAR1 is not empty"
fi
