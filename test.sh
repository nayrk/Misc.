#!bin/sh

if test -e $1; then
	if [ -f $1 ]; then
		echo "$1 is a file."
	elif [ -d $1 ]; then
		echo "$1 is a directory."
	else
		echo "$1 has an unknown type."
	fi
else
	echo "$1 does not exist."
fi
