# Set vi mode
set -o vi
set editing-mode vi
set show-mode-in-prompt

# Exports
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export EDITOR=nvim
export NVM_DIR="$HOME/.nvm"

# Define Cargo
. "$HOME/.cargo/env"

# Source files
if [ -d $HOME/.config/bash ]; then
  for file in $HOME/.config/bash/*; do
    source $file
  done
fi
unset file

# Starship prompt
eval "$(starship init bash)"
