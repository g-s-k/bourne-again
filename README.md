# assorted dotfiles

originally this repo was just for my `bash` configuration, but it has up-scoped
to include other bits of my environment.

## usage

1. install GNU Stow
2. make a directory in your home directory (e.g. `~/dotfiles`) and enter it
3. clone this repository
4. run `stow bourne-again`

### other files

`.profile`, `.bash_profile` and, `.bash_site` are deliberately omitted. 

#### on Linux

- use `.profile` (sourced at login by your graphical shell) for environment
  vars, including `PATH`
- use `.bash_site` (sourced at the end of the included `.bashrc`) to source
  additional site-specific scripts and assign private aliases

#### on macOS

- use `.bash_profile` (sourced when Terminal.app is opened) for all
  site-specific configuration

## items of note

- Git config is located at [`.config/git/config`](.config/git/config)
- Tmux config is in [`.tmux.conf`](.tmux.conf)
- URXvt config is in [`.Xresources`](.Xresources)
- scripts i use often are in [`bin`](bin)

## see also

- my [vim config](https://github.com/g-s-k/vim-again)
