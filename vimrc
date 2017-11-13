if(has("win32") || has("win95") || has("win64") || has("win16")) "get the type of current os.
    let g:iswindows=1
else
    let g:iswindows=0
endif
		
" color and line
set nu
set t_Co=256
set bg=dark
" colorscheme solarized
colorscheme desert

"vim with vi, set it to nocompatible, or you may have some problems
set nocompatible

" syntax highlight.
syntax enable
syntax on

set autoindent

set sw=4
" tab = 4 whitespace
set tabstop=4
set vb t_vb=
" list the tab and whitespace
set list
" make tab and space printable
set lcs=tab:\|\ ,nbsp:%,trail:-

" set the color of leader Tab to grey.
highlight LeaderTab guifg=#666666
" match leader tab.
match LeaderTab /^\t/

set cursorline
set wrap

" search hight, runtime match for search.
set hlsearch
set incsearch

set backspace=indent,eol,start whichwrap+=<,>,[,]

if(g:iswindows==1)
    if has('mouse')
        set mouse=a
    endif
    au GUIEnter * simalt ~x
endif

"front
set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI 
set gfw=幼圆:h10:cGB2312

"encoding
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"=========================================setting for shorcut===============================================
nmap ,g			"+p 
imap [ 			[]<left>
imap ( 			()<left>
imap {			{}<left>

map	 rel	:set relativenumber<cr>
map	 nor	:set norelativenumber<cr>

map ,p	 :set paste<cr>
map ,np	 :set nopaste<cr>

nmap ,a			:tabnew<cr>	
map		vim	:tabnew<cr>:e ~/.vimrc<cr>

"Helptags
set tags=tags;

"close scratch when complete
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"=========================================compile and run============================================

map <S-F5> 		:call Debug()<cr>
map <F5> 		:call RunProgram()<cr>
map <F6> 		:call PthreadCompile()<cr>
map <F7> 		:call Compile() <cr>
map <F8> 		:call CompileDir() <cr>
func! PthreadCompile()
	exec "w"
	if &filetype == 'c'
		exec "!gcc  % -g -o %< -lpthread"
	endif
	if &filetype == 'cpp'
		exec "!g++ % -g -o %< -lpthread"
	endif
endfunc


func! Compile() 
	exec "w" 
	if &filetype == 'c' 
		exec "!gcc -std=c99 % -g -o %<"
	endif 
	if &filetype == 'cpp' 
		exec "!g++ -std=c++11 % -g -o %< "
	endif
	if &filetype == 'go'
		exec "!go build %"
	endif
	if &filetype == 'md'
		exec "!md2html  %"
	endif
endfunc 

func! CompileDir()
	exec "w"
	if &filetype == 'go'
		exec "!go build"
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
	if &filetype == 'cpp'
		exec "!gdb ./%<"
	endif
endfunc

func RunPython() 
	exec "w"
	exec "!chmod +x %"
	exec "!python %"
endfunc

"===============================Plugins============================================
filetype plugin indent on

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

"nerd tree
let g:nerdtree_tabs_open_on_console_startup=0 
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
map <leader>n <plug>NERDTreeTabsToggle <CR> 

"EasyMotion
"just type <leader><leader>w to invoke it

"commentary
autocmd FileType python,shell set commentstring=#\ %s                 " 设置Python注释字符
autocmd FileType mako set cms=##\ %s	
nmap	,c  gcc
nmap	,u	gcu

"vim-PinyinSearch
let g:PinyinSearch_Dict = '/home/huangyk/.vim/bundle/vim-PinyinSearch/PinyinSearch.dict'
map		?	:call PinyinSearch()<cr>


"multiple-cursor
" Default mapping
" let g:multi_cursor_next_key='<C-m>'
 " let g:multi_cursor_prev_key='<C-p>'
 " let g:multi_cursor_skip_key='<C-x>'
 " let g:multi_cursor_quit_key='<Esc>'

"airline
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '>'
let g:airline_right_sep = '<'
let g:airline_section_b = '%{getcwd()}'
" let g:airline_section_b += '%{getfilename()}'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" set the status line
set laststatus=2

"ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


"taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Ctags_Cmd="/usr/bin/ctags"
map tl	:Tlist<cr>

"winManager config
let g:winManagerWindowLayout='FileExplorer|TagList'
map wm :WMToggle<cr>
let g:AutoOpenWinManager = 1

"cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-
"nmap<C-_>s :cs find s<C-R>=expand("<cword>")<CR><CR>)
" s: Find this C symbol
"    nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
    " g: Find this definition
    nnoremap  ,fg :call cscope#find('g', expand('<cword>'))<CR><CR>
    " d: Find functions called by this function
    nnoremap  ,fd :call cscope#find('d', expand('<cword>'))<CR><CR>
    " c: Find functions calling this function
   nnoremap  ,fc :call cscope#find('c', expand('<cword>'))<CR>
    " t: Find this text string
   nnoremap  ,ft :call cscope#find('t', expand('<cword>'))<CR>
    " e: Find this egrep pattern
   nnoremap  ,fe :call cscope#find('e', expand('<cword>'))<CR>
    " f: Find this file
"    nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
    " i: Find files #including this file
"    nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>

"quickfix
map ,cl :lcl<CR>

""RainbowParenthese
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"gdb
" nnoremap <F4> :GdbFromVimRun <CR>
" nnoremap <F5> :GdbFromVimStep <CR>
" nnoremap <F6> :GdbFromVimNext <CR>
" nnoremap <F7> :GdbFromVimAddBreakpoint <CR>
" nnoremap <F8> :GdbFromFromDeleteBreakpoint <CR>
" nnoremap <F9> :GdbFromVimClear <CR>

"syntax detect============================
" func!	StaticSyntax()
" 	set statusline+=%#warningmsg#
" 	set statusline+=%{SyntasticStatuslineFlag()}
" 	set statusline+=%*

" 	let g:syntastic_always_populate_loc_list = 1
" 	let g:syntastic_auto_loc_list = 1
" 	let g:syntastic_check_on_open = 1
" 	let g:syntastic_check_on_wq = 0
" endfunc
