#!/bin/bash
url=`cat $1/.git/config | grep \.git | awk '{print $3}'`
path=$1
git submodule add $url $path
