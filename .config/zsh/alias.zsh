alias vim=nvim
alias v=nvim
alias fif="ssh -L 5173:localhost:5173 -L 5174:localhost:5174 -L 3000:localhost:3000 -L 8000:localhost:8000 -L 3002:localhost:3002 -L 8080:localhost:8080 fif"
alias ls='eza --color=always --icons=always --no-user'
alias cat='bat --paging=never --style="header,changes,numbers" --theme="Visual Studio Dark+"'
alias less='bat --style="header,changes,numbers" --theme="Visual Studio Dark+"'
#alias cdf='cd ./$(fd . --type d --hidden --max-depth 6 --exclude .git --exclude node_modules --exclude .cache | fzf --layout reverse --border)'
