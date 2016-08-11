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


" " 折りたたみ
" set foldenable
" set foldmethod=expr
" set foldcolumn=1
" set fillchars=vert:\|
" set commentstring=%s

" Visualモード
set virtualedit=block

" 更新スタンプをチェック
autocmd MyAutoCmd WinEnter * checktime

" -------------------------------------
" Make directory automatically.
" --------------------------------------
" http://vim-users.jp/2011/02/hack202/
autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

set formatexpr=autofmt#japanese#formatexpr()

