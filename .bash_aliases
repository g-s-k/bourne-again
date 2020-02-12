#emacs
emc() { (emacsclient --alternate-editor="emacs" "$@" &> /dev/null &) }

# ls aliases
if which lsd &> /dev/null; then 
  alias ls='lsd'
  alias la='ls -a'
else
  if [[ "$(uname)" = "Darwin" ]]; then
    alias ls='ls -G'
  else
    alias ls='ls --color=auto'
  fi

  alias la='ls -A'
fi

alias ll='la -l'

# open files (inspired by PowerShell's Invoke-Item)
ii() { 
  if [[ "$(uname)" = "Darwin" ]]; then
    (open "$@" &> /dev/null &)
  else
    (xdg-open "$@" &> /dev/null &)
  fi
}

# screen lock
alias i3l='i3lock -c $(openssl rand -hex 3)'

# docker-stats
alias dost='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}"'

# kubectl
alias kc=kubectl

# git
merge-fast() { 
  SRC_BRANCH=${1:-$(git branch -q | grep '\*' | cut -d' ' -f2)}
  DEST_BRANCH=${2:-master}
  git checkout "$DEST_BRANCH" &&\
    git pull &&\
    git checkout "$SRC_BRANCH" &&\
    git rebase "$DEST_BRANCH" &&\
    git checkout "$DEST_BRANCH" &&\
    git push &&\
    git branch -d "$SRC_BRANCH"
}

_git_kill() { _git_checkout; }
_git_pick_this() { _git_checkout; }