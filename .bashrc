# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -lA'

# set prompt
PS1="\[$(tput setaf 4)\]\u@\h \[$(tput setaf 5)$(tput smso)\]\D{%H:%M:%S}\[$(tput rmso)$(tput setaf 4)\] \w\[$(tput sgr0)\]\n\$ "
