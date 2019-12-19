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

#check string contains substring
VAR1='Main string check'
if [[ $VAR1 == *"check"* ]]; then
	echo "Contains 'check'"
fi

#extract substring from string
STR=This_is_a_string
RESULT=$(echo $STR | cut -d'_' -f 2)
#Result=is
RESULT=$(echo $STR | cut -d'_' -f 2-)
#Result=is_a_string
RESULT=$(echo $STR | cut -d'_' -f -2)
#Result=This_is


*********************
* Uppercase/Lowercase conversion
***********************
Sed is a useful tool for editing strings on the command line. Changing characters to uppercase or lowercase can be done easily with this tool by simply adding one or more of the following to your substitution string:

* \L – convert all proceeding characters to lowercase
* \U – convert all proceeding characters to uppercase
* \E – leave all proceeding characters in their current case

For example:

First letter capitalized:
echo "aBcDe fGh" | sed 's/^./\U&\E/'
will print ABcDe fGh

First word capitalized:
echo "aBcDe fGh" | sed 's/^[^ ]*/\U&\E/'
will print ABCDE fGh

Whole string lower case:
echo "aBcDe fGh" | sed 's/./\L&/g'
will print abcde fgh


