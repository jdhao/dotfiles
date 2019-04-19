""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"        _   _       _                  _____             __ _               "
"       | \ | |     (_)                / ____|           / _(_)              "
"       |  \| |_   ___ _ __ ___       | |     ___  _ __ | |_ _  __ _         "
"       | . ` \ \ / / | '_ ` _ \      | |    / _ \| '_ \|  _| |/ _` |        "
"       | |\  |\ V /| | | | | | |     | |___| (_) | | | | | | | (_| |        "
"       |_| \_| \_/ |_|_| |_| |_|      \_____\___/|_| |_|_| |_|\__, |        "
"                                                               __/ |        "
"                                                              |___/         "
"                                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The above ascii art is generated using http://tinyurl.com/y6szckgd

" Notes and frontpage {{{

" Description: This is my Nvim configuration which supports Mac, Linux and
" Windows, with various plugins configured. This configuration evolves as I
" learn more about Nvim and becomes more proficient in using Nvim. Since this
" configuration file is very long (more than 1000 lines!), you should read it
" carefully and only take the settings and options which suits you.  I would
" not recommend downloading this file and replace your own init.vim. Good
" configurations are built over time and take your time to polish.
"
" Author: jdhao (jdhao@hotmail.com). My blog: https://jdhao.github.io
"
" Update: 2019-04-18 15:45:03+0800
"
" License: MIT License
"
" Copyright (c) 2018 Jie-dong Hao
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to
" deal in the Software without restriction, including without limitation the
" rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
" sell copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
" FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
" IN THE SOFTWARE.
" }}}

" Builtin variables {{{

" disable Python 2 support
let g:loaded_python_provider = 1

" path to Python 3 interpreter (must be an absolute path), make startup faster.
" see https://neovim.io/doc/user/provider.html. You should change this
" variable in accordance with your system.
if has('win32') " for Windows
    let g:python3_host_prog='D:/Anaconda/python'
elseif has('macunix') " for Mac
    let g:python3_host_prog=expand('~/anaconda3/bin/python')
else " for Linux
    let g:python3_host_prog=expand('~/tools/anaconda3/bin/python')
endif

" set custom mapping <leader> (use `:h mapleader` for more info)
let mapleader = ','
" }}}

" Custom functions {{{

" remove trailing white space, see https://goo.gl/sUjgFi
" fun! s:StripTrailingWhitespaces()
"    let l:save = winsaveview()
"    keeppatterns %s/\s\+$//e
"    call winrestview(l:save)
" endfunction

" create command alias safely, see https://bit.ly/2ImFOpL
" the following two functions are taken from answer below on SO
" https://stackoverflow.com/a/10708687/6064933
fun! Cabbrev(key, value)
  exe printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
    \ a:key, 1+len(a:key), Single_quote(a:value), Single_quote(a:key))
endfunction

fun! Single_quote(str)
  return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfunction

" check the syntax group in the current cursor position,
" see http://tinyurl.com/yyzgswxz and http://tinyurl.com/y3lxozey
function! s:SynGroup()

    if !exists('*synstack')
        return
    endif

    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nnoremap <silent> <leader>st :call <SID>SynGroup()<CR>

" the following two functions are from
" https://stackoverflow.com/a/5703164/6064933 (with adaptation)

" check if a colorscheme exists in runtimepath
function! HasColorscheme(name)
    let pat = 'colors/'.a:name.'.vim'
    return !empty(globpath(&runtimepath, pat))
endfunction

" check if an Airline theme exists in runtimepath
function! HasAirlinetheme(name)
    let pat = 'autoload/airline/themes/'.a:name.'.vim'
    return !empty(globpath(&runtimepath, pat))
endfunction
" }}}

" Builtin options and settings {{{

" changing fillchars for folding, so there is no garbage charactes
set fillchars=fold:-,vert:\|

" paste mode toggle, it seems that neovim's bracketed paste mode
" does not work very well for nvim-qt, so we use old paste mode
set pastetoggle=<F12>

" whether to show current line cursor is in
" set cursorline

" split window below when creating horizontal window
set splitbelow

" split window below when creating vertical window
set splitright

" Time in milliseconds to wait for a mapped sequence to complete
" see https://goo.gl/vHvyu8 for more info
set timeoutlen=700

" clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://goo.gl/YAHBbJ
set clipboard+=unnamedplus

" disable creating swapfiles, see https://goo.gl/FA6m6h
set noswapfile

" general tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" show matching bracket
set showmatch

" show line number and relative line number
set number
set relativenumber

" ignore case when searching but become case sensitive when uppercase
" characters are present
set ignorecase
set smartcase

" encoding settings for vim
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" set the script encoding (`:h :scriptencoding`)
scriptencoding utf-8

" line will break at predefined characters
set linebreak

" list all items and start selecting matches
set wildmode=list:longest,full

" set a ruler at column 80 and also set its color
" see https://goo.gl/vEkF5i for more info
set colorcolumn=80

" minimum lines to keep above and below cursor
set scrolloff=5

" use mouse to select window and resizing window, etc
if has('mouse')
    " enable mouse in several mode (see `:h 'mouse'`)
    set mouse=a

    " set the behaviour of mouse
    set mousemodel=popup
endif

" do not show mode on command line because vim-airline can show it already
set noshowmode

" fileformats to use for new file
set fileformats=unix,dos

" the mode to conceal text in cursors
set concealcursor=c

" the way to show the result of subsitute in real time for preview
set inccommand=nosplit

" ignore files or folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.gif,*.bmp,*.tiff
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf

" Ask for confirmation when handling unsaved or read-only files
set confirm

" use visual bells to indicate error, do not use errorbells
set visualbell noerrorbells

" the level we start to fold
set foldlevel=0

" how many history command and search to remember
set history=500

" use list mode and customized listchars
set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:+,trail:·  " ,eol:¬

" string to show before the line that has been soft-wrapped
set showbreak=↪

" auto write the file based on some condition
set autowrite

" change window title
set title

