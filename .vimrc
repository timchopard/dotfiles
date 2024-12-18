syntax enable
colorscheme gruvbox
set background=dark

" Set smart search (only case sensitive if incl. upper case)
set ignorecase
set smartcase

" Set line numbers
set number relativenumber

" Always show status bar 
set laststatus=2

set tabstop=4 shiftwidth=4
set expandtab

set colorcolumn=80

set noerrorbells visualbell t_vb=

set nocompatible
filetype off

" Searching
set incsearch                   " Incremental search
set hlsearch                    " Highlight search

" Terminal
set termwinsize=12x0            " Standard size of terminal (12 rows)
set splitbelow                  " Terminal will always be positioned below
set mouse=a                     " Enable mouse drag on window splits


""" Vundle Plugin Manager
" Set the runtime to include and initialize Vundle
set rtp+=~/.vim/bundle/Vundle.vim

" Download plugins to the ~/.vim/plugged directory
call vundle#begin('~/.vim/plugged')

Plugin 'VundleVim/Vundle.vim'   " Let vundle manage itself

call vundle#end()
filetype plugin indent on

""" Plugins
" Note: run 'vim +PluginInstall +qall' on a fresh install to collect the
" plugins
Plugin 'jiangmiao/auto-pairs'   " Pair completion
Plugin 'preservim/nerdtree'     " File tree
Plugin 'mhinz/vim-startify'     " Fancy start page when calling vim w/o file

""" Pair Completion settings
let g:AutoPairsShortcutToggle='<C-P>'


""" Nerdtree Filetree settings
let NERDTreeShowBookmarks=1     " Show bookmarks table
let NERDTreeShowHidden=1        " Show hidden files
let NERDTreeShowLineNumbers=0   " Hide line numbers
let NERDTreeMinimalMenu=1       " Use minimal menu (m)
let NERDTreeWinPos='left'       " Force window to left
let NERDTreeWinSize=32          " Set width to 32 chars
nmap <F2> :NERDTreeToggle<CR>   " Toggle the filetree with F2


""" Startify Settings
source ~/.vimrc-start
