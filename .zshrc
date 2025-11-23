export PROMPT='%F{green}%n@%m%f %1~ %# '

setopt autocd
setopt correct
setopt hist_ignore_dups
setopt share_history

autoload -Uz compinit
compinit

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ll='ls -la'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

eval "$(zoxide init --cmd cd zsh)"
