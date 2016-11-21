#!/bin/bash
if [ $HOME/.vimrc ];then
	cp $HOME/.vimrc $HOME/.vimrc.old
fi
cp vimrc $HOME/.vimrc
