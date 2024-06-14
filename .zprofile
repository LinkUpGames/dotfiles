# Check if homebrew is installed
# What os are we running?
if [ $(uname) = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
#else
 # eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export NVM_DIR="$HOME/.nvm"

# Set up neovim as the default editor
export EDITOR=nvim

alias vim=nvim
alias fif="ssh -L 5173:localhost:5173 -L 5174:localhost:5174 -L 3000:localhost:3000 -L 8000:localhost:8000 -L 8080:localhost:8080 mac"
alias ls=eza

[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
