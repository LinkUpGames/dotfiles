# Add zoxide to the command line if it exists
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi
