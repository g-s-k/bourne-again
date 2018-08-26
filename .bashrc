# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -lA'

# set prompt
RESET="$(tput sgr0)"
PURPLE="$(tput setaf 5)"

PS1='${PURPLE}\u@\h \w\n${RESET}\$ '
