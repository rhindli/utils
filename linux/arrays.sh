#!/bin/bash

set -eu -o pipefail


#define array
my_array=(    \
value1          \
value2          \
value3          \
value4          \
value5          \
value6          \
value7          \
)

#print all elements in array
echo
echo Print all array elements
echo ${my_array[@]}

#Array element count
my_array_cnt=${#my_array[@]}

#loop array elements
echo
echo Print elements one by one
for ((n=0; n<my_array_cnt; n++)); do
    echo ${my_array[$n]}
done

#extract sub-array from another array starting from index 2, 3 elements
echo
echo Extract 3 elements starting with element at index 2 \(arrays are zero based indexed\)
sub_array1=${my_array[@]:2:3}
echo ${sub_array1[@]}

#extract all elements from another array starting from index 2
echo
echo Extract all elements after element with index 2 included \(arrays are zero based indexed\)
sub_array2=${my_array[@]:2}
echo ${sub_array2[@]}


#copy an array into another array
echo
echo Copy array into another array
copy_array=( "${sub_array1[@]}" )
echo ${copy_array[@]}

#arrays difference
#https://stackoverflow.com/questions/2312762/compare-difference-of-two-arrays-in-bash


#join array elements with separator
function join_by { local IFS="$1"; shift; echo "$*"; }
join_by , ${array[@]}

#or join array elements with multi-charater delimiters
function join_by { local d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}"; }
join_by ';, ' ${array[@]}
