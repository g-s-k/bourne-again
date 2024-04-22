# shared
set -q XDG_CACHE_HOME; or set -x XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_DATA_HOME; or set -x XDG_DATA_HOME "$HOME/.local/share"

set -x INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -x NODE_REPL_HISTORY "$XDG_DATA_HOME/node/repl_history"
set -x DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -x RANDFILE "$XDG_CACHE_HOME/openssl/rnd"
set -x GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -x TODOTXT_CFG_FILE "$XDG_CONFIG_HOME/todo/todo.cfg"
set -x FZF_TMUX_OPTS -p

# package manager
if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# bindings
fish_vi_key_bindings
bind -M insert \cp accept-autosuggestion

# aliases
alias cfg 'git --git-dir="$HOME/.cfg/" --work-tree="$HOME"'

alias tmux "tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# fzf
command -q fzf && fzf --fish | source

# fw
command -q fw && fw print-fish-setup -f | source