" show hostname, full path of file and lastmod time on the window title.
" The meaning of the format str for strftime can be found in
" http://tinyurl.com/l9nuj4a. The function to get lastmod time is drawn from
" http://tinyurl.com/yxd23vo8
set titlestring=%{hostname()}\ \ %F\ \ \ %{strftime('%Y-%m-%d\ %H:%M',getftime(expand('%')))}

" speed up updatetime so gigutter is quicker
set updatetime=250

" whether to use modelines for security concerns, see https://is.gd/FEzuc7.
" Note that to use modeline in file, you must enable this option
set nomodeline

" persistent undo even after you close and file and reopen it
set undofile

" do not show "match xx of xx" and other messages during auto-completion
set shortmess+=c

" auto select the first completion entry
set completeopt+=noinsert

" completely disable the preview window during autocomplete process,
" see https://goo.gl/18zNPD for more info
set completeopt-=preview

" whether to show tabline to see currently opened files
set showtabline=2

" align indent to next multiple value of shiftwidth, for its meaning,
" see http://tinyurl.com/y5n87a6m
set shiftround

" virtual edit is useful for visual block edit
set virtualedit=block

" always show sign column
set signcolumn=yes
" }}}

" Custom key mappings {{{
" save key strokes (now we do not need to press shift to enter command mode)
nnoremap ; :
vnoremap ; :

" quick way to open command window
nnoremap q; q:

" custom esc. I do not like `kk` because it will delay the vim default `k`
" motion by `timeoutlen` milliseconds (see `:h timeoutlen` for more info)
inoremap <silent> <leader>k <ESC>

" use sane regex expression (see `:h magic` for more info)
nnoremap / /\v
vnoremap / /\v

" paste text above or below current cursor, see
" https://stackoverflow.com/a/1346777/6064933
nnoremap <leader>p o<ESC>p
nnoremap <leader>P O<ESC>p

" shortcut for faster quit
" nmap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>Q :qa<CR>

" go to previous and next item in location list
nnoremap [l :lprevious<CR>
nnoremap ]l :lnext<CR>

" go to previous and next item in quickfix list
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>

" close location list or quickfix list if they are present,
" see https://goo.gl/uXncnS
nnoremap<silent> \x :windo lcl\|ccl<CR>

" toggle highlight search, see https://goo.gl/3H85hh
nnoremap <silent><expr> <Leader>hl (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Disable arrow key in vim, see https://goo.gl/s1yfh4
" disable arrow key for normal mode
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

" disable arrow key for insert mode
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" insert a blank line below or above
" see https://stackoverflow.com/a/16136133/6064933
nnoremap oo o<ESC>
nnoremap OO O<ESC>

" insert a space after current character
nnoremap <silent> <Space><Space> a<Space><ESC>h

" yank from current cursor position to end of line
nnoremap Y y$

" move cursor based on physical lines not the actual lines.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nmap $ g$
nmap ^ g^
nmap 0 g0

" resize windows using alt and h,j,k,l, inspiration from
" https://goo.gl/vVQebo (bottom page).
" If you enable mouse support, shorcut below may not be necessary
" resize window in vertical directory
nnoremap <silent> <M-h> <C-w><
nnoremap <silent> <M-l> <C-w>>
" resize window in horizontal directory
nnoremap <silent> <M-j> <C-W>-
nnoremap <silent> <M-k> <C-W>+

" fast window switching, inspiration from
" https://stackoverflow.com/a/4373470/6064933
nnoremap <silent> <M-left> <C-w>h
nnoremap <silent> <M-right> <C-w>l
nnoremap <silent> <M-down> <C-w>j
nnoremap <silent> <M-up> <C-w>k

" continuous visual shifting (does not exit Visual mode), `gv` means
" to reselect previous visual area, see https://goo.gl/m1UeiT
vnoremap < <gv
vnoremap > >gv

" when completion menu is shown, use <cr> to select an item
" and do not add an annoying newline, otherwise, <enter> is just what it is,
" for more info , see https://goo.gl/KTHtrr and https://goo.gl/MH7w3b
inoremap <expr> <cr> ((pumvisible())?("\<C-Y>"):("\<cr>"))

" use <esc> to close auto-completion menu
inoremap <expr> <esc> ((pumvisible())?("\<C-e>"):("\<esc>"))

" switching buffers quickly, extracted from vim-unimpaired
nnoremap <silent> [b :bp<cr> " go to previous buffer
nnoremap <silent> ]b :bn<cr> " go to next buffer

" reload init.vim quickly and give a message
nnoremap <silent> <leader>sv :so $MYVIMRC<cr>
    \ :echom "Nvim config successfully reloaded!"<cr>

" edit init.vim in a vertical split
nnoremap <silent> <leader>ev :edit $MYVIMRC<cr>

" delete a buffer and switching to another buffer, do not close the
" window, see https://goo.gl/Wd8yZJ
nnoremap <silent> \d :bprevious<CR>:bdelete #<CR>

" nnoremap <silent> <leader><Space> :call <SID>StripTrailingWhitespaces()<CR>
" autocmd FileType * autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" do not include white space character when using $ in visual mode,
" see https://goo.gl/PkuZox
vnoremap $ g_

" jump to matching pairs easily in normal mode
nmap <Tab> %

" go to start or end of line easier
nnoremap H ^
nnoremap L $

" reselect the text that has just been pasted
nnoremap <leader>v `[V`]

" find and replace (like Sublime Text 3)
nnoremap <C-H> :%s/\v

" change current working locally to where the opened file resides
" see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

" reduce indent level in insert mode with shift+tab
inoremap <S-Tab> <ESC><<i
" }}}

" Auto commands {{{

" automatically save current file and execute it when pressing the <F9> key
" it is useful for small script
augroup filetype_auto_build_exec
    autocmd!
    autocmd FileType python nnoremap <buffer> <F9> :exec 'w !python'
                \ shellescape(@%, 1)<CR>
    autocmd FileType cpp nnoremap <F9> :w <CR> :!g++ -Wall -std=c++11 %
                \ -o %<&&./%<<CR>
