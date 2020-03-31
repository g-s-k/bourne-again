# shared
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config

# package manager
if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# vim
set -x VIMINIT "let \$MYVIMRC=\"$XDG_CONFIG_HOME/vim/vimrc\" | source \$MYVIMRC"

# aliases
function fullscreen
  wmctrl -r :ACTIVE: -b toggle,fullscreen
end

function xc
  if test (uname) = "Darwin"
    pbcopy $argv
  else
    xclip --selection clipboard $argv
  end
end

function dost
  docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}" $argv
end

function kc
  kubectl $argv
end

function bla
  beet ls -a $argv
end

function cfg
  git --git-dir="$HOME/.cfg/" --work-tree="$HOME" $argv
end

# hacky fix for tmux in gnome-terminal
if ps -p (ps -p $fish_pid -o ppid | grep -vF PPID | string trim) -o args | grep -q gnome-terminal
  printf '\e[?1007l'
end

# nvm
if test -s "$HOME/.nvm/nvm.sh"
  bass source "$HOME/.nvm/nvm.sh"
end
