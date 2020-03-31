# assorted dotfiles

originally this repo was just for my `bash` configuration, but it has up-scoped
to include other bits of my environment.

for more instructions and discussion on how it works, see [this
article](https://www.atlassian.com/git/tutorials/dotfiles)

## usage

1. clone this repo like so: `git clone --bare <url> $HOME/.cfg`
2. make this alias for convenience (note that this alias is also defined in
   `.bashrc`): `alias cfg='git --git-dir=$HOME/.cfg --work-tree=$HOME'`
3. run this command to populate the files: `cfg checkout && cfg submodule update --init`
4. run this command to improve your life greatly: `cfg config --local
   status.showUntrackedFiles no`

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

- Vim config is in [`.config/vim`](../.config/vim). more information on setup is
  in a readme there.
- Git config is located at [`.config/git/config`](../.config/git/config)
- Tmux config is in [`.tmux.conf`](../.tmux.conf)
- URXvt config is in [`.Xresources`](../.Xresources)
- scripts i use often are in [`.local/bin`](../.local/bin). make sure you add it
  to `$PATH` in order to use them.
