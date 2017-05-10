# editor
export EDITOR=nvim
export VISUAL=nvim

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# linux brew
export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH:"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH:"

# golang
export GOPATH="$HOME/workspace"
export PATH="$GOPATH/bin:$HOME/.linuxbrew/opt/go/libexec/bin:$PATH"

# perl
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

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

# rust cargo
export PATH="$HOME/.cargo/bin:$PATH"
