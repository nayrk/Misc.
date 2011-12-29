#!/bin/sh

A=$(who | cut -d' ' -f1 | sort | uniq)

while [ 1 ];
do
	for values in $A
	do
		if who | grep $values &> /dev/null; then
			#echo "Sleeping 5 at $values"
			sleep 5
		else
			echo "$values has logged out at `date`"
		fi
	done
done
