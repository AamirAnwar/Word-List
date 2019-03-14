#!/bin/sh
git clone https://github.com/AamirAnwar20/gitlab.git ../gitlab
cd ../gitlab
git checkout master
git pull origin master
cd ../Wordiste
echo 'token here'
echo $GITHUB_TOKEN
