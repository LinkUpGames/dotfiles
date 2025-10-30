#!/bin/bash

LOGFILE="$HOME/logs/dotfiles.log"

# Update own dotfiles if any
{
  echo "Updating ..."

  cd $HOME/dotfiles
  git pull origin main

  nvim --headless "+Lazy! sync" +qa

  echo "Update done!"
} >"$LOGFILE" 2>&1
