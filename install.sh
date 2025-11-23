#!/bin/bash

# ═══════════════════════════════════════════════════════════════════
# 🎨 Amazing Dotfiles Installation Script
# ═══════════════════════════════════════════════════════════════════

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_header "🎨 Amazing Dotfiles Installer"

echo "This script will install the amazing dotfiles configuration."
echo "Your existing configurations will be backed up to ~/.config-backup"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_error "Installation cancelled"
    exit 1
fi

# Create backup directory
print_header "📦 Creating Backup"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
print_success "Backup directory created: $BACKUP_DIR"

# Backup existing configs
print_info "Backing up existing configurations..."
for file in .zshrc .tmux.conf; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" "$BACKUP_DIR/"
        print_success "Backed up ~/$file"
    fi
done

for dir in nvim ghostty; do
    if [ -d "$HOME/.config/$dir" ]; then
        cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
        print_success "Backed up ~/.config/$dir"
    fi
done

# Install dotfiles
print_header "🔗 Installing Dotfiles"

# Symlink shell configs
ln -sf "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
print_success "Linked .zshrc"

ln -sf "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"
print_success "Linked .tmux.conf"

# Symlink config directories
mkdir -p "$HOME/.config"

if [ -d "$SCRIPT_DIR/.config/nvim" ]; then
    ln -sf "$SCRIPT_DIR/.config/nvim" "$HOME/.config/nvim"
    print_success "Linked nvim config"
fi

if [ -d "$SCRIPT_DIR/.config/ghostty" ]; then
    ln -sf "$SCRIPT_DIR/.config/ghostty" "$HOME/.config/ghostty"
    print_success "Linked ghostty config"
fi

# Check for required tools
print_header "🔍 Checking Dependencies"

check_dependency() {
    if command -v "$1" &> /dev/null; then
        print_success "$1 is installed"
        return 0
    else
        print_warning "$1 is not installed"
        return 1
    fi
}

ALL_DEPS_INSTALLED=true

for dep in zsh tmux nvim zoxide; do
    if ! check_dependency "$dep"; then
        ALL_DEPS_INSTALLED=false
    fi
done

if [ "$ALL_DEPS_INSTALLED" = false ]; then
    echo ""
    print_warning "Some dependencies are missing. Install them with:"
    echo ""
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  brew install zsh tmux neovim zoxide"
        echo "  brew install zsh-autosuggestions zsh-syntax-highlighting"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "  sudo apt install zsh tmux neovim zoxide"
        echo "  # Or use your distribution's package manager"
    fi
    echo ""
fi

# Create necessary directories
print_header "📁 Creating Directories"
mkdir -p "$HOME/.zsh_history"
print_success "Created history directory"

# Installation complete
print_header "🎉 Installation Complete!"

echo "Your amazing dotfiles have been installed!"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. If using tmux, run: tmux source-file ~/.tmux.conf"
echo "  3. Open Neovim to verify the configuration"
echo ""
echo "Your old configs are backed up in: $BACKUP_DIR"
echo ""
print_success "Enjoy your amazing terminal experience! 🚀"
