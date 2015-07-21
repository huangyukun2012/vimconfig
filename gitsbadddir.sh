#!/bin/bash
num=$#
if [ num != 1 ];then
	echo "please put in the git dir you want to use as an git submodule"
fi
url=`cat $1/.git/config | grep \.git | awk '{print $3}'`
path=$1
git submodule add $url $path
