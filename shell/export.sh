# editor
export GIT_EDITOR=vim
export VISUAL=vim

# linux brew
export PATH="/home/weathare/.linuxbrew/bin:$PATH"
export MANPATH="/home/weathare/.linuxbrew/share/man:$MANPATH:"
export INFOPATH="/home/weathare/.linuxbrew/share/info:$INFOPATH:"

# golang
export GOPATH="$HOME/workspace/go"
export PATH="$GOPATH/bin:$HOME/.linuxbrew/opt/go/libexec/bin:$PATH"

# enhancd
source "$HOME/bin/enhancd/init.sh"

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

