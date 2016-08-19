function show () {
  apt-cache search $1
}

function giveme () {
  sudo apt-get install "$@"
}

function extract () {
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

function psg() {
  if [ ! -z $1 ] ; then
    echo "Grepping for processes matching $1..."
    ps auwwx | grep $1 
  else
    echo "!! Need name to grep for"
  fi
}

function mcd() {
  mkdir -p $1 && cd $1
}

# function peco-select-history() {
#   local l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
#   READLINE_LINE="$l"
#   READLINE_POINT=${#l}
# }
# bind -x '"\C-r": peco-select-history'

# ghq + fzf: ghq管理のパスを探索
function fzrepo() {
  local dir
  dir=$(ghq list | fzf-tmux --reverse) && cd $(ghq root)/$dir
}

# gch + fzf: 作業中のGOPATHへ移動
function gcd() {
  local dir
  dir=$(gch -l | fzf-tmux --reverse | awk '{print $0}') && cd $dir && git status --short --branch
}

# git add + fzf: git add支援
gaf() {
  local addfiles
  addfiles=$(git status --short | grep -v '##' | awk '{ print $2 }' | fzf-tmux --multi)
  if [[ -n $addfiles ]]; then
    git add $addfiles && git status --short --branch
  else
    echo "nothing added.\n"
  fi
}

# ps + peco: 実行中プロセスを殺します
function peco-kill() {
  proc=`ps aux | peco`
  pid=`echo "$proc" | awk '{print $2}'`
  echo "kill pid:$pid. [$proc]"
  kill $pid
}

