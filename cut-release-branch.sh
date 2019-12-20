#!/bin/bash
set -e

regexString=$1

semanticVersions=''

if [ $regexString ]; then 
    semanticVersions=$(echo $(git branch -a | grep $regexString | egrep -o '([0-9]+\.){2}[0-9]+') | cut -b 1-11 | sort --version-sort | tail -n 1)
else 
    semanticVersions=$(echo $(git branch -a | egrep -o '([0-9]+\.){2}[0-9]+') | cut -b 1-11 | sort --version-sort | tail -n 1)
fi


# echo $(git branch -a | grep $regexString | egrep -o '([0-9]+\.){2}[0-9]+' | cut -d " ")

echo 'semanticVersions var: '$semanticVersions


# echo '{"hostname":"test","domainname":"example.com"}' 
