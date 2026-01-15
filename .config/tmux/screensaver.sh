#!/bin/bash
CURRENT_DIR=$(tmux display-message -p "#{pane_current_path}")

if [ -z "$CURRENT_DIR" ] || [ "$CURRENT_DIR" = "~" ]; then
  CURRENT_DIR="$HOME"
fi

if git -C "$CURRENT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
  if cd "$CURRENT_DIR"; then
    gitlogue
  else
    #cmatrix
    exit 1
  fi
else
  #cmatrix
  exit 1
fi
