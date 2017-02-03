# Cute shell shortcuts
# alias ls='ls --sort=extension --color=auto'
alias ls='ls --color=auto'
alias l='ls -CF'
alias ll='ls -lFh'
alias la='ls -A'
alias lla='ls -alh'
alias cls='clear && ll'
alias md='mkdir -p'
alias grep='grep --color'
alias h='history'
alias less='~/.linuxbrew/share/nvim/runtime/macros/less.sh'
alias tmux='tmux -2'
alias ruby-new='rbenv install -l | grep -v - | tail -1'
alias vi='nvim'
alias gti='git'

# This one is to take care of make
# Give me a nice, distinguishable make output
alias make='clear && make'
alias m='make'
alias smi='sudo make install'

# Some more, to avoid mistakes
alias rm='rm -i'

# Some quick shourtcuts
alias reload='source ~/.bashrc'
alias reboot='sudo shutdown -r now'
alias off='sudo shutdown -h now'
alias keys='ssh-add -l'

