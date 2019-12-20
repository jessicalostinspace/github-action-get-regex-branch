#!/bin/bash
set -e

regexString=$1

semanticVersion=''
if [ $regexString ]; then 
    semanticVersion=$(echo $(git branch -a | grep $regexString | egrep -o '([0-9]+\.){2}[0-9]+'))
else 
    semanticVersion=$(echo $(git branch -a | egrep -o '([0-9]+\.){2}[0-9]+'))
fi

echo 'semanticVersion var: '$semanticVersion


echo '{"hostname":"test","domainname":"example.com"}' 