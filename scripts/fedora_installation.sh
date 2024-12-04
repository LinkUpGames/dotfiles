#!/bin/bash

cd $HOME

# Get the password first to download packages
read -p "Enter SUDO Password: " password

# Wezterm
echo $password | sudo dnf copr enable wezfurlong/wezterm-nightly -y
echo $password | sudo dnf install wezterm -y

# Install zsh
echo $passowrd | sudo dnf install zsh -y

# Make zsh default
echo $password | chsh -s $(which zsh)

# exec zsh

# Zap plugin manager
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

cd $HOME
rm -rf .zshrc

# Tmux
echo $password | sudo dnf install tmux -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Neovim
echo $password | sudo dnf install neovim -y

# fzf
echo $password | sudo dnf install fzf -y

# fd-find
echo $password | sudo dnf install fd-find -y

# eza
echo $password | sudo dnf install eza -y

# lazygit
echo $password | sudo dnf copr enable atim/lazygit -y
echo $password | sudo dnf install lazygit -y

# bat
echo $password | sudo dnf install bat -y

# Lazy docker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Stow
echo $password | sudo dnf install stow -y

# Switch Shell
zsh

# yazi
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -q -y
. "$HOME/.cargo/env" # For sh/bash/zsh/ash/dash/pdksh
rustup update

cargo install --locked yazi-fm yazi-cli

# csvlens
cargo install csvlens

# Spicetify
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh

## Now link all the dependencies install
cd $HOME

cd dotfiles

stow .

echo "Installation Complete! - Restart the shell in order for everything to take effect"
