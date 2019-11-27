#!/bin/bash/

# horoscope.sh
# run > bash /home/yoshikiyuine/horoscope.sh

#date yyyy/MM/dd
echo 'request date: '`date +%Y/%m/%d`
#url
url=http://api.jugemkey.jp/api/horoscope/free/
requestUrl=$url`date +%Y/%m/%d`
echo -e 'request url: '$requestUrl
#get request
response=`curl $requestUrl`
echo -e 'response data: '$response
#replace , to \n, [ to \n, delete {,},]
replaceData=`echo $response | tr '[' '\n' | tr ',' '\n' | sed -e 's/{//g' -e 's/}//g' -e 's/]$//g' -e 's/:$//g'`
echo -e 'replace data: '"$replaceData"
#create sign array
signArray=(`echo "$replaceData" | grep 'sign' | sed -e 's/^.*://g' | tr -d '"' | tr '\n' ' '`)
echo -e 'sign array: '"${signArray[@]}"
#create rank array
rankArray=(`echo "$replaceData" | grep 'rank' | sed -e 's/^.*://g' | tr -d '"' | tr '\n' ' '`)
echo -e 'rank array: '"${rankArray[@]}"
#create item array
itemArray=(`echo "$replaceData" | grep 'item' | sed -e 's/^.*://g' | tr -d '"' | tr '\n' ' '`)
echo -e 'item array: '"${itemArray[@]}"
#create money array
moneyArray=(`echo "$replaceData" | grep 'money' | sed -e 's/^.*://g' | tr -d '"' | tr '\n' ' '`)
echo -e 'money array: '"${moneyArray[@]}"
#create love array
loveArray=(`echo "$replaceData" | grep 'love' | sed -e 's/^.*://g' | tr -d '"' | tr '\n' ' '`)
echo -e 'love array: '"${loveArray[@]}"
#create total array
totalArray=(`echo "$replaceData" | grep 'total' | sed -e 's/^.*://g' | tr -d '"' | tr '\n' ' '`)
echo -e 'total array: '"${totalArray[@]}"
#create color array
colorArray=(`echo "$replaceData" | grep 'color' | sed -e 's/^.*://g' | tr -d '"' | tr '\n' ' '`)
echo -e 'color array: '"${colorArray[@]}"
#create content array
contentArray=(`echo "$replaceData" | grep 'content' | sed -e 's/^.*://g' | tr -d '"' | tr '\n' ' '`)
echo -e 'content array: '"${contentArray[@]}"
#output horoscope data
echo -e "~ today's fortune ~"
echo -e ' '`date +%Y/%m/%d`'\n'
i=0
for e in ${signArray[@]}
do
	echo -e 'sign: '${e}
	echo -e 'rank: '${rankArray[i]}
	echo -e 'lucky color: '${colorArray[i]}
	echo -e 'lucky item: '${itemArray[i]}
	echo -e 'money: '${moneyArray[i]}
	echo -e 'love: '${loveArray[i]}
	echo -e 'total: '${totalArray[i]}
	echo -e ${contentArray[i]}
	let i++
	#insert line
	if (($i < ${#signArray[@]}))
	then
		echo -e '-----'
	fi
done


