"""""""""""""""""""
""" XDG SUPPORT """
"""""""""""""""""""
" if empty($MYVIMRC) | let $MYVIMRC = expand('<sfile>:p') | endif

" set runtimepath^=$XDG_CONFIG_HOME/vim
" set runtimepath+=$XDG_DATA_HOME/vim
" set runtimepath+=$XDG_CONFIG_HOME/vim/after

" set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
" set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

" let g:netrw_home = $XDG_DATA_HOME."/vim"
" call mkdir($XDG_DATA_HOME."/vim/spell", 'p', 0700)
" set viewdir=$XDG_DATA_HOME/vim/view | call mkdir(&viewdir, 'p', 0700)

" set backupdir=$XDG_CACHE_HOME/vim/backup | call mkdir(&backupdir, 'p', 0700)
" set directory=$XDG_CACHE_HOME/vim/swap   | call mkdir(&directory, 'p', 0700)
" set undodir=$XDG_CACHE_HOME/vim/undo     | call mkdir(&undodir,   'p', 0700)

" if !has('nvim') | set viminfofile=$XDG_CACHE_HOME/vim/viminfo | endif

""""""""""""""""""""""""
""""""" vim-plug """""""
""""""""""""""""""""""""

" Automatically install vimplug if not installed
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Instal my plugins
call plug#begin('~/.vim/plugged')

" Aesthetics
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'

" Utility
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'

" Syntax
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'

call plug#end()

"""""""""""""""""""
""" Preferences """
"""""""""""""""""""

set nocompatible
filetype plugin on
set encoding=utf-8

set t_Co=256
colorscheme nord

runtime! macros/matchit.vim

set path +=**   " Scans your subdirectories and allows you to jump to files with the find command and go back with b
		" very cool stuff, you don't need a fuzzy finder plugin it's already built in !!!!

set title	" Sets window name to file title
set nospell	" Disable spellcheck by default
set autoindent
set confirm	" Confirm save on close
set clipboard=unnamedplus " Use system clipboard instead of registries
set wildmode=longest,list,full " better autocompletion

set cursorline " Highlights the line where your cursor is at

syntax on
set relativenumber " Relative number lines on the left hand side
set ruler	" Gives you line number bottom right
set ignorecase  " Required for smartcase
set smartcase   " Matches uppercase letters only if typed (just look it up)
set hlsearch	" hightlight search, use :noh to disable
set incsearch	" Start searching as you type

" Lightline plugin
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'nord',
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' }
      \ }

"""""""""""""""""""""""
""" Global Bindings """
"""""""""""""""""""""""

let mapleader=" "

" Toggle spellcheck in french
map <leader>s :setlocal spell! spelllang=fr<CR>

" Toggle autoindent
map <leader>i :setlocal autoindent<CR>
map <leader>I :setlocal noautoindent<CR>

" Toggle goyo (centered text)
map <leader>g :Goyo<CR>

" Bindings for navigating splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Some autoexec commands and filetype bindings """
""""""""""""""""""""""""""""""""""""""""""""""""""""

"""" HTML BINDINGS
autocmd FileType html map <leader>p i<p></p><Esc>2ba

autocmd FileType tex,latex,markdown setlocal spelllang=fr " Sets spellchecker to french for latex and markdown files

autocmd BufWritePre * %s/\s\+$//e " Remove trailing spaces
