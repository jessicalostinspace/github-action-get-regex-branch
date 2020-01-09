#!/bin/bash
set -eou pipefail

regexString=$1

semanticVersion=''
branchName=''
echo "regexString: " $regexString
echo $(git branch -a)

if [ "$regexString" ]; then 
    branchName=$(git branch -a | grep "$regexString" | grep -E '([0-9]+\.){2}[0-9]+' | sort --version-sort | tail -n 1 | sed 's@.*/@@')
    semanticVersion=$(git branch -a | grep "$regexString" | egrep -o '([0-9]+\.){2}[0-9]+' | sort --version-sort | tail -n 1)
else 
    branchName=$(git branch -a | grep -E '([0-9]+\.){2}[0-9]+' | sort --version-sort | tail -n 1 | sed 's@.*/@@')
    semanticVersion=$(git branch -a | egrep -o '([0-9]+\.){2}[0-9]+' | sort --version-sort | tail -n 1)
fi

echo '{"semanticVersion": "'$semanticVersion'", "branchName": "'$branchName'"}' 
