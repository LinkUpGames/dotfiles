# Yazi
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd

  yazi "$@" --cwd-file="$tmp"

  IFS= read -r -d '' cwd <"$tmp"

  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"

  rm -f -- "$tmp"
}

# Television
# Go to a directory
function cdd() {
  local dir=$(tv dirs)

  # Only go to output if the result is greater than 0
  if [[ -n "$dir" ]]; then
    # check if zoxide it installed
    if command -v z >/dev/null; then
      z "$dir"
    else
      cd "$dir"

    fi
  fi
}

# Open a file in a directory
function cdf() {
  local file=$(tv)

  if [[ -n "$file" ]]; then
    nvim $file
  fi
}

# Use bat if available
function less() {
  if command -v bat >/dev/null; then
    bat --style="header,changes,numbers" --theme="Visual Studio Dark+" "$@"
  else
    command less "$@"
  fi
}

# Use bat if available
function cat() {
  if command -v bat >/dev/null; then
    bat --paging=never --style="header,changes,numbers" --theme="Visual Studio Dark+" "$@"
  else
    command cat "$@"
  fi
}

# Use Eza if available
function ls() {
  if command -v eza >/dev/null; then
    eza --color=always --icons=always --no-user "$@"
  else
    command ls "$@"
  fi
}
