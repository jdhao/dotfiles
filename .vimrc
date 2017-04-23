set nocompatible
filetype off

"""""""""""""""""""""""""""vundle settings""""""""""""""""""""""


"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
"Plugin 'altercation/vim-colors-solarized' " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/taglist.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Raimondi/delimitMate'
Plugin 'ConradIrwin/vim-bracketed-paste'
"Plugin 'tomasr/molokai'
"Plugin 'juanedi/predawn.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"""""""""""""""""""""""1. options"""""""""""""""""""""""""""""""


set history=20		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching


" draw a horizontal line under the current-editted line
set cursorline

" automatically reload file if the file has been changed outside vim
set autoread
"highlight python code
let python_highlight_all=1
syntax on

" highlight match when searching
set hls
"general tab settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

"allow backspace to delete previously inserted characters
set backspace=indent,eol,start

set showmatch
set number
set relativenumber
set showmode
set wrapmargin=8
set ignorecase
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8
set termencoding=utf-8
set wildmenu

"multiple panes setting in vim 
set splitbelow
set splitright

"folding settings for plugin SimplyFol
"enable viewing docstrings in the foled text
let g:SimpylFold_docstring_preview = 1
" don't fold the docstrings
let g:SimpylFold_fold_docstring = 0

"wrap long line when window is too samll, but not break words
set wrap linebreak nolist


""""""""""""""""""""""" mapping settings """""""""""""""""""""""""

let mapleader = "\\"
let maplocalleader = ","

nmap lb 0
nmap le $
map * I/* A */   " map * to comment in C programming language
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

" solve problems when there are wrapping,but we want to move cursor
" based on physical lines not the actual lines.
nmap j gj
nmap k gk
nmap $ g$
nmap ^ g^
nmap 0 g0
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

"using ctrl + h,j,k,l to move cursor between files opened 
"in the current window the same way as h,j,k,l move cursors
"in the normal mode
nnoremap <C-h> <C-W><C-h>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       auto command                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"automatically save current python file and execute it when 
"pressing the <F9> key
au FileType python nnoremap <buffer> <F9> :exec 'w !python' shellescape(@%, 1)<cr>

"comment a line when using <localleader>c 
au FileType python nnoremap <buffer> <localleader>c I#<esc>

"after saving the .vimrc file, automatically source it to let vim 
"use the new settings immediately without leaving vim
au BufWritePost $MYVIMRC source $MYVIMRC

" setting related to tab in order to follow PEP8
au BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 
						\textwidth=79 expandtab autoindent fileformat=unix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    vim.syntastic setting                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




"""""""""""""""""""""""" colorscheme settings """"""""""""""""""""


" colorscheme settings for solarize
"syntax enable
"set background=dark
"colorscheme solarized


"colorscheme setting for molokai
"set background=dark
"colorscheme molokai


" colorscheme setting for predawn
"colorscheme predawn
"
colorscheme elflord 
