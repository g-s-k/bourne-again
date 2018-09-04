# emacs
emc() { (emacsclient --alternate-editor="emacs" $* &) }

# ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -lA'
alias l='ls -CF'

# open files (inspired by PowerShell's Invoke-Item)
ii() { (xdg-open $* 2>/dev/null &) }
