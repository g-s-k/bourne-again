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

# add git completions on linux
GIT_COMPLETION_FILE=/usr/share/bash-completion/completions/git
[ -f $GIT_COMPLETION_FILE ] && source $GIT_COMPLETION_FILE

# set prompt
RESET="\[$(tput sgr0)\]"
BOLD="\[$(tput bold)\]"
CONJ="\[$(tput setaf 4)\]"

WHO="$BOLD\[$(tput setaf 2)\]\u$RESET $CONJ"
WHAT="$BOLD\[$(tput setaf 5)\]\h$RESET $CONJ"
WHEN="$BOLD\[$(tput setaf 1)\]\t$RESET $CONJ"
WHERE="\[$(tput setaf 7)\]\w$RESET"

PS1="${WHO}using ${WHAT}at ${WHEN}in $WHERE"

for f in /usr/lib/git-core/git-sh-prompt /usr/share/git/completion/git-prompt.sh /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh; do
  if [ -e "$f" ]; then
    source "$f"
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="verbose name"
    GIT_PS1_DESCRIBE_STYLE="branch"
    GIT_PS1_HIDE_IF_PWD_IGNORED=1
    GITS='$(__git_ps1 "\n  on \[$(tput bold)$(tput setaf 6)\][%s]\[$(tput sgr0)\]")'
    PS1="$PS1${GITS:+$CONJ$GITS$RESET}"
  fi
done

PS1="$PS1\n\$ "

unset RESET BOLD CONJ WHEN WHO WHAT WHERE

# Alias definitions
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# extra env vars
[ -f "$HOME/.bash_vars" ] && source "$HOME/.bash_vars"
