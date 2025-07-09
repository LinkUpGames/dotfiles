# Yazi
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"

  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Television
function cdf() {
  local dir=$(tv dirs)

  # Only go to output if the result is greater than 0
  if [[ -n "$dir" ]]; then
    cd "$dir"
  fi
}
