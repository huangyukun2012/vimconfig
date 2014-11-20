if(has("win32") || has("win95") || has("win64") || has("win16")) "判定当前操作系统类型
    let g:iswindows=1
else
    let g:iswindows=0
endif

"颜色与行显示的设定
set nu
set t_Co=256
set bg=dark
"colorscheme solarized
colorscheme desert
autocmd BufEnter * lcd %:p:h

set nocompatible "不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题

syntax enable
syntax on "打开高亮
"set fdm=syntax

"缩进
set sw=4
set tabstop=4 "让一个tab等于4个空格
set vb t_vb=
set nowrap "不自动换行
set cursorline
set cursorcolumn
set wrap
filetype indent on
set autoindent

set hlsearch "高亮显示结果
set incsearch "在输入要搜索的文字时，vim会实时匹配
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用
if(g:iswindows==1) "允许鼠标的使用
    "防止linux终端下无法拷贝
    if has('mouse')
        set mouse=a
    endif
    au GUIEnter * simalt ~x
endif

"字体的设置
set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI "记住空格用下划线代替哦
set gfw=幼圆:h10:cGB2312
"字符编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
"taglist 设置
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"winManager config
let g:winManagerWindowLayout='FileExplorer|TagList'
map wm :WMToggle<cr>

"=========================================快捷键设置===============================================

map <C-F11> 	:vs<CR>
nmap ,a			:tabnew<cr>	
nmap ,g			"+p 
map <S-F5> 		:call Debug()<cr>
map <F5> 		:call RunProgram()<cr>
map <F6> 		:!python %<cr>
map <F7> 		:call Compile() <cr>
map <F8> 		:call RunWap()<cr>
imap [ 			[]<left>
imap ( 			()<left>
imap {			{}<left>
map	 rel	:set relativenumber<cr>
map	 nor	:set norelativenumber<cr>
map	 nu		:set nu<cr>
map	 no 	:set nonu<cr>
"=========================================begin 函数定义:文件编译与运行============================================


func! Compile() 
exec "w" 
if &filetype == 'c' 
	exec "!gcc -std=c99 % -g -o %<"
	exec "!chmod +x %<"
endif 
if &filetype == 'cpp' 
	exec "!g++4.8.3 -std=c++11 % -g -o %< "
	exec "!chmod +x %< "
endif
if &filetype == 'go'
	exec "!go build %"
endif
if &filetype == 'md'
	exec "!md2html  %"
endif
endfunc 

func RunProgram() 
if &filetype == 'md'
	exec "!chromium-browser %<"
else
	exec "w" 
	exec "!./%<"
endif
endfunc 

func Debug()
	exec "w"
	if &filetype == 'c'
		exec "!gdb ./%<"
	endif
endfunc

func RunPython() 
exec "w" 
exec "!chmod +x %"
exec "!python %"
endfunc 

"================================相关插件============================================
filetype plugin indent on
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()


let g:nerdtree_tabs_open_on_console_startup=0 
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
map <leader>n <plug>NERDTreeTabsToggle <CR> 
"EasyMotion
"Helptags
set tags=tags;
"set autochdir
nmap ,t :set tags=tags<left><left><left><left>
"close scratch when complete
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

"commentary
autocmd FileType python,shell set commentstring=#\ %s                 " 设置Python注释字符
autocmd FileType mako set cms=##\ %s	
nmap	,c  gcc
nmap	,u	gcu

"vim-PinyinSearch
let g:PinyinSearch_Dict = '/home/huangyk/.vim/bundle/vim-PinyinSearch/PinyinSearch.dict'
map		?	:call PinyinSearch()<cr>

"vimrc
map		vim	:tabnew<cr>:e ~/.vimrc<cr>
"date and time and author
map		dat	:read !date<cr>	

"multiple-cursor
