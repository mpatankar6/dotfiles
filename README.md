# 🎨 Amazing Dotfiles

A modern, beautiful, and highly functional dotfiles configuration for an enhanced terminal experience.

## ✨ Features

### 🐚 Zsh Configuration
- **Smart prompt** with color-coded username, host, and current directory
- **Intelligent history** with duplicate removal and sharing across sessions
- **Auto-suggestions** for faster command completion
- **Syntax highlighting** for better readability
- **Zoxide integration** for smart directory jumping
- **Useful aliases** for common tasks
- **Auto-correction** for typos

### 📺 Tmux Configuration
- **Mouse support** for easy pane resizing and scrolling
- **Vim-style navigation** (Alt+h/j/k/l) for pane switching
- **Fast window switching** with Alt+Shift+h/l
- **Clean, centered status bar** with custom styling
- **Top-positioned status bar** for better visibility

### 🖥️ Ghostty Terminal
- **Beautiful background images** with configurable opacity
- **Catppuccin theme** with dark/light mode support
- **Readable font size** (16pt) with thickening for clarity
- **Gorgeous aesthetic** that makes coding a pleasure

### 💻 Neovim Configuration
- **Unokai color scheme** for eye-friendly syntax highlighting
- **Transparent background** for a seamless look with terminal backgrounds
- **Clean and minimal** setup focused on performance

## 📦 Requirements

- **Zsh** - Modern shell
- **Tmux** - Terminal multiplexer
- **Neovim** - Modern Vim fork
- **Ghostty** - Modern terminal emulator
- **Zoxide** - Smart directory jumper
- **Homebrew** (for macOS users) - Package manager

### Install Requirements (macOS)

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required packages
brew install zsh tmux neovim zoxide
brew install zsh-autosuggestions zsh-syntax-highlighting

# Install Ghostty (download from https://ghostty.org/)
```

## 🚀 Installation

### Quick Install

```bash
# Clone the repository (replace <username> with the repository owner)
git clone https://github.com/<username>/dotfiles.git ~/.dotfiles-repo
cd ~/.dotfiles-repo

# Backup existing configs (optional but recommended)
mkdir -p ~/.config-backup
cp -r ~/.zshrc ~/.tmux.conf ~/.config/nvim ~/.config/ghostty ~/.config-backup/ 2>/dev/null || true

# Create symlinks
ln -sf ~/.dotfiles-repo/.zshrc ~/.zshrc
ln -sf ~/.dotfiles-repo/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles-repo/.config/nvim ~/.config/nvim
ln -sf ~/.dotfiles-repo/.config/ghostty ~/.config/ghostty

# Reload configurations
source ~/.zshrc
tmux source-file ~/.tmux.conf 2>/dev/null || true
```

### Manual Installation

Copy or symlink the configuration files to your home directory:

```bash
.zshrc          → ~/.zshrc
.tmux.conf      → ~/.tmux.conf
.config/nvim/   → ~/.config/nvim/
.config/ghostty/ → ~/.config/ghostty/
```

## 🎯 Key Bindings

### Tmux
- `Alt + h/j/k/l` - Navigate between panes (Vim-style)
- `Alt + Shift + h/l` - Switch between windows
- `Prefix + ?` - Show all key bindings (default prefix: Ctrl+b)

### Zsh
- `cd <partial-path>` - Use zoxide for smart jumping to frequent directories
- `Tab` - Auto-completion with suggestions
- `Up/Down arrows` - Browse command history

## 🎨 Customization

### Change Zsh Prompt Color
Edit `.zshrc` and modify the `PROMPT` variable:
```bash
export PROMPT='%F{green}%n@%m%f %1~ %# '  # Change 'green' to your preferred color
```

### Customize Tmux Status Bar
Edit `.tmux.conf` to adjust the status bar appearance:
```bash
set -g status-style "bg=default"
set -g window-status-current-style "fg=blue bold"
```

### Change Terminal Background
Place your preferred image in `.config/ghostty/images/` and update the config:
```bash
background-image = "images/your-image.jpg"
background-image-opacity = 0.15  # Adjust opacity (0.0 to 1.0)
```

## 📝 Useful Aliases

The `.zshrc` includes these helpful aliases:
- `ll` - Detailed file listing (`ls -la`)
- `dotfiles` - Manage dotfiles with Git

## 🤝 Contributing

Feel free to fork this repository and customize it to your needs! If you have suggestions for improvements, please open an issue or submit a pull request.

## 📄 License

Feel free to use and modify these configurations for your personal use.

## 🌟 Credits

- **Catppuccin** theme for beautiful terminal colors
- **Unokai** color scheme for Neovim
- **Zoxide** for smart directory navigation
- **Zsh** plugins for enhanced shell experience

---

Made with ❤️ for a better terminal experience
