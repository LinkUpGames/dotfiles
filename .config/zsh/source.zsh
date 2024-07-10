# We have to add this for now until they update fzf for Fedora
if [ $(uname) = "Darwin" ]; then
  source <(fzf --zsh)
fi
