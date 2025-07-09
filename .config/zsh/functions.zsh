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
# Go to a directory
function cdd() {
  local dir=$(tv dirs)

  # Only go to output if the result is greater than 0
  if [[ -n "$dir" ]]; then
    cd "$dir"
  fi
}

# Open a file in a directory
function cdf() {
  local file=$(tv)
  # local dir=$(dirname $file)

  # echo $dir

  if [[ -n "$file" ]]; then
    nvim $file
  fi

}
