#!/bin/bash
set -e

regexString=$1

semanticVersions=''

    if [ $regexString ]; then 
        semanticVersions=$(echo $(git branch -a | grep $regexString | egrep -o '([0-9]+\.){2}[0-9]+') | cut -b 1-11)
    else 
        semanticVersions=$(echo $(git branch -a | egrep -o '([0-9]+\.){2}[0-9]+') | cut -b 1-11)
    fi
# getLastSemanticVersion

# echo $(git branch -a | grep $regexString | egrep -o '([0-9]+\.){2}[0-9]+' | cut -d " ")


echo 'semanticVersions var: '$semanticVersions


# echo '{"hostname":"test","domainname":"example.com"}' 
