# Dotfiles

A collection of my personal configuration files for various tools and applications.

## Overview

This repository contains configuration files (dotfiles) for the tools I use in my development environment. These configurations help maintain consistency across different machines and make setup easier.

## Configurations Included

- **Fish Shell** - Custom shell configuration with aliases and functions
- **Git** - Global git configuration
- **Neovim** - Text editor configuration
- **Kitty** - Terminal emulator settings
- **Tmux** - Terminal multiplexer configuration
- **Hammerspoon** - macOS automation tool
- **Starship** - Custom shell prompt
- **Yazi** - Terminal file manager
- **Btop** - System monitor
- **Bat** - Cat clone with syntax highlighting
- **Picom** - Compositor for X11
- **Sxhkd** - Simple X hotkey daemon
- And more...

## Installation

This repository is organized to work with [GNU Stow](https://www.gnu.org/software/stow/), a symlink farm manager.

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Install GNU Stow if you haven't already:
   ```bash
   # macOS
   brew install stow
   
   # Ubuntu/Debian
   sudo apt install stow
   ```

3. Use Stow to symlink configurations:
   ```bash
   # Example: Stow fish configuration
   stow fish
   
   # Stow all configurations
   stow */
   ```

## Usage

After installation, restart your terminal or source your shell configuration:
```bash
# For fish
source ~/.config/fish/config.fish
```

## Customization

Feel free to fork this repository and modify the configurations to suit your needs. Remember to update the git remote URL if you plan to push changes to your own repository:
```bash
git remote set-url origin https://github.com/yourusername/dotfiles.git
```