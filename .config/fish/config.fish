# shared
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config

# package manager
if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# bindings
fish_vi_key_bindings
bind -M insert \cp accept-autosuggestion

# vim
set -x VIMINIT "let \$MYVIMRC=\"$XDG_CONFIG_HOME/vim/vimrc\" | source \$MYVIMRC"

# aliases
alias cfg 'git --git-dir="$HOME/.cfg/" --work-tree="$HOME"'

if type -q wmctrl
  alias fullscreen 'wmctrl -r :ACTIVE: -b toggle,fullscreen'
end

if test (uname) = "Darwin"
  alias xc pbcopy
else
  alias xc 'xclip -selection clipboard'
end

alias dost 'docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}"'
alias kc kubectl

alias bla 'beet ls -a'

# hacky fix for tmux in gnome-terminal
if ps -p (ps -p $fish_pid -o ppid | grep -vF PPID | string trim) -o args | grep -q gnome-terminal
  printf '\e[?1007l'
end

# nvm
if test -s "$HOME/.nvm/nvm.sh"
  bass source "$HOME/.nvm/nvm.sh"
end