augroup END

" do not use smart case in command line mode
" extracted from https://goo.gl/vCTYdK
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

" set textwidth for text file types
augroup text_file_width
    autocmd!
    " sometimes, automatic filetype detection is not right, so we need to
    " detect the filetype based on the file extensions
    autocmd FileType text,tex setlocal textwidth=79
    autocmd BufNewFile,BufRead *.md,*.MD,*.markdown setlocal textwidth=79
augroup END

" do not use number and relative number for terminal inside nvim
augroup term_settings
    autocmd!
    " donot use number and relatiev number for terminal
    autocmd TermOpen * setlocal norelativenumber nonumber
    " go to insert mode by default to start typing command
    autocmd TermOpen * startinsert
augroup END

" start insert mode when open the command window
augroup cmd_mode_settings
    autocmd!
    autocmd CmdwinEnter [:]  startinsert
augroup END

" more accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

" Return to last edit position when opening a file (see ':h line()')
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   execute "normal! g`\"zvzz"
        \ | endif
augroup END

augroup vim_script_setting
    autocmd!

    " set the folding related options for vim script. Setting folding option in
    " modeline is annoying in that the modeline get executed each time the window
    " focus is lost, also see http://tinyurl.com/yyqyyhnc
    autocmd FileType vim set foldmethod=marker foldmarker={{{,}}}
        \ foldlevel=0 foldlevelstart=-1

    " Simply set formatoptions without autocmd does not work for vim filetype
    " because the option is overruled by vim's default ftplugin for vim
    " unfortunately. The following way to use autocmd seems quick and dirty and
    " may not be the best way to do it (I do this because I don't want to split my
    " vim config).  For more discussions, see http://tinyurl.com/yyznar7r and
    " http://tinyurl.com/zehso5h

    " some format options when editting text file
    " donot insert comment leader after hitting o or O
    autocmd FileType vim setlocal formatoptions-=o

    " donot insert comment leader after hitting <Enter> in insert mode
    autocmd FileType vim setlocal formatoptions-=r

    " use :help command for keyword when pressing `K` in vim file,
    " see `:h K` and https://bre.is/wC3Ih-26u
    autocmd FileType vim setlocal keywordprg=:help
augroup END
" }}}

" Plugin install part {{{

" set up directory to install all the plugins depending on the platform
if has('win32')
    let s:PLUGIN_HOME='~/AppData/Local/nvim/plugged'
else
    let s:PLUGIN_HOME='~/.local/share/nvim/plugged'
endif

" auto-install vim-plug on different systems.
" For Windows, only Windows 10 with curl command installed are tested (after
" Windows 10 build 17063, source: http://tinyurl.com/y23972tt)
" The following script to install vim-plug are adapted from
" vim-plug tips: https://bit.ly/2IhJDNb

if !executable('curl')
    echoerr 'You have to install curl to install vim-plug or install vim-plug
            \ yourself following the guide on vim-plug git repository'
    execute 'q!'
else

    if has('unix')
        if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
            echo 'Installing Vim-plug on your system'

            silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

            augroup plug_init
                autocmd!
                autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
            augroup END
        endif
    elseif has('win32')
        if empty(glob('~\AppData\Local\nvim\autoload\plug.vim'))
            echo 'Installing Vim-plug on your system'

            silent !curl -fLo C:\Users\Administrator\AppData\Local\nvim\autoload\plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

            augroup plug_init
                autocmd!
                autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
            augroup END
        endif
    endif
endif

call plug#begin(s:PLUGIN_HOME)

""""""""""""""""""""""" autocompletion related plugins """""""""""""""""""""""

" settings for deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" snippet engine
Plug 'SirVer/ultisnips'

" snippet template for ultisnips
Plug 'honza/vim-snippets'

" for insert mode completion
Plug 'ervandew/supertab'

" python source for deoplete
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

" vim source for deoplete
Plug 'Shougo/neco-vim', { 'for': 'vim' }

""""""""""""""""""""""" python-related plugins """""""""""""""""""""""

" Python completion, goto definition etc.
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Python syntax highlighting
Plug 'vim-python/python-syntax', { 'for': 'python' }

" python syntax highlighting and more
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }

" python code folding
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

" python indent (follows the PEP8 style)
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}

""""""""""""""""""""""" search related plugins"""""""""""""""""""""""

" extend vim's default search behaviour
Plug 'inkarkat/vim-SearchHighlighting'

" required by vim-SearchHighlighting
Plug 'inkarkat/vim-ingo-library'

" super fast movement with vim-sneak
Plug 'justinmk/vim-sneak'

" improve vim incsearch
Plug 'haya14busa/is.vim'

" show match number for incsearch
Plug 'osyo-manga/vim-anzu'

" another grep tool (similar to Sublime Text Ctrl+Shift+F)
" TODO: worth trying and exploring
Plug 'dyng/ctrlsf.vim'

" file search, tag search and more
if has('win32')
    Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
else
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
endif
" another similar plugin is command-t
" Plug 'wincent/command-t'

" only use fzf for Linux and Mac since fzf does not work well for Windows
if has('unix')
    " fuzzy file search and more
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
endif

