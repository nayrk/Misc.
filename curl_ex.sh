#!/bin/bash
#Crawl www.samair.ru/proxy/proxy-$pagenum.htm for proxy list
#http://s3cu14r.wordpress.com/2011/05/19/crawling-websites-using-curl-and-bash/

echo -e -n "Crawling www.samair.ru for proxy list \nDoing Page: "

rm proxylist.txt &> /dev/null
for pagenum in {1..99}
do
    echo -n "$pagenum "
    newpagenum=`printf "%02d" $pagenum`
    curlresp=`curl http://www.samair.ru/proxy/proxy-$newpagenum.htm 2> /dev/null`
    reppairs=`echo $curlresp | grep -o -E '.=[0-9]'`
    echo $curlresp  | grep -o -E '<tr>[^)]*' | grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}' > tempfile.txt
    mloop=0
    for tempvar in $reppairs 
    do
        repchar[mloop]=${tempvar:0:1}
        repnum[mloop]=${tempvar:2:1}
        let "mloop=$mloop+1" 
    done
    while read curproxy; do
        curip=`echo $curproxy | grep -o -E '([0-9]{1,3}\.){3}[0-9]{1,3}'`
        curport=`echo $curproxy | grep -o -E '\+.+'`
        obfsconly=`echo $curport | sed 's/+//g'`
        for tempvar in {0..9}
        do
            obfsconly=`echo $obfsconly | sed "s/${repchar[tempvar]}/${repnum[tempvar]}/g"`
        done
        echo $curip:$obfsconly >> proxylist.txt
        let "pagecount=$pagecount+1"
    done < tempfile.txt
    rm tempfile.txt
done

sort proxylist.txt > proxylist1.txt
uniq -u proxylist1.txt > proxylist2.txt

rm proxylist.txt
rm proxylist1.txt
mv proxylist2.txt proxylist.txt

echo -e "\nCreated proxylist.txt"

rm proxylist_active.txt &> /dev/null
for ip in `cat proxylist.txt`
do
    curlresponse=`curl -m 5 -x $ip google.com 2> /dev/null`
    googlepresent=`echo $curlresponse | grep google.com`
    if [ -n "$googlepresent" ]; then
        echo -e "\e[00;32mActive: $ip \e[00m"
        echo $ip >> proxylist_active.txt
    else
        echo -e "\e[00;31mInactive: $ip \e[00m"
    fi
done

echo "Created proxylist_active.txt"
