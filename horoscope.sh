#!/bin/bash

# horoscope.sh
# run > bash /home/yoshikiyuine/horoscope.sh

#date yyyy/MM/dd
echo "request date: $(date +%Y/%m/%d)"
#url
url=http://api.jugemkey.jp/api/horoscope/free/
requestUrl=$url$(date +%Y/%m/%d)
echo -e "request url: $requestUrl"
#get request
response=$(curl "$requestUrl")
echo -e "response data: $response"
#replace , to \n, [ to \n, delete {,},]
replaceData=$(echo "$response" | tr '[' '\n' | tr ',' '\n' | sed -e 's/{//g' -e 's/}//g' -e 's/]$//g' -e 's/:$//g')
echo -e "replace data: $replaceData"
#create sign set
signset=$(echo "$replaceData" | grep 'sign' | sed -e 's/^.*://g' | tr -d '"')
echo -e "sign set: $signset"
#create rank set
rankset=$(echo "$replaceData" | grep 'rank' | sed -e 's/^.*://g' | tr -d '"')
echo -e "rank set: $rankset"
#create item set
itemset=$(echo "$replaceData" | grep 'item' | sed -e 's/^.*://g' | tr -d '"')
echo -e "item set: $itemset"
#create money set
moneyset=$(echo "$replaceData" | grep 'money' | sed -e 's/^.*://g' | tr -d '"')
echo -e "money set: $moneyset"
#create love set
loveset=$(echo "$replaceData" | grep 'love' | sed -e 's/^.*://g' | tr -d '"')
echo -e "love set: $loveset"
#create total set
totalset=$(echo "$replaceData" | grep 'total' | sed -e 's/^.*://g' | tr -d '"')
echo -e "total set: $totalset"
#create color set
colorset=$(echo "$replaceData" | grep 'color' | sed -e 's/^.*://g' | tr -d '"')
echo -e "color set: $colorset"
#create content set
contentset=$(echo "$replaceData" | grep 'content' | sed -e 's/^.*://g' | tr -d '"')
echo -e "content set: $contentset"
#output horoscope data
echo -e "~ today's fortune ~"
echo -e " $(date +%Y/%m/%d)\n"
#number of data set low
length=$(echo -e "$signset" | grep -c ^)
for ((i = 1; i < length; i++)); do
  #out put target low data
  echo -e "sign: $(echo -e "$signset" | head -n $i | tail -n 1)"
  echo -e "rank: $(echo -e "$rankset" | head -n $i | tail -n 1)"
  echo -e "lucky item: $(echo -e "$itemset" | head -n $i | tail -n 1)"
  echo -e "lucky color: $(echo -e "$colorset" | head -n $i | tail -n 1)"
  echo -e "money: $(echo -e "$moneyset" | head -n $i | tail -n 1)"
  echo -e "love: $(echo -e "$loveset" | head -n $i | tail -n 1)"
  echo -e "total: $(echo -e "$totalset" | head -n $i | tail -n 1)"
  echo -e "$(echo -e "$contentset" | head -n $i | tail -n 1)"
  #insert line
  if ((i < length - 1)); then
    echo -e "-----"
  fi
done
