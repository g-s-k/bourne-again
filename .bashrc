# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# xdg
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export RANDFILE="$XDG_CACHE_HOME/openssl/rnd"

# don't put lines starting with space in the history
# also erase word-for-word duplicates
HISTCONTROL=ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=
export HISTFILESIZE=
export HISTFILE="$XDG_DATA_HOME/bash/history"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# editor configuration
export EDITOR=nvim

# Alias definitions
if [[ "$(uname)" = "Darwin" ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias la='ls -A'
alias ll='la -l'

alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

if [ -r "$HOME/.bash_site" ]; then . "$HOME/.bash_site"; fi
