# assorted dotfiles

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

note that the alias defined in the second step is identical to the one in
`config.fish`, so you can use it in later sessions without a problem.

### install useful tools

On macOS, install [nix-darwin](https://github.com/LnL7/nix-darwin) and then run
`darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix`.

On a Linux system, install a minimum of `fish`, `neovim`, `ripgrep`, and `tmux`
with the system package manager. 

### site-specific configuration

If `$SHELL=bash`, ensure that `~/.bashrc` sources user configuration files in
`~/.bashrc.d/`. If `$SHELL=zsh`, ensure that `.zshprofile` ends with `exec
fish`.

use universal variables (`set -U ...`) to customize the shell environment. one
very helpful one is
[`fish_user_paths`](https://fishshell.com/docs/current/index.html?highlight=fish_user_paths#special-variables)
for executables. note that this does not include `$HOME/.local/bin` by default
in fish. if you have additional functions or aliases, place them in the
conventional spot (`$HOME/.config/fish/functions/`)
