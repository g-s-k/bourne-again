#emacs
emc() { (emacsclient --alternate-editor="emacs" "$@" > /dev/null 2>&1 &) }

# ls aliases
if [[ "$(uname)" = "Darwin" ]]; then
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi
alias la='ls -A'
alias ll='la -l'

# open files (inspired by PowerShell's Invoke-Item)
ii() { (xdg-open "$@" 2>/dev/null &) }

# screen lock
alias i3l='i3lock -c $(openssl rand -hex 3)'

# docker-stats
alias dost='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}"'

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
