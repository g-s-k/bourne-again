" builtin plugins
runtime! ftplugin/man.vim

" appearance
color delek
set number
set ttyfast

" behavior
set autochdir
set clipboard^=unnamed,unnamedplus
set hidden
set scrolloff=10

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

" operational files
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" vcs gutter indicators
set signcolumn=yes
set updatetime=100

" linting
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1
set completeopt+=noinsert
let g:ale_fix_on_save = 1

let g:ale_linters = {
\ 'go': ['gopls', 'golint'],
\ 'less': ['prettier'],
\ 'rust': ['cargo', 'rls']
\}
let g:ale_fixers = {
\ 'go': ['gofmt'],
\ 'javascript': ['prettier-eslint', 'eslint'],
\ 'javascript.jsx': ['prettier-eslint', 'eslint'],
\ 'less': ['prettier'],
\ 'rust': ['rustfmt']
\}

let g:ale_rust_rls_executable = 'ra_lsp_server'

nnoremap <C-M> :ALEFindReferences<CR>
nnoremap <C-N> :ALEGoToDefinition<CR>
