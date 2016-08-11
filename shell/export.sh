# editor
export GIT_EDITOR=vim
export VISUAL=vim

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# linux brew
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH:"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH:"

# golang
export GOPATH="$HOME/workspace/go"
export PATH="$GOPATH/bin:$HOME/.linuxbrew/opt/go/libexec/bin:$PATH"

# perl
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

# pyenv
export PYENV_ROOT="$HOME/.linuxbrew/var/pyenv"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# nodebrew
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# neovim
export XDG_CONFIG_HOME="$HOME/.vim"

# enhancd
source "$HOME/bin/enhancd/init.sh"

