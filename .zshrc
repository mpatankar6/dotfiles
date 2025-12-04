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
source <(fzf --zsh)

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias ff='cd ~ && clear && fastfetch'
alias ll='ls -lAh'
alias path='echo $PATH | tr ":" "\n"'

eval "$(zoxide init --cmd cd zsh)"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow,hidden'
