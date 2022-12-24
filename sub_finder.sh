#!/bin/bash
if [ $# -eq 0 ]
then
echo "how to use : ./SofSP.sh <full url> <website name>"
echo "EX : ./Sub_finder.sh <https://www.udemy.com/>  <udemy>"
else
mkdir "$2 subdomins" 
cd "$2 subdomins"
axel $1 -o $2.html
less $2.html | grep -o "//[^/]*\.$2.com" |grep -v "www.$2.com"|grep -o  "[^/]*\.$2.com"  |sort -u |uniq >> sub_$2.txt
for sub in  $(cat sub_$2.txt) 
do
if [[ $(fping -a -4  $sub) ]]
then
echo "$sub >>> found"
echo $sub >> vaild_sub_$2.txt
else
echo "$sub >>> not found"
fi
done
for ip in $(cat vaild_sub_$2.txt)
do

(echo $ip ; echo  $(host $ip);echo '' )  >> ips_sub_$2.txt
done
echo ""; echo "";
for sub in $(cat vaild_sub_$2.txt)
do
echo "$(fping -a -4 $sub)"
echo "$(fping -Aa -4 $sub)"
echo "$(fping -Aa -4 $sub)" >> alive_$2_ips.txt 

done
echo "$(cat alive_$2_ips.txt|sort -u)" > alive_$2_ips.txt
cd ..
fi
echo "Done.........thanks"
