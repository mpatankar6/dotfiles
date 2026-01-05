setopt autocd
setopt correct
setopt hist_ignore_dups
setopt share_history

autoload -Uz compinit
compinit

fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias ff='cd ~ && clear && fastfetch'
alias ll='ls -lAh'
alias path='echo $PATH | tr ":" "\n"'
alias github='url=$(git remote get-url origin) && open "$url"'

eval "$(zoxide init --cmd cd zsh)"

bindkey "^G" autosuggest-toggle

[[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]] && export PATH="$HOME/.cargo/bin:$PATH"
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow,hidden'
