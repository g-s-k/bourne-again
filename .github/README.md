# assorted dotfiles

originally this repo was just for my `bash` configuration, but it has up-scoped
to include other bits of my environment.

for more instructions and discussion on how it works, see [this
article](https://www.atlassian.com/git/tutorials/dotfiles)

## usage

```shell
# clone this repo
git clone --bare <url> $HOME/.cfg
# make an alias
alias cfg='git --git-dir=$HOME/.cfg --work-tree=$HOME'
# populate the actual files
cfg checkout
```

note that the alias defined in the second step is identical to the ones in both
`.bashrc` and `config.fish`, so you can use it in later sessions without a
problem.

### site-specific configuration

#### for fish

use universal variables (`set -U ...`) to customize the shell environment. one
very helpful one is
[`fish_user_paths`](https://fishshell.com/docs/current/index.html?highlight=fish_user_paths#special-variables)
for executables. at a minimum, add `$HOME/.local/bin` to use the scripts
included here. if you have additional functions or aliases, place them in the
conventional spot (`$HOME/.config/fish/functions/`)

#### for bash

`.profile`, `.bash_profile` and, `.bash_site` are deliberately omitted.

##### on Linux

- use `.profile` (sourced at login by your graphical shell) for environment
  vars, including `PATH`
- use `.bash_site` (sourced at the end of the included `.bashrc`) to source
  additional site-specific scripts and assign private aliases

##### on macOS

- use `.bash_profile` (sourced when Terminal.app is opened) for all
  site-specific configuration

## Vim

Vim config is in [`.config/vim`](../.config/vim). more information on setup is
in a readme there.
