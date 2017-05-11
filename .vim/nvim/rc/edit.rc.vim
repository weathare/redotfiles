" -------------------------------------
" Edit:
"

" タブ
set smarttab
set expandtab
set ts=2 sw=2 sts=2

" インデント
set shiftwidth=2
set shiftround
set autoindent smartindent

" modeline
set modeline

" backspaceキーを許可
set backspace=indent,eol,start

" ハイライト
set showmatch
set cpoptions-=m
set matchtime=3
set matchpairs+=<:>

" 編集行表示
set cursorline
hi clear CursorLine

" 作業ファイル
set noswapfile
set nowritebackup
set nobackup
set hidden

" 補完
set infercase
set pumheight=12

" " 折りたたみ
" set foldenable
" set foldmethod=expr
" set foldcolumn=1
" set fillchars=vert:\|
" set commentstring=%s

" Visualモード
set virtualedit=block

if has('autocmd')
  " 更新スタンプをチェック
  augroup vimrc-checktime
    autocmd!
    autocmd WinEnter * checktime
  augroup END
endif


set formatexpr=autofmt#japanese#formatexpr()

" マウス
set mouse=a
