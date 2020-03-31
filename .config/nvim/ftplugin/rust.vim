source ~/.vim/ftplugin/rust.vim

let b:ale_linters = ['cargo']
call BindNvimLspCommands()