""""""""""""""""""""""""""" color, theme, look """"""""""""""""""""""""""""""

" A list of colorscheme plugin you may want to try. Find what suits you.

" colorscheme gruvbox
Plug 'morhetz/gruvbox'

" colorschme onedark
" Plug 'joshdick/onedark.vim'

" monokai theme for vim
" Plug 'sickill/vim-monokai'

" sublime-monokai colorscheme
Plug 'ErichDonGubler/vim-sublime-monokai'

" deus theme for vim
Plug 'ajmwagar/vim-deus'

" challenger_deep color theme
" Plug 'challenger-deep-theme/vim'

" Plug 'lifepillar/vim-solarized8'

" Plug 'whatyouhide/vim-gotham'

" Plug 'yous/vim-open-color'

" Plug 'arcticicestudio/nord-vim'

" Plug 'rakr/vim-one'

" Plug 'kaicataldo/material.vim'

Plug 'hzchirs/vim-material'

" wonderful status line
Plug 'vim-airline/vim-airline'

" vim-airline theme
Plug 'vim-airline/vim-airline-themes'

" lightline status bar (a simpler alternative to vim-airline)
" Plug 'itchyny/lightline.vim'

" show indent lines for better comprehension of the code structure
" currently, blank lines inside the indent block do not show indent guides,
" see https://github.com/Yggdroot/indentLine/issues/25
Plug 'Yggdroot/indentLine'

" fancy vim start screen
Plug 'mhinz/vim-startify'

""""""""""""""""""""""""""plugin to deal with URL """""""""""""""""""""""""""

" highlight URLs inside vim
Plug 'itchyny/vim-highlighturl'

" For Windows and Mac, we can open URL in browser. For Linux, it may not be
" possible since we maybe in a server which disable X11
if has('win32') || has('macunix')

    " open URL in browser
    Plug 'tyru/open-browser.vim'
endif

""""""""""""""""""""""""""navigation and tags plugin"""""""""""""""""""""""""""
" file explorer for vim
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

" only install these plugins if ctags are installed on the system
if executable('ctags')

    " plugin to manage tags (must install ctags on system)
    Plug 'ludovicchabant/vim-gutentags'

    " show file tags in vim windows (must install ctags on system)
    Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen'] }
endif

""""""""""""""""""""""""""""file editting plugin""""""""""""""""""""""""""""

" automatic character pair insertion and deletion
Plug 'jiangmiao/auto-pairs'

" comment plugin
Plug 'scrooloose/nerdcommenter'

" multiline editting plugin. It becomes slow if you try to edit many
" occurences of a variable
" Plug 'terryma/vim-multiple-cursors'

" another multiple cursor plugin
" Plug 'mg979/vim-visual-multi'

" title character case
Plug 'christoomey/vim-titlecase'

" autosave files on certain events
Plug '907th/vim-auto-save'

" graphcial undo history, see https://github.com/mbbill/undotree
Plug 'mbbill/undotree'

" another plugin to show undo history is: http://tinyurl.com/jlsgjy5
" Plug 'simnalamburt/vim-mundo'

if has('win32') || has('macunix')
    " manage your yank history
    " TODO: it seems that this plugin does not work if you connect to remote
    " Linux server and use it with neovim on the server.
    Plug 'svermeulen/vim-yoink'

    " another yank history yank
    " Plug 'bfredl/nvim-miniyank'
endif

" strip trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" show marks in sign column for quicker navigation
Plug 'kshenoy/vim-signature'

" another good plugin to show signature
" https://github.com/jeetsukumaran/vim-markology
" Plug 'jeetsukumaran/vim-markology'

""""""""""""""""""""""""""""linting, formating """"""""""""""""""""""""""""

" auto format tool
Plug 'sbdchd/neoformat'

" another auto format tool
" Plug 'Chiel92/vim-autoformat'

" syntax check and make
Plug 'neomake/neomake'

" another linting plugin
" Plug 'w0rp/ale'

""""""""""""""""""""""""""""""git related plugins """"""""""""""""""""""""""

" show git change (change, delete, add) signs in vim sign column
Plug 'airblade/vim-gitgutter'

" git command inside vim
Plug 'tpope/vim-fugitive'

" git commit browser
Plug 'junegunn/gv.vim', { 'on': 'GV' }

""""""""""""""""""""""""""""plugins for markdown writing""""""""""""""""""""

" distraction free writing
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

" only light on your cursor line
Plug 'junegunn/limelight.vim', {'for': 'markdown'}

" markdown syntax highlighting
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }

" another markdown plugin
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" If we are on Win or Mac, preview the markdown in system default browser.
if has('win32') || has('macunix')
    " markdown previewing
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' }
endif

" faster footnote generation
Plug 'vim-pandoc/vim-markdownfootnotes', { 'for': 'markdown' }

" vim tabular plugin for manipulate tabular, required by markdown plugins
Plug 'godlygeek/tabular'

" markdown JSON header highlight plugin
Plug 'elzr/vim-json', { 'for': ['json', 'markdown'] }

""""""""""""""""""""""""""text object plugins """"""""""""""""""""""""""

" additional powerful text object for vim, this plugin should be studied
" carefully to use its full power
Plug 'wellle/targets.vim'

" Plugin to manipulate characer pairs quickly
Plug 'tpope/vim-surround'

" add indent object for vim (useful for languages like Python)
Plug 'michaeljsmith/vim-indent-object'

""""""""""""""""""""""latex editting and previewing plugin"""""""""""""""""

" Only use these plugin on Windows and Mac and when a LaTeX distribution has
" been deteced
if ( has('macunix') || has('win32') ) && executable('latex')

    " vimtex use autoload feature of Vim, so it is not necessary to use `for`
    " keyword of vim-plug to try to lazy-load it,
    " see http://tinyurl.com/y3ymc4qd
    Plug 'lervag/vimtex'

    " Plug 'matze/vim-tex-fold', {'for': 'tex'}
endif

Plug 'Konfekt/FastFold'

"""""""""""""""""""""""""""""""tmux related plugins """""""""""""""""""""""""

" Since tmux is only available on Linux and Mac, we only enable these plugins
" for Linux and Mac
if has('unix') && executable('tmux')

    " let vim detect tmux focus event correctly, see
    " http://tinyurl.com/y4xd2w3r and http://tinyurl.com/y4878wwm
    Plug 'tmux-plugins/vim-tmux-focus-events'

    " .tmux.conf syntax highlighting and setting check
    Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
endif

""""""""""""""""""""""""""""""" misc plugins """""""""""""""""""""""""""""""""

" automatically toggle line number based on several conditions
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" highlight yanked region
Plug 'machakann/vim-highlightedyank'

