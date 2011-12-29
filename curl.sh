#!/bin/sh

if [ "$#" -ne 1 ]
then
	echo "Please enter the sleep time (seconds)" >&2
	exit 1
fi

sleep=$1

clear

echo "Sleep Time: $sleep"
echo

#diff -y links.txt links2.txt

while [ 1 ]
do
	echo "Crawling mangastream.com"
	curl http://www.mangastream.com 2>/dev/null | grep -o -E 'href="([^"#]+)"' | grep "com\/read\/" | cut -d'"' -f2 > links.txt

	same=`diff -s links.txt links2.txt 2>/dev/null | grep -o "identical"`

	echo
	if [ "$same" == "identical" ]
	then
		echo "Files are the same... sleep: $sleep"
		sleep $sleep 
	else
		echo "Files are not the same"
		echo

		curl http://www.mangastream.com 2>/dev/null | grep "read" | grep -o -E '">([^#<>]+)<\/a>' | cut -d"<" -f1 | cut -d">" -f2 > linkNames.txt

		#paste merges lines of files
		paste -d"|" linkNames.txt links.txt > linkC.txt 

		echo "Updating linkC.txt"
		diff -y links.txt links2.txt
		cat links.txt > links2.txt
		echo "Emailing linkC.txt"
		mutt -s "Crawled Links" rkwong@ucx.ucr.edu < linkC.txt
		echo
	fi
done

#avoid putting curl output into a variable, it doesn't retain whitespace format
#-o print only matching
#-E regular expression (egrep)
#[^"#]+ look for anything thats not inside the bracket

#curl http://www.mangastream.com 2>/dev/null | grep "read" | grep -o -E '">([^#<>]+)<\/a>' | cut -d"<" -f1 | cut -d">" -f2 > linkNames.txt
#
#curl http://www.mangastream.com 2>/dev/null | grep -o -E 'href="([^"#]+)"' | grep "com\/read\/" | cut -d'"' -f2 > links.txt
#
##paste merges lines of files
#paste -d"|" linkNames.txt links.txt > linkC.txt 
#
#while read line
#do
#	echo $line
#done < linkC.txt 
