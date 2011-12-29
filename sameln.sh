#!/bin/bash

export LC_ALL='C'

clear

if [ $# -ne 1 ]
then
	echo "Not enough arguments" >&2
fi

if [ ! -d $1 ]
then
	echo "Not a directory!" >&2
fi

#Find everything immediately under dir and make the delimiter \0.
#Using transliterate (tr) to change all \0 to \n to parse
files=`find "$1" -maxdepth 1 -type f -print0 | tr '\0' '\n'| sort`

#Parse by newline
TMPIFS=$IFS
IFS=$'\n'
for file in `echo "$files"`
do
	for filex in `echo "$files"`
	do
		if [ "$file" != "$filex" ]	
		then
			#Compare inodes
			ls=`ls -li "$file" | awk '{print $1}'`
			lsx=`ls -li "$filex" | awk '{print $1}'`

			if [ $ls -ne $lsx ]
			then
				#Compare files
				status=`cmp -s "$file" "$filex"`
				value=`echo $?`	
				if [ $value -eq 0 ]
				then
					#echo "$file == $filex make linky"
					#Create hardlink
					echo "Removing $filex in"
					rm "$filex"
					echo "Hardlinking $filex to $file"
					ln "$file" "$filex"
				fi
			fi
		fi
	done
done
echo "Finished hardlinking duplicate files in directory: $1"
IFS=$TMPIFS
