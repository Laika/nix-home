alias gdb='gdb -q'
alias mv='mv -i -v'
alias sl='ls'
alias vim='nvim'
alias dc='docker compose'
alias backlight='sudo tee /sys/class/backlight/intel_backlight/brightness'
alias wget='wget -c --content-disposition'
alias cg='cd $(git rev-parse --show-toplevel)'
alias send='cp -v $(ls -a | fzf -0 -1) /mnt/nas/Cache'
[[ $(command -v rsync) ]] && alias cp='rsync -ah --info=progress2'
[[ $(command -v bibtex-tidy) ]] && alias bibtex-format='bibtex-tidy --curly --blank-lines --duplicates --trailing-commas'
[[ $(command -v eza) ]] && alias ls='eza -F --group-directories-first' || alias ls='ls -hF --color=auto'
[[ $(command -v eza) ]] && alias tree='eza -T -L 3 -a -I "node_modules|.git|.cache" --icons'
[[ $(command -v fdfind) ]] && alias fd='fdfind'
[[ $(command -v procs) ]] && alias ps='procs'
[[ $(command -v rg) ]] && alias rg='rg --max-columns-preview'
[[ $(command -v trash-put) ]] && alias rm='trash-put'
[[ $(command -v tty-clock) ]] && alias clock='tty-clock -s -c'
[[ $(command -v xclip) ]] && alias copy='xclip -selection c'
[[ $(command -v wl-copy) ]] && alias copy='wl-copy'
[[ $(command -v kitty) ]] && alias icat='kitty +kitten icat'
[[ $(command -v pwninit) ]] && alias pwninit='pwninit --no-template'
[[ $(command -v minikube) ]] && alias k='minikube kubectl'
[[ $(command -v kubectl) ]] && alias k='kubectl'
[[ $(command -v makers) ]] && alias m='makers'

# Git
alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gc='git commit -m'
alias gp='git push'
