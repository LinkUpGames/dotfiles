# Set vi mode
set -o vi
set editing-mode vi
set show-mode-in-prompt

# Alias
alias v=nvim

# Exports
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# Starship prompt
eval "$(starship init bash)"
