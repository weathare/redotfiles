extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)    tar xjf $1      ;;
      *.tar.gz)     tar xzf $1      ;;
      *.bz2)        bunzip2 $1      ;;
      *.rar)        rar x $1        ;;
      *.gz)         gunzip $1       ;;
      *.tar)        tar xf $1       ;;
      *.tbz2)       tar xjf $1      ;;
      *.tgz)        tar xzf $1      ;;
      *.zip)        unzip $1        ;;
      *.Z)          uncompress $1   ;;
      *)            echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
alias extract='extract'

psg() {
  if [ ! -z $1 ] ; then
    echo "Grepping for processes matching $1..."
    ps auwwx | grep $1 
  else
    echo "!! Need name to grep for"
  fi
}
alias psg='psg'

mcd() {
  mkdir -p $1 && cd $1
}
alias mcd='mcd'

# function peco-select-history() {
#   local l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
#   READLINE_LINE="$l"
#   READLINE_POINT=${#l}
# }
# bind -x '"\C-r": peco-select-history'

# ghq + fzf: ghq管理のパスを探索
frepo() {
  local dir
  dir=$(ghq list | fzf-tmux --reverse) && cd $(ghq root)/$dir
}
alias frepo='frepo'

# gch + fzf: 作業中のGOPATHへ移動
fcd() {
  local dir
  dir=$(gch -l | fzf-tmux --reverse | awk '{print $1}') && cd $dir && git status --short --branch -u
}
alias fcd='fcd'

# git add + fzf: git add支援
fad() {
  local addfiles
  addfiles=$(git status --short --branch -u | grep -v '##' | awk '{ print $2 }' | fzf-tmux --multi)
  if [[ -n $addfiles ]]; then
    git add $addfiles && git status --short --branch -u
  else
    echo "nothing added."
  fi
}
alias fad='fad'

fdel-branch() {
  local current branches
  current=$(git rev-parse --abbrev-ref HEAD)
  branches=$(git branch --merged master | grep -vE '^\*|master$|"$current"$' | fzf-tmux --multi)
  if [[ -n $branches ]]; then
    git branch -d $branches
  else
    echo "nothing deleted."
  fi
}
alias fdel-branch='fdel-branch'

# checkout git branch/tag + fzf
fco()
{
  local tags branches taragat
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD  | grep -v "origin/master" | 
    sed "s/.* //"    |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -d -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | sed "s#remotes/[^/]*/##" | awk '{print $2}')
}
alias fco='fco'

fshow() {
  local current branch
  current=$(git rev-parse --abbrev-ref HEAD)
  if [ "$current" = 'master' ]; then
    branch="$current"
  else
    branch='master..'"$current"
  fi

  git log "$branch" --date=short --color \
    --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
    --bind "ctrl-m:execute:
              (grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
              {}
FZF-EOF"
}
alias fshow='fshow'

# ps + peco: 実行中プロセスを殺します
peco-kill() {
  proc=`ps aux | peco`
  pid=`echo "$proc" | awk '{print $2}'`
  echo "kill pid:$pid. [$proc]"
  kill $pid
}
alias peco-kill='peco-kill'

fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) && tmux switch-client -t "$session"
}

ghq-update() {
  ghq list | sed -E 's/^[^\/]+\/(.+)/\1/' | xargs -n 1 -P 10 ghq get -u
}
alias ghq-update='ghq-update'

# snippet + git aliasからインタラクティブに補完
__command_snippets() {
  snip=$({ \
    grep -v "^\s*#" ~/dotfiles/.snippets | grep -v "^\s*$"; \
    git aliases | sed -e 's/^\t/git /g'; \
  } | fzf-tmux --no-sort --reverse | \
  awk '{if($0 ~ /#/)print substr($0, 0, index($0, "#")-1); else if($0 ~ /git/)print $1" "$2; else print $0}' | \
  sed -e 's/[   ]*$//g')
  if [ -n '$snip' ] ; then
    builtin bind '"\er": clear-screen'
    builtin bind '"\e^": magic-space'
    READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${snip}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
    READLINE_POINT=$(( READLINE_POINT + ${#snip} ))
  else
    builtin bind '"\er": clear-screen'
    builtin bind '"\e^":'
  fi
}
bind -x '"\C-x1": __command_snippets'
bind '"\C-t": "\C-x1\e^\er"'
