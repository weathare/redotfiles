# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ref; https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
# ref: http://sue445.hatenablog.com/entry/2012/08/30/005627
if [ ! -f "$HOME/bin/git-completion.bash" ] ; then
  curl -sL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > "$HOME/bin/git-prompt.sh"
  curl -sL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > "$HOME/bin/git-completion.bash"
fi
if [ -f "$HOME/bin/git-completion.bash" ] ; then
  source "$HOME/bin/git-prompt.sh"
  source "$HOME/bin/git-completion.bash"
  POH='ヾ(｡﹏｡)ﾉﾞ'
  if [ -r "$HOME/bin/git-completion.bash" ] ; then
    PS1='\[\033[0;38;5;111m\]\u@\h\[\033[0;38;5;6m\] \w$(__git_ps1 " (%s)") \n\[\033[00m\]$POH \$ '
  else
    PS1="\[\033[0;38;5;111m\]\u@\h\[\033[0;38;5;6m\] \w \n$POH \$ "
  fi
fi

# ls color
# ref: https://github.com/seebi/dircolors-solarized
if [ -f "$HOME/bin/dircolors" ]; then
  if type dircolors > /dev/null 2>&1; then
    eval $(dircolors "$HOME/bin/dircolors")
  elif type gdircolors > /dev/null 2>&1; then
    eval $(gdircolors "$HOME/bin/dircolors")
  fi
else
  if [ ! -d "$HOME/bin/dircolors-solarized" ]; then
    git clone https://github.com/seebi/dircolors-solarized.git "$HOME/bin/dircolors-solarized"
  fi
  if [ ! -f "$HOME/bin/dircolors" ]; then
    cd "$HOME/bin"
    ln -s dircolors-solarized/dircolors.256dark dircolors
    eval $(dircolors ~/bin/dircolors)
  fi
fi

# Cool colors for Man Pages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

# tmux
# [ -n "$TMUX" ] && export TERM=screen-256color
# [ "$TERM" = "xterm" ] && export TERM=xterm-256color && tmux
[ "$TERM" = "xterm" ] && export TERM=xterm-256color

# history
function share_history {
  history -a
  history -c
  history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

