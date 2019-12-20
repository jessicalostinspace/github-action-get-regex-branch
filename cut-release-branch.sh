#!/bin/bash
set -e

regexString=$1

echo 'git for each: '$(git for-each-ref --sort=committerdate refs/heads/)

if [ $regexString ]; then 
    echo $(git branch -a | grep $regexString | egrep -o '([0-9]+\.){2}[0-9]+')
else 
    echo $(git branch -a | egrep -o '([0-9]+\.){2}[0-9]+')
fi
