" builtin plugins
runtime! ftplugin/man.vim

" appearance
color torte
set colorcolumn=81
set cursorline
set number
set ruler
set ttyfast

" behavior
set clipboard^=unnamed,unnamedplus
set hidden
set scrolloff=999
set wildmode=longest:full,full

" search
set ignorecase
set smartcase

" tabs
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround

" netrw file explorer
let g:netrw_fastbrowse = 0
let g:netrw_banner=0
let g:netrw_liststyle=3

" linting
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1

let g:ale_linters = {
\ 'rust': ['rls']
\}
let g:ale_fixers = {
\ 'rust': ['rustfmt']
\}

nnoremap <C-M> :ALEFindReferences<CR>
nnoremap <C-N> :ALEGoToDefinition<CR>
