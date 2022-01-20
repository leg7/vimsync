" This vimrc is version is for school comupters
" so it's missing XDG stuff and installs everything
" to ~/.vim
""""""""""""""""""""""""
""" Install vim-plug """
""""""""""""""""""""""""

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""""""""""""""""""""""""""""
""" Plugins with vim-plug """
"""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'

Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'

Plug 'junegunn/goyo.vim'

call plug#end()

"""""""""""""""""""
""" Preferences """
"""""""""""""""""""

set nocompatible
filetype plugin on

runtime! macros/matchit.vim

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
set incsearch

set encoding=utf-8

set t_Co=256
colorscheme nord

""""""""""""""""
""" Global Bindings """
""""""""""""""""

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
