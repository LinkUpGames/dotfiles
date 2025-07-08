#!/bin/bash

# Install brew first and foremost
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Wezterm
brew install --cask wezterm

# Install ollama
brew install ollama

# Make zsh default
if ! which zsh; then
  brew install zsh # Only install if it's not already installed in the system
fi
chsh -s $(which zsh)

# Zap Plugin Manager
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
cd $HOME
rm -rf .zshrc

# Tmux
brew install tmux

# Neovim
brew install neovim

# fzf
brew install fzf

# yazi
brew install yazi ffmpegthumbnailer unar jq poppler fd ripgrep fzf zoxide font-symbols-only-nerd-font

# csvlens
brew install csvlens

# fd-find
brew install fd

# nvm
brew install nvm

# lazygit
brew install lazygit

# bat
brew install bat

# Lazy docker
brew install lazydocker

# Eza
brew install eza

# Stow
brew install stow

# MAC Specific Apps #
# Terminal Notififer
brew install terminal-notifier

# SKHD
brew install koekeishiya/formulae/skhd

# Spicetify
brew install spicetify-cli

# Devpods
brew install --cask devpod

# Television
brew install television

# Yabai
brew install koekeishiya/formulae/yabai

# Start Services
skhd --start-service
yabai --start-service

# Janky Borders
brew tap FelixKratz/formulae
brew install borders

## Now link all the dependencies install
cd $HOME

cd dotfiles

stow .

echo "Installation Complete! - Restart the shell in order for everything to take effect"
