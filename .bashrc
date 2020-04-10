# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put lines starting with space in the history
# also erase word-for-word duplicates
HISTCONTROL=ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=
export HISTFILESIZE=
export HISTFILE="${XDG_DATA_HOME:-"$HOME/.local/share"}/bash/history"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# editor configuration
export EDITOR=vim

# add git completions on linux
GIT_COMPLETION_FILE=/usr/share/bash-completion/completions/git
[ -f $GIT_COMPLETION_FILE ] && source $GIT_COMPLETION_FILE
_git_kill() { _git_checkout; }
_git_pick_this() { _git_checkout; }

# set prompt
__git_prompt_configured=""
for f in /usr/lib/git-core/git-sh-prompt /usr/share/git/completion/git-prompt.sh /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh; do
  if [ -e "$f" ]; then
    source "$f"
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="name"
    GIT_PS1_DESCRIBE_STYLE="branch"
    GIT_PS1_HIDE_IF_PWD_IGNORED=1
    __git_prompt_configured="yes"
  fi
done

PROMPT_COMMAND=__make_prompt

__make_prompt() {
    local EXIT="$?"
    history -a

    PS1=""

    local RESET="\[$(tput sgr0)\]"
    local BOLD="\[$(tput bold)\]"

    local RED="\[$(tput setaf 1)\]"
    local GREEN="\[$(tput setaf 2)\]"
    local BLUE="\[$(tput setaf 4)\]"
    local PURPLE="\[$(tput setaf 5)\]"
    local TEAL="\[$(tput setaf 6)\]"
    local GRAY="\[$(tput setaf 7)\]"

    if [ $EXIT = 0 ]; then
        PS1+="${BOLD}${GREEN}\u${RESET} "
    else
        PS1="${BOLD}${RED}\u${RESET} "
    fi

    PS1+="${BLUE}using${RESET} ${BOLD}${PURPLE}\h${RESET} "

    if [ -n "$__git_prompt_configured" ]; then
        PS1+="$(__git_ps1 "${BLUE}on${RESET} ${BOLD}${TEAL}[%s]${RESET} ")"
    fi

    PS1+="${BLUE}in${RESET} ${GRAY}\w${RESET}"

    PS1+="\n"
    if [ $EXIT != 0 ]; then PS1+="${RED}($EXIT)${RESET} "; fi
    PS1+="\$ "
}

# Alias definitions
alias fullscreen='wmctrl -r :ACTIVE: -b toggle,fullscreen'

if [[ "$(uname)" = "Darwin" ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias la='ls -A'
alias ll='la -l'

alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# hacky fix to disable scroll wheel in alternate screen
ps -p $(ps -p $$ -o ppid | grep -vF PPID) -o args | grep -q gnome-terminal
if [[ $? = 0 ]]; then
  printf '\e[?1007l'
fi

if [ -r "$HOME/.bash_site" ]; then . "$HOME/.bash_site"; fi
