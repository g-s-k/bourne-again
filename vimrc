" builtin plugins
runtime! macros/matchit.vim
runtime! ftplugin/man.vim

" appearance
filetype plugin indent on
syntax on
color murphy
set colorcolumn=81
set cursorline
set number
set ruler
set ttyfast

" behavior
set autoindent
set backspace=indent,eol,start
set clipboard^=unnamed,unnamedplus
set hidden
set scrolloff=999
set wildmenu
set wildmode=longest:full,full

" search
set incsearch
set ignorecase
set smartcase

" tabs
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
set shiftround

" netrw file explorer
let g:netrw_fastbrowse = 0
let g:netrw_banner=0
let g:netrw_liststyle=3
