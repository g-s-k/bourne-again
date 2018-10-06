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
RESET="\[$(tput sgr0)\]"
BOLD="\[$(tput bold)\]"
CONJ="\[$(tput setaf 4)\]"

WHO="$BOLD\[$(tput setaf 2)\]\u$RESET $CONJ"
WHAT="$BOLD\[$(tput setaf 5)\]\h$RESET $CONJ"
WHEN="$BOLD\[$(tput setaf 1)\]\t$RESET $CONJ"
WHERE="\[$(tput setaf 7)\]\w$RESET"

PS1="${WHO}using ${WHAT}at ${WHEN}in $WHERE"

gitps1() {
  if [ -e "$1" ]; then
    source "$1"
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="verbose name"
    GIT_PS1_DESCRIBE_STYLE="branch"
    GIT_PS1_HIDE_IF_PWD_IGNORED=1

    __git_ps1 "\n  on \[$(tput bold)$(tput setaf 6)\][%s]\[$(tput sgr0)\]"
    return 0
  fi
  return 1
}

GITS=$(gitps1 /usr/lib/git-core/git-sh-prompt || gitps1 /usr/share/git/completion/git-prompt.sh || echo "")
PS1="$PS1${GITS:+$CONJ$GITS$RESET}\n\$ "

unset RESET BOLD CONJ WHEN WHO WHAT WHERE

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
