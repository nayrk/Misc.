#!bin/sh

#the -n means no linebreak
#echo -n "Hit a key: "
#read key

#the n1 makes it not wait for enter
read -n1 -p "Hit a key: " key

case "$key" in
	[a-z])
		echo "$key is lower case."
	;;
	[A-Z])
		echo "$key is upper case."
	;;
	[0-9])
		echo "$key is a number."
	;;
	*)
		echo "$key is a punctuation."
	;;
esac
