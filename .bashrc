# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set prompt
PS1="\[$(tput setaf 4)\]\u@\h \[$(tput setaf 5)$(tput smso)\]\D{%H:%M:%S}\[$(tput rmso)$(tput setaf 4)\] \w\[$(tput sgr0)\]\n\$ "

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
