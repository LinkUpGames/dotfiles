#!/bin/bash

if command -v wlogout &> /dev/null; then
  # Run the
  wlogout
else
  nofity-send "wlogout command not found"
fi
