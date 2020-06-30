" builtin plugins
runtime! ftplugin/man.vim

" appearance
color peachpuff
set number
set showcmd
set ttyfast

set cursorline
au VimEnter * highlight clear CursorLine
au VimEnter * highlight CursorLineNr cterm=standout

let g:airline_theme = 'minimalist'

" behavior
set clipboard^=unnamed,unnamedplus
set hidden
set scrolloff=10
let mapleader = " "

" splits
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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

" vcs gutter indicators
set signcolumn=yes
au VimEnter * highlight clear SignColumn
set updatetime=100

" masochism
noremap <Up> :echom "use K"<CR>
noremap <Down> :echom "use J"<CR>
noremap <Left> :echom "use H"<CR>
noremap <Right> :echom "use L"<CR>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

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

" linting
let g:airline#extensions#ale#enabled = 1
let g:ale_fix_on_save = 1
set omnifunc=ale#completion#OmniFunc

nnoremap <Leader>r :ALERename<CR>
nnoremap <Leader>f :ALEFindReferences<CR>
nnoremap <Leader>d :ALEGoToDefinition<CR>
nnoremap <Leader>h :ALEHover<CR>
nnoremap [r :ALEPreviousWrap<CR>
nnoremap ]r :ALENextWrap<CR>

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
