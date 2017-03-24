# editor
export EDITOR=nvim
export VISUAL=nvim

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# linux brew
export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH:"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH:"

# golang
export GOPATH="$HOME/workspace"
export PATH="$GOPATH/bin:$HOME/.linuxbrew/opt/go/libexec/bin:$PATH"

# perl
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# ndenv
export PATH="$HOME/.ndenv/bin:$PATH"
eval "$(ndenv init -)"

# neovim
export XDG_CONFIG_HOME="$HOME/.vim"

# enhancd
source "$HOME/bin/enhancd/init.sh"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="
  --ansi
  --reverse
  --exit-0
  --color info:183,prompt:110,spinner:107,pointer:167,marker:215
"

# hub
eval "$(hub alias -s)"
