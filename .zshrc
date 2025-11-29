setopt autocd
setopt correct
setopt hist_ignore_dups
setopt share_history

autoload -Uz compinit
compinit

autoload -U promptinit; promptinit
prompt pure

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ll='ls -lAh'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias path='echo $PATH | tr ":" "\n"'

eval "$(zoxide init --cmd cd zsh)"

export PATH="$(brew --prefix)/opt/python@3.x/libexec/bin:$PATH"
echo
fastfetch