" repeat vim motions
Plug 'tpope/vim-repeat'

" quickly run a code script
Plug 'thinca/vim-quickrun'

" modern matchit implementation
Plug 'andymass/vim-matchup'

" simulating smooth scroll motions with physcis
Plug 'yuttie/comfortable-motion.vim'
call plug#end()
" }}}

" Plugin settings {{{

""""""""""""""""""""""" vim-plug settings""""""""""""""""""""""""""

" use shortnames for common vim-plug command to reduce typing
" To use these shortcut: first activate command line with `:`, then input the
" short alias name, e.g., `pi`, then press <space>, the alias will be expanded
" to the original command automatically
call Cabbrev('pi', 'PlugInstall')
call Cabbrev('pud', 'PlugUpdate')
call Cabbrev('pug', 'PlugUpgrade')
call Cabbrev('ps', 'PlugStatus')
call Cabbrev('pc', 'PlugClean')

""""""""""""""""""""""" deoplete settings""""""""""""""""""""""""""

" wheter to enable deoplete automatically after start nvim
let g:deoplete#enable_at_startup = 0

" start deoplete when we go to insert mode
augroup deoplete_start
    autocmd!
    autocmd InsertEnter * call deoplete#enable()
augroup END

" maximum candidate window length
call deoplete#custom#source('_', 'max_menu_width', 80)

" minimum character length needed to start completion,
" see https://goo.gl/QP9am2
call deoplete#custom#source('_', 'min_pattern_length', 1)

" whether to disable completion for certain syntax

" call deoplete#custom#source('_', {
"     \ 'filetype': ['vim'],
"     \ 'disabled_syntaxes': ['String']
"     \ })

" disable auto-completion for python in certain syntax groups
call deoplete#custom#source('_', {
    \ 'filetype': ['python'],
    \ 'disabled_syntaxes': ['Comment']
    \ })

" ignore certain sources, because they only cause nosie most of the time
call deoplete#custom#option('ignore_sources', {
   \ '_': ['around', 'buffer', 'tag']
   \ })

" candidate list item limit
call deoplete#custom#option('max_list', 30)

"The number of processes used for the deoplete parallel feature.
call deoplete#custom#option('num_processes', 32)

" Delay the completion after input in milliseconds.
call deoplete#custom#option('auto_complete_delay', 10)

" enable or disable deoplete auto-completion
call deoplete#custom#option('auto_complete', v:true)

" automatically close function preview windows after completion
" see https://goo.gl/Bn5n39
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete, see https://goo.gl/LvwZZY
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

""""""""""""""""""deoplete-jedi settings"""""""""""""""""""""""""""

" whether to show doc string
let g:deoplete#sources#jedi#show_docstring = 0

" do not use typeinfo (for faster completion)
let g:deoplete#sources#jedi#enable_typeinfo = 0

" for large package, set autocomplete wait time longer
let g:deoplete#sources#jedi#server_timeout = 50

""""""""""""""""""""""""jedi-vim settings"""""""""""""""""""

" disable autocompletion, because I use deoplete for auto-completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
" let g:jedi#use_splits_not_buffers = 'right'

" show function call signature
let g:jedi#show_call_signatures = '2'

"""""""""""""""""""""""comfortable-motion settings """"""""""""""""""""""

let g:comfortable_motion_scroll_down_key = 'j'
let g:comfortable_motion_scroll_up_key = 'k'

" mouse settings
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

"""""""""""""""""""""""""""""vim-sneak settings"""""""""""""""""""""""

let g:sneak#label = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"""""""""""""""""""""""""""""vim-anzu settings"""""""""""""""""""""""

" nmap n zzzv<Plug>(anzu-n-with-echo)
" nmap N zzzv<Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" clear matching info on status line with double <Esc>
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)

""""""""""""""""""""""""""""is.vim settings"""""""""""""""""""""""

" to make is.vim work together well with vim-anzu and put current match in
" the center of the window
" `zz`: put cursor line in center of the window
" `zv`: open a fold to reveal the text when cursor step into it
nmap n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)zzzv
nmap N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)zzzv

""""""""""""""""""""""""""""nerdcommenter settings"""""""""""""""""""

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" use one space after # comment character in python,
" see http://tinyurl.com/y4hm29o3
let g:NERDAltDelims_python = 1

" Align line-wise comment delimiters flush left instead
" of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

""""""""""""""""""""""""""""vim-yoink settings"""""""""""""""""""""""""

if has('win32')
    " TODO: test yoink on Mac to see if it works
    " it seems that ctrl-n and ctrl-p does not work on neovim
    " nmap <c-n> <plug>(YoinkPostPasteSwapBack)
    " nmap <c-p> <plug>(YoinkPostPasteSwapForward)

    nmap p <plug>(YoinkPaste_p)
    nmap P <plug>(YoinkPaste_P)

    " cycle the yank stack with the following mappings
    nmap [y <plug>(YoinkRotateBack)
    nmap ]y <plug>(YoinkRotateForward)

    " not change the cursor position
    nmap y <plug>(YoinkYankPreserveCursorPosition)
    xmap y <plug>(YoinkYankPreserveCursorPosition)

    " move cursor to end of paste after multiline paste
    let g:yoinkMoveCursorToEndOfPaste = 1

    " record yanks in system clipboard
    let g:yoinkSyncSystemClipboardOnFocus = 1
endif

"""""""""""""""""""""""""supertab settings""""""""""""""""""""""""""

" auto-close method preview window
"let g:SuperTabClosePreviewOnPopupClose = 1

" use the default top to bottom way for scroll, see https://goo.gl/APdo9V
let g:SuperTabDefaultCompletionType = '<c-n>'

" shortcut to navigate forward and backward in completion menu
" see https://is.gd/AoSv4m
let g:SuperTabMappingForward = '<tab>'
let g:SuperTabMappingBackward = '<s-tab>'

""""""""""""""""""""""""vim-auto-save settings"""""""""""""""""""""""

" enable AutoSave on nvim startup
let g:auto_save = 1

