" builtin plugins
runtime! ftplugin/man.vim

" appearance
color slate
au VimEnter * highlight Pmenu ctermbg=141
set number
set showcmd
set ttyfast

set cursorline
set cursorlineopt=number

let g:airline_theme = 'minimalist'

" behavior
set clipboard^=unnamed,unnamedplus
set hidden
set scrolloff=10
let mapleader = " "
set shortmess+=c
set completeopt-=preview

" splits
set splitright
autocmd VimResized * :wincmd =

" search
set ignorecase
set smartcase
set nohlsearch

" tabs
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround

" netrw file explorer
let g:netrw_fastbrowse = 0
let g:netrw_banner=0
let g:netrw_liststyle=3

" operational files
if !has('nvim')
  source $HOME/.config/vim/xdg.vim
endif

" external plugins
if has('nvim')
  let plug_file = $XDG_DATA_HOME . '/nvim/site/autoload/plug.vim'
else
  let plug_file = $XDG_CONFIG_HOME . '/vim/autoload/plug.vim'
end

if empty(glob(plug_file))
  silent execute '!curl -fLo ' . plug_file . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($XDG_DATA_HOME . '/plugged')

Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'Valloric/ListToggle'
Plug 'alvan/vim-closetag'
Plug 'cespare/vim-toml'
Plug 'elixir-editors/vim-elixir'
Plug 'georgewitteman/vim-fish'
Plug 'jakwings/vim-pony'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'leafgarland/typescript-vim'
Plug 'mhinz/vim-signify'
Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'

if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp_extensions.nvim'
end

call plug#end()

" vcs gutter indicators
set signcolumn=yes
au VimEnter * highlight clear SignColumn
set updatetime=100

" html tag autoclose
let g:closetag_filetypes =
\ 'html,xhtml,phtml,javascript,javascriptreact,javascript.jsx,typescript,typescriptreact,typescript.tsx'
let g:closetag_xhtml_filetypes =
\ 'html,xhtml,phtml,javascript,javascriptreact,javascript.jsx,typescript,typescriptreact,typescript.tsx'
let g:closetag_regions = {
\ 'typescript': 'jsxRegion,tsxRegion',
\ 'typescript.tsx': 'jsxRegion,tsxRegion',
\ 'typescriptreact': 'jsxRegion,tsxRegion',
\ 'javascript': 'jsxRegion',
\ 'javascript.jsx': 'jsxRegion',
\ 'javascriptreact': 'jsxRegion',
\}
let g:closetag_emptyTags_caseSensitive = 1

" set ripgrep as grepprg
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" https://learnvimscriptthehardway.stevelosh.com/chapters/32.html
noremap <Leader>g :silent execute "grep! " . shellescape(expand("<cword>"))<CR>:copen<CR>
noremap <Leader>G :silent execute "grep! " . shellescape(expand("<cWORD>"))<CR>:copen<CR>

" fzf
if isdirectory($HOME . '/.local/share/fzf')
  set rtp+=$HOME/.local/share/fzf
endif
