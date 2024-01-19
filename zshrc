# Larger history
#
HISTFILE=~/.zsh_history
HISTSIZE=10000000

# Switch vi-mode on
bindkey -v
bindkey "jj" vi-cmd-mode

# Search forward and backward through history with Up and Down arrow
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Search incrementally with Ctrl-r
bindkey '^r' history-incremental-search-backward

# Expose emacs binary for Doom, since MacPorts does not do so by default.
export PATH="/Applications/MacPorts/EmacsMac.App/Contents/MacOS:$HOME/.emacs.d/bin:$HOME/bin:$PATH"

# Aliases for folder
alias g="cd $HOME/personal/grand-schemer"
alias d="cd $HOME/personal/dotfiles"
alias tt="timetracker "
alias t="cd $HOME/teaching"

# Source nvm
source /opt/local/share/nvm/init-nvm.sh