" the event to trigger autosave
let g:auto_save_events = ['InsertLeave', 'TextChanged']

" show autosave status on command line
let g:auto_save_silent = 0

"""""""""""""""""""""""""indentLine settings""""""""""""""""""""""""""

" whether to enable indentLine
let g:indentLine_enabled = 1

" the character used for indicating indentation
" let g:indentLine_char = '┊'
let g:indentLine_char = '│'

" whether to use conceal color by indentLine
let g:indentLine_setColors = 0

" show raw code when cursor is current line (mainly for markdown file)
" see https://github.com/plasticboy/vim-markdown/issues/395
let g:indentLine_concealcursor = ''

"""""""""""""""""""""""""""""" neomake settings """""""""""""""""""""""

" when writing or reading a buffer, and
" on changes in normal mode (after 0.5s; no delay when writing).
call neomake#configure#automake('nrw', 50)

" change warning signs and color, see https://goo.gl/eHcjSq
" highlight NeomakeErrorMsg ctermfg=227 ctermbg=237
let g:neomake_warning_sign={'text': '!', 'texthl': 'NeomakeWarningSign'}
let g:neomake_error_sign={'text': '✗'}

" which linter to enable for Python source file linting
" let g:neomake_python_enabled_makers = ['flake8', 'pylint']
let g:neomake_python_enabled_makers = ['flake8']

" do not highlight columns, it works bad for sublimemonokai
" see https://goo.gl/wd68ex for more info
let g:neomake_highlight_columns = 1

" whether to open quickfix or location list automatically
let g:neomake_open_list = 0

"let g:neomake_python_pylint_maker = {
"  \ 'args': [
"  \ '-d', 'C0103, C0111',
"  \ '-f', 'text',
"  \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"',
"  \ '-r', 'n'
"  \ ],
"  \ 'errorformat':
"  \ '%A%f:%l:%c:%t: %m,' .
"  \ '%A%f:%l: %m,' .
"  \ '%A%f:(%l): %m,' .
"  \ '%-Z%p^%.%#,' .
"  \ '%-G%.%#',
"  \ }

""""""""""""""""""""""" nerdtree settings """"""""""""""""""""""""""

" toggle nerdtree window and keep cursor in file window,
" adapted from http://tinyurl.com/y2kt8cy9
nnoremap <silent> <C-k><C-B> :NERDTreeToggle<CR>:wincmd p<CR>

" ignore certain files and folders
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']

" reveal currently editted file in nerdtree widnow,
" see https://goo.gl/kbxDVK
nmap <silent> ,nf :NERDTreeFind<CR>

" exit vim when the only window is nerdtree window, see
" https://github.com/scrooloose/nerdtree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
"     \ b:NERDTree.isTabTree()) | q | endif

" automatically show nerdtree window on entering nvim,
" see https://github.com/scrooloose/nerdtree, but now the cursor
" is in nerdtree window, so we need to change it to the file window,
" extracted from https://goo.gl/vumpvo
" autocmd VimEnter * NERDTree | wincmd l

" delete a file buffer when you have deleted it in nerdtree
let NERDTreeAutoDeleteBuffer = 1

" show current root as realtive path from HOME in status bar,
" see https://github.com/scrooloose/nerdtree/issues/891
let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"

" disable bookmark and 'press ? for help ' text
let NERDTreeMinimalUI=0

""""""""""""""""""""""""""" tagbar settings """"""""""""""""""""""""""""""""""

" shortcut to toggle tagbar window
nnoremap <silent> <C-K><C-T> :TagbarToggle<CR>

"""""""""""""""""""""""""""vim-airline setting""""""""""""""""""""""""""""""

" set a airline theme only if it exists, else we resort to default color
if HasAirlinetheme('deus')
    let g:airline_theme='deus'
else
    let g:airline_theme='dark_minimal'
endif

" show tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

" whether to show function or other tags on status line
let g:airline#extensions#tagbar#enabled = 0

" skip empty sections if nothing to show
" extract from https://vi.stackexchange.com/a/9637/15292
let g:airline_skip_empty_sections = 1

" show buffer number for easier switching between buffer
" see https://github.com/vim-airline/vim-airline/issues/1149
let g:airline#extensions#tabline#buffer_nr_show = 1

"make airline more beautiful, see https://goo.gl/XLY19H for more info
let g:airline_powerline_fonts = 1

" show only hunks which is non-zero (git-related)
let g:airline#extensions#hunks#non_zero_only = 1

" enable gutentags integration
let g:airline#extensions#gutentags#enabled = 1

" custom status line symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

""""""""""""""""""" vim-highlightedyank settings """"""""""""""

" reverse the highlight color for yanked text for better visuals
highlight HighlightedyankRegion cterm=reverse gui=reverse

" let highlight endures longer
let g:highlightedyank_highlight_duration = 1000

""""""""""""""""""""""""""neoformat settins""""""""""""""""""""

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

"""""""""""""""""""""""""fzf settings""""""""""""""""""""""""""

" only use fzf on Mac and Linux, since it doesn't work well for Windows
if has('unix')

    " hide status line when open fzf window
    augroup fzf_hide_statusline
        autocmd!
        autocmd! FileType fzf
        autocmd  FileType fzf set laststatus=0 noshowmode noruler
                    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    augroup END

    " search file recursively under current folder
    nnoremap <silent> <leader>f :FZF<cr>

    " search file recursively under HOME (You may do want to do this!)
    " nnoremap <silent> <leader>F :FZF ~<cr>

    """""""""""""""""""""""""fzf.vim settings""""""""""""""""""

    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    " [Tags] Command to generate tags file
    let g:fzf_tags_command = 'ctags -R'

    " floating windows only works for latest nvim version
    " floating window searching for fzf
    let $FZF_DEFAULT_OPTS = '--layout=reverse'

    " use floating window to open the fzf search window
    let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

    function! OpenFloatingWin()

        let height = &lines - 3
        let width = float2nr(&columns - (&columns * 2 / 10))
        let col = float2nr((&columns - width) / 2)

        " set up the attribute of floating window
        let opts = {
                \ 'relative': 'editor',
                \ 'row': height * 0.3,
                \ 'col': col + 20,
                \ 'width': width * 2 / 3,
                \ 'height': height / 2
                \ }

        let buf = nvim_create_buf(v:false, v:true)
        let win = nvim_open_win(buf, v:true, opts)

        " floating window highlight setting
        call setwinvar(win, '&winhl', 'Normal:Pmenu')

        setlocal
                \ buftype=nofile
                \ nobuflisted
                \ bufhidden=hide
                \ nonumber
                \ norelativenumber
                \ signcolumn=no
    endfunction

endif

""""""""""""""""""""""""""quickrun settings"""""""""""""""""""""""""""""

