#!/bin/bash

cd $HOME

# Wezterm
sudo dnf copr enable wezfurlong/wezterm-nightly -y
sudo dnf install wezterm -y

# Install zsh
dnf install zsh -y

# Make zsh default
chsh -s $(which zsh)

# Zap plugin manager
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
cd $HOME
rm -rf .zshrc

# Tmux
dnf install tmux -y

# Neovim
dnf install neovim -y

# fzf
dnf install fzf -y

# yazi
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update

cargo install --locked yazi-fm yazi-cli

# csvlens
cargo install csvlens

# fd-find
dnf install fd-find -y

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# lazygit
dnf copr enable atim/lazygit -y
dnf install lazygit -y

# bat
dnf install bat -y

# Lazy docker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Stow
dnf install stow -y

## Now link all the dependencies install
cd $HOME

cd dotfiles

stow .

echo "Installation Complete! - Restart the shell in order for everything to take effect"
