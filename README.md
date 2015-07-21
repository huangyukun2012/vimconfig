vimconfig
=========

This is a vim config files managed by pathogen.

## what plugins are included  in this project?

###go
	This is syntax hight for go language. You need not do nothing to invoke it.
###nerdtree
	With this plugin, you can brow your file in one project more easily.
	
To invoke it , just put `\n` in vim NORMAL mode.
###vim-commentary
	
###vim-fileHeader

###vim-multicursor

###vim-pathogen

###vimwiki

###neobundle.vim

###ultisnips

###vim-easymotion

###vim-markdown

###vim-nerdtree-tabs

###vim-PinyinSearch

##Something usefull 

## Installation

	git clone https://github.com/huangyukun2012/vimconfig.git 	
	./install

## extention

**How to install new plugin**

1. Download a plugin from github in to directory of `bundle`

`git clone $URL $PATH`

2. Add  this plugin as an submodule to your project 
	
You can use git command to do this:
`git submodule add $URL $PATH`

3. Add the modification to the project, commit , and push it to your repository.

	git add $PATH
	git commit -m $msg
	git push origin master
