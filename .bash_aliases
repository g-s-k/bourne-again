#emacs
emc() { (emacsclient --alternate-editor="emacs" "$@" &> /dev/null &) }

# fullscreen
alias fullscreen='wmctrl -r :ACTIVE: -b toggle,fullscreen'

# ls aliases
if [[ "$(uname)" = "Darwin" ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

alias la='ls -A'
alias ll='la -l'

# docker-stats
alias dost='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}"'

# kubectl
alias kc=kubectl

# beets
alias bla='beet ls -a'
