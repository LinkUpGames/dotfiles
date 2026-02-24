#!/bin/sh
CURRENT_DIR=$(tmux display-message -p "#{pane_current_path}")

if [ -z "$CURRENT_DIR" ] || [ "$CURRENT_DIR" = "~" ]; then
  CURRENT_DIR="$HOME"
fi

if git -C "$CURRENT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
  if cd "$CURRENT_DIR"; then
    if command -v gitlogue >/dev/null; then
      gitlogue
    fi
  else
    if command -v cmatrix >/dev/null; then
      cmatrix -s
    else
      exit 1
    fi
  fi
else
  if command -v cmatrix >/dev/null; then
    cmatrix -s
  else
    exit 1
  fi
fi
