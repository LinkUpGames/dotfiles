# Entry Point

# Set vi mode
set -o vi
set editing-mode vi
set show-mode-in-prompt

# Exports
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export EDITOR=nvim
export NVM_DIR="$HOME/.nvm"

# Define Cargo
if [ -d $HOME/.cargo ]; then
  . "$HOME/.cargo/env"
fi

# Source files
if [ -d $HOME/.config/bash ]; then
  for file in $HOME/.config/bash/*; do
    if [[ "$file" != "${BASH_SOURCE[0]}" ]]; then
      source $file
    fi
  done
fi
unset file

# Starship prompt
eval "$(starship init bash)"
