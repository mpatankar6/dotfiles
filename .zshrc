# ═══════════════════════════════════════════════════════════════════
# 🎨 AMAZING ZSH CONFIGURATION
# ═══════════════════════════════════════════════════════════════════

# ───────────────────────────────────────────────────────────────────
# Prompt Configuration
# ───────────────────────────────────────────────────────────────────
export PROMPT='%F{green}%n@%m%f %F{cyan}%1~%f %# '

# ───────────────────────────────────────────────────────────────────
# Shell Options
# ───────────────────────────────────────────────────────────────────
setopt autocd              # Change directory without 'cd'
setopt correct             # Auto-correct commands
setopt hist_ignore_dups    # Ignore duplicate commands in history
setopt share_history       # Share history across terminals
setopt hist_reduce_blanks  # Remove superfluous blanks from history
setopt inc_append_history  # Add commands to history immediately
setopt extended_history    # Save timestamp and duration
setopt hist_ignore_space   # Ignore commands starting with space

# History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ───────────────────────────────────────────────────────────────────
# Completion System
# ───────────────────────────────────────────────────────────────────
autoload -Uz compinit
compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Colored completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ───────────────────────────────────────────────────────────────────
# Plugin Loading
# ───────────────────────────────────────────────────────────────────
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ───────────────────────────────────────────────────────────────────
# Essential Aliases
# ───────────────────────────────────────────────────────────────────
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --all --decorate'
alias gd='git diff'
alias gco='git checkout'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Utility aliases
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias path='echo $PATH | tr ":" "\n"'
alias reload='source ~/.zshrc'

# ───────────────────────────────────────────────────────────────────
# Useful Functions
# ───────────────────────────────────────────────────────────────────

# Make and change directory
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find file by name
ff() {
    find . -type f -iname "*$1*"
}

# Find directory by name
fd() {
    find . -type d -iname "*$1*"
}

# ───────────────────────────────────────────────────────────────────
# Environment Setup
# ───────────────────────────────────────────────────────────────────

# Zoxide (smart cd)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# ───────────────────────────────────────────────────────────────────
# Welcome Message
# ───────────────────────────────────────────────────────────────────
echo "🎨 Amazing dotfiles loaded! Type 'reload' to refresh config."
