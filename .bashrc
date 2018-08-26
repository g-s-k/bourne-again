# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -lA'

# set prompt
RESET="\[$(tput sgr0)\]"
BLUE="\[$(tput setaf 4)\]"
PURPLE="\[$(tput setaf 5)\]"

PS1="${BLUE}\u@\h ${PURPLE}\[$(tput smso)\]\D{%H:%M:%S}\[$(tput rmso)\] ${BLUE}\w${RESET}\n\$ "
