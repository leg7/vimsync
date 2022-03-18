"==================
"== XDG SUPPORT ===
"==================
if empty($MYVIMRC) | let $MYVIMRC = expand('<sfile>:p') | endif

set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath+=$XDG_DATA_HOME/vim
set runtimepath+=$XDG_CONFIG_HOME/vim/after

set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

let g:netrw_home = $XDG_DATA_HOME."/vim"
call mkdir($XDG_DATA_HOME."/vim/spell", 'p', 0700)
set viewdir=$XDG_DATA_HOME/vim/view | call mkdir(&viewdir, 'p', 0700)

set backupdir=$XDG_CACHE_HOME/vim/backup | call mkdir(&backupdir, 'p', 0700)
set directory=$XDG_CACHE_HOME/vim/swap   | call mkdir(&directory, 'p', 0700)
set undodir=$XDG_CACHE_HOME/vim/undo     | call mkdir(&undodir,   'p', 0700)

if !has('nvim') | set viminfofile=$XDG_CACHE_HOME/vim/viminfo | endif

"=======================
"====== vim-plug =======
"=======================

" Automatically install vimplug if not installed
let data_dir = '$XDG_CONFIG_HOME/vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install my plugins
call plug#begin('$XDG_DATA_HOME/vim/plugged')

" Aesthetics
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'

" Utility
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'lifepillar/vim-mucomplete'

" Syntax
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'
Plug 'vim-scripts/dbext.vim'

call plug#end()

"==================
"=== Settings =====
"==================

set nocompatible 		        " Disable vi compatiblity
set encoding=utf-8

" Behaviour
filetype plugin indent on       " Autorecognize filetype
set confirm			            " Confirm save on close
set shortmess=a                 " Reduce console output to avoid hitting enter
set scrolloff=5                 " Always keep 5 lines of padding when scrolling vertically
set sidescrolloff=5             " Same
" Indent
set autoindent  		        " Autoindents code
set expandtab			        " Convert tab to spaces
set tabstop=4			        " Decrase default tab width so that code fits better on screen
set shiftwidth=4		        " Size of tab when using >> and <<
" Information
syntax on				        " Turn on syntax highlighting
set title				        " Sets window name to file title
set relativenumber 		        " Relative number lines on the left hand side
set number                      " Prints line number on the left hand side
set ruler				        " Gives you line number bottom right
set showcmd                     " Show keys pressed
" Search
set ignorecase  		        " Required for smartcase
set smartcase   		        " Matches uppercase letters only if typed (just look it up)
set hlsearch			        " hightlight search, use :noh to disable
set incsearch			        " Start searching as you type
" Features
set hidden                      " Allow to leave buffer without saving
set splitbelow                  " New splits go below
set splitright

set nospell			            " Disable spellcheck by default
runtime! macros/matchit.vim	    " Improve % matching
set clipboard=unnamedplus 	    " Use system clipboard instead of registries

set wildmenu                    " Better command autocompletion menu
set wildmode=longest:list,full 	" First tab completes to longest string and shows matches, second tab starts cycling through full matches
set wildignorecase

set foldmethod=indent 		    " folds functions, unfold them with za
set foldnestmax=1               " Fold at most the top function, don't fold everything inside of it
set foldlevelstart=20           " Set a very high start fold level so that all the folds are open when you first open the file

set path +=**			        " very cool stuff, you don't need a fuzzy finder plugin it's already built in !!!!
                                " Scans your subdirectories and allows you to jump to files with the find command
                                " and go back with b <buffer name> (# for previous)

let g:mucomplete#enable_auto_at_startup = 1 " Autocompletion with mucomplete
" let g:mucomplete#completion_delay = 1
set completeopt+=menuone,noinsert,preview

""" Visuals """
set termguicolors
" set Vim-specific sequences for RGB colors and enable truecolor support
" if term = st do
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"else
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_cursor_line_number_background = 1
colorscheme nord

" Changes cursor shape in insert and replace mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
set cursorline " Highlights the line where your cursor is at

" Lightline plugin get cool triangular font instead of square
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'nord',
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' }
      \ }

"======================
"== Global Bindings ===
"======================

let mapleader=" "

" Toggle spellcheck in french
map <leader>s :setlocal spell! spelllang=fr<CR>

" Toggle autoindent
map <leader>i :setlocal autoindent<CR>
map <leader>I :setlocal noautoindent<CR>

" Disable highlight search
map <silent> <leader><leader> :noh<CR>

" Toggle goyo (centered text)
map <leader>g :Goyo<CR>

" Bindings for navigating splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <leader>w :w<CR>
map <leader>f :filetype detect<CR>

map <leader>c :!g++ -Wpedantic % -o %.out; ./%.out<CR>

"===================================================
"== Some autoexec commands and filetype bindings ===
"===================================================

command Cwd :execute 'cd %p:h'

"=== HTML BINDINGS
autocmd FileType html map <leader>p i<p></p><Esc>2ba

autocmd FileType tex,latex,markdown setlocal spelllang=fr " Sets spellchecker to french for latex and markdown files

autocmd BufWritePre * %s/\s\+$//e " Remove trailing spaces
