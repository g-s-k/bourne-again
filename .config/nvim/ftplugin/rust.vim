source ~/.config/vim/ftplugin/rust.vim

if executable('cargo-clippy')
  let b:ale_linters = ['cargo']
  let g:ale_rust_cargo_use_clippy = 1
else
  let b:ale_linters = []
endif
