#!/bin/bash
set -e

regexString=$1

semanticVersion=''
function getLastSemanticVersion {
    if [ $regexString ]; then 
        semanticVersions=$(echo $(git branch -a | grep $regexString | egrep -o '([0-9]+\.){2}[0-9]+'))
    else 
        semanticVersions=$(echo $(git branch -a | egrep -o '([0-9]+\.){2}[0-9]+'))
    fi

}
# getLastSemanticVersion

echo $(git branch -a | grep $regexString | egrep -o '([0-9]+\.){2}[0-9]+' | cut -d " ")


# echo 'semanticVersion var: '$semanticVersion


# echo '{"hostname":"test","domainname":"example.com"}' 