let g:quickrun_no_default_key_mappings = 1
nnoremap<silent> <F9> :QuickRun<CR>
let g:quickrun_config = {'outputter/buffer/close_on_empty': 1}

"""""""""""""""""""""""""goyo.vim settings""""""""""""""""""""""""""""""

" make goyo and limelight work together automatically
augroup goyo_work_with_limelight
    autocmd!
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
augroup END

"""""""""""""""""""""""""plasticboy/vim-markdown settings"""""""""""""""""""

" disable header folding
let g:vim_markdown_folding_disabled = 1

" whether to use conceal feature in markdown
let g:vim_markdown_conceal = 1

" disable math tex conceal and syntax highlight
let g:tex_conceal = ''
let g:vim_markdown_math = 0

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

" let the TOC window autofit so that it doesn't take too much space
let g:vim_markdown_toc_autofit = 1

"""""""""""""""""""""""""markdown-preview settings"""""""""""""""""""

" only setting this for suitable platforms
if has('win32') || has('macunix')
    " do not close the preview tab when switching to other buffers
    let g:mkdp_auto_close = 0

    " shortcut to start markdown previewing
    nnoremap <M-m> :MarkdownPreview<CR>
endif

"""""""""""""""""""""""""vim-pandoc-syntax settings"""""""""""""""""""""""""

" do not conceal urls (seems does not work)
let g:pandoc#syntax#conceal#urls = 0

" use pandoc-syntax for markdown files, it will disable conceal feature for
" links, use it at your own risk
augroup pandoc_syntax
  au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

"""""""""""""""""""""""""python-syntax highlight settings"""""""""""""""""""

" highlight all
let g:python_highlight_all = 1

"""""""""""""""""""""""""" semshi settings """""""""""""""""""""""""""""""

" do not highlight variable under cursor
let g:semshi#mark_selected_nodes=0

" do not show error sign since neomake is specicialized for that
let g:semshi#error_sign=v:false

"""""""""""""""""""""""""UltiSnips settings"""""""""""""""""""

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<tab>'

" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<c-j>'

" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" directory `my_snippets` should be put under your config directory (use
" `:echo stdpath('config')` to show the config directory).
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'my_snippets']

""""""""""""""""""""""""""""vim-titlecase settings"""""""""""""""""""""""

" do not use the default mapping provided
let g:titlecase_map_keys = 0

nmap <leader>gt <Plug>Titlecase
vmap <leader>gt <Plug>Titlecase
nmap <leader>gT <Plug>TitlecaseLine

""""""""""""""""""""""""""""vimtex settings"""""""""""""""""""""""""""""

if ( has('macunix') || has('win32')) && executable('latex')
    " enhanced matching with matchup plugin
    let g:matchup_override_vimtex = 1

    " set up LaTeX flavor
    let g:tex_flavor = 'latex'

    " deoplete configurations for autocompletion to work
    call deoplete#custom#var('omni', 'input_patterns', {
              \ 'tex': g:vimtex#re#deoplete
              \})

    let g:vimtex_compiler_latexmk = {
         \ 'backend' : 'nvim',
         \ 'background' : 1,
         \ 'build_dir' : 'build',
         \ 'callback' : 1,
         \ 'continuous' : 1,
         \ 'executable' : 'latexmk',
         \ 'options' : [
         \   '-verbose',
         \   '-file-line-error',
         \   '-synctex=1',
         \   '-interaction=nonstopmode',
         \ ],
         \}

    " Compile on initialization, cleanup on quit
    augroup vimtex_event_1
       au!
       au User VimtexEventInitPost call vimtex#compiler#compile()
       au User VimtexEventQuit     call vimtex#compiler#clean(0)
    augroup END

    " TOC settings
    let g:vimtex_toc_config = {
          \ 'name' : 'TOC',
          \ 'layers' : ['content', 'todo', 'include'],
          \ 'resize' : 1,
          \ 'split_width' : 50,
          \ 'todo_sorted' : 0,
          \ 'show_help' : 1,
          \ 'show_numbers' : 1,
          \ 'mode' : 2,
          \}

    " viewer settings for different platforms
    if has('win32')
        let g:vimtex_view_general_viewer = 'SumatraPDF'
        let g:vimtex_view_general_options_latexmk = '-reuse-instance'
        let g:vimtex_view_general_options
            \ = '-reuse-instance -forward-search @tex @line @pdf'
    endif

    if has('macunix')
        " let g:vimtex_view_method = "skim"
        let g:vimtex_view_general_viewer
                \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'

        " This adds a callback hook that updates Skim after compilation
        let g:vimtex_compiler_callback_hooks = ['UpdateSkim']

        function! UpdateSkim(status)
            if !a:status | return | endif

            let l:out = b:vimtex.out()
            let l:tex = expand('%:p')
            let l:cmd = [g:vimtex_view_general_viewer, '-r']

            if !empty(system('pgrep Skim'))
                call extend(l:cmd, ['-g'])
            endif

            if has('nvim')
                call jobstart(l:cmd + [line('.'), l:out, l:tex])
            elseif has('job')
                call job_start(l:cmd + [line('.'), l:out, l:tex])
            else
                call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
            endif
        endfunction
    endif
endif

"""""""""""""""""""""""""""""auto-pairs settings"""""""""""""""""""""""""

