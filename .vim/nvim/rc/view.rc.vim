" -------------------------------------
" View:
"


" スクリーンベルを無効化
set vb t_vb=
set novisualbell


" スクロール
set scrolloff=4

" 行番号
set number


" 折り返し
set wrap
set whichwrap=b,s,h,l,<,>,~,[,]

function! SetDiffMode()
  if &diff
    setlocal wrap<
  endif
endfunction
autocmd VimEnter,FilterWritePre * call SetDiffMode()


" テキスト整形オプション
" c: 幅に合わせてコメントを自動折返し
" r: 挿入モードで <Enter> を打ち込んだ後のコメント自動挿入
" l: 長い行の自動折り返しをしない
" M: 行の連結時に、マルチバイト文字の前後に空白を挿入しない
" m: マルチバイト文字の間でも改行する
" o: ノーマルモードから挿入モードのコメント自動挿入
set formatoptions=crMmoql


" 不可視文字を表示
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
highlight SpecialKey term=underline ctermfg=237 guifg=darkgray


" 開始メッセージを表示しない
set shortmess=aTI


" ウィンドウの開き方
set splitbelow


" ファイルの表示範囲
set display+=lastline

