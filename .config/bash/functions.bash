function yy() {
  local temp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd

  yazi "$@" --cwd-file="$temp"

  if cwd="$(command cat -- "temp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi

  rm -f -- "$temp"
}