augroup filetype_custom_autopair
autocmd!
    " only use the following character pairs for tex file
    au FileType tex let b:AutoPairs = {'(':')', '[':']', '{':'}'}

    " add `<>` pair to filetype vim
    au FileType vim let b:AutoPairs = AutoPairsDefine({'<' : '>'})
augroup END

""""""""""""""""""""""""""""open-browser.vim settings"""""""""""""""""""

if has('win32') || has('macunix')
    " disable netrw's gx mapping.
    let g:netrw_nogx = 1

    " use another mapping for the open URL method
    nmap ob <Plug>(openbrowser-smart-search)
    vmap ob <Plug>(openbrowser-smart-search)
endif

""""""""""""""""""""""""""""vim-matchup settings"""""""""""""""""""""""""""""

" disable matching inside comment
let g:matchup_delim_noskips = 2   " don't recognize anything in comments

" change highlight color of matching bracket for better visual effects
augroup matchup_matchparen_highlight
  autocmd!
  autocmd ColorScheme * highlight MatchParen cterm=underline gui=underline
augroup END

" show matching keyword as underlined text to reduce color clutter
augroup matchup_matchword_highlight
    autocmd!
    autocmd ColorScheme * hi MatchWord cterm=underline gui=underline
augroup END

"""""""""""""""""""""vim-better-whitespace settings""""""""""""""""""""""""""

" whether to highlight trailing whitespace with the default red color (I find
" it distracting so I turn it off)
let g:better_whitespace_enabled=0

" set a mapping for StripWhitespace command
nnoremap <silent> <leader><Space> :StripWhitespace<CR>

" strip white line at the end of the file
let g:strip_whitelines_at_eof=1

" disable whitespace operator
let g:better_whitespace_operator=''

""""""""""""""""""""""""""""""vim-signature settings""""""""""""""""""""""""""

" change mark highlight to be more visible
augroup signature_highlight
autocmd!
autocmd ColorScheme * highlight SignatureMarkText cterm=bold ctermbg=10
    \ gui=bold guifg=#aeee04
augroup END

"""""""""""""""""""""""""vim-highlighturl settings"""""""""""""""""""""""""

" whether to underline the URL
let g:highlighturl_underline=1

""""""""""""""""""""""""vim-markdownfootnotes settings""""""""""""""""""""""""

" replace the default mappings provided by the plugin
imap ^^ <Plug>AddVimFootnote
nmap ^^ <Plug>AddVimFootnote

imap @@ <Plug>ReturnFromFootnote
nmap @@ <Plug>ReturnFromFootnote
" }}}

" Colorscheme and highlight settings {{{

"general settings about colors

" enable true colors support (do not use this option if your terminal does not
" support true colors. For a comprehensive list of terminals supporting true
" colors, see https://github.com/termstandard/colors and
" https://bit.ly/2InF97t)
set termguicolors

" use dark background (better for the eye, IMHO)
set background=dark

""""""""""""""""""""""""""""gruvbox settings"""""""""""""""""""""""""""

" we should check if theme exists before using it, otherwise you will get
" error message when starting Nvim
if HasColorscheme('gruvbox')
    " italic options should be put before colorscheme setting,
    " see https://goo.gl/8nXhcp
    let g:gruvbox_italic=1
    let g:gruvbox_contrast_dark='hard'
    colorscheme gruvbox
else
    " fall back to pre-installed theme
    colorscheme desert
endif

""""""""""""""""""""""""""" onedark.vim  settings"""""""""""""""""""""""""
" let g:onedark_terminal_italics = 1
" colorscheme onedark

""""""""""""""""""""""""""" deus  settings"""""""""""""""""""""""""""""""""
" colorscheme deus

"""""""""""""""""""""""" challenger_deep  settings""""""""""""""""""""""""
" colorscheme challenger_deep

""""""""""""""""""""""""""" solarized8  settings"""""""""""""""""""""""""

" solarized colorscheme without bullshit
" let g:solarized_term_italics=1
" let g:solarized_visibility="high"
" colorscheme solarized8_high

""""""""""""""""""""""""""" sublimemonokai  settings"""""""""""""""""""""""""
" let g:sublimemonokai_term_italic = 1
" colorscheme sublimemonokai

""""""""""""""""""""""""""" nord-vim  settings"""""""""""""""""""""""""

" let g:nord_italic = 1
" let g:nord_underline = 1
" let g:nord_italic_comments = 1
" colorscheme nord

""""""""""""""""""""""""""" vim-one  settings"""""""""""""""""""""""""""""

" let g:one_allow_italics = 1
" colorscheme one

"""""""""""""""""""""""""""material.vim settings""""""""""""""""""""""""""

" let g:material_terminal_italics = 1
" " theme_style can be 'default', 'dark' or 'palenight'
" let g:material_theme_style = 'default'
" colorscheme material

"""""""""""""""""""""""""""vim-material settings""""""""""""""""""""""""""

" let g:material_style='palenight'
" colorscheme vim-material

"""""""""""""""""""""""""""custom highlight group settings""""""""""""""""""

" change the color of popup menu for autocompletion
" extracted from spf13-vim, see https://goo.gl/frRXHP
" highlight Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
" highlight PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan
"             \ ctermbg=lightgray cterm=NONE
" highlight PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray
"             \ ctermbg=darkcyan cterm=NONE

"custom highlight for ColorColumn
" highlight ColorColumn ctermbg=235 guibg=#2c2d27
" }}}

" A list of resources which inspire me {{{

" this list is non-exhaustive as I can not remember the source of many
" settings

" - http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" - https://github.com/tamlok/tvim/blob/master/.vimrc
" - https://nvie.com/posts/how-i-boosted-my-vim/
" - https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/
" - https://sanctum.geek.nz/arabesque/vim-anti-patterns/
" - https://github.com/gkapfham/dotfiles/blob/master/.vimrc
" }}}
