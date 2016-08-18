" number incremant
nnoremap + <C-a>
nnoremap - <C-x>

" 検索ハイライト消し
nnoremap <silent> <ESC><ESC> :nohlsearch<CR><ESC>

" insertから抜けたらIME解除
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" replace
abbreviate vft # vim: filetype=

" ウィンドウを分割 & 移動
nnoremap e  <Nop>
nnoremap es :<C-u>sp<CR>  " split
nnoremap ev :<C-u>vs<CR>  " vsplit
nnoremap ej <C-w>j
nnoremap ek <C-w>k
nnoremap el <C-w>l
nnoremap eh <C-w>h
nnoremap eJ <C-w>J
nnoremap eK <C-w>K
nnoremap eL <C-w>L
nnoremap eH <C-w>H
nnoremap eq :<C-u>q<CR>   " ウィンドウを閉じる
nnoremap eQ :<C-u>bq<CR>  " バッファを閉じる

" insertモードを抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j
inoremap <silent> kk <ESC>
inoremap <silent> <C-k> k

" insertモードのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" deinアップデート
cnoremap deinup :call dein#update()<CR>

" 行末までヤンク
nnoremap Y y$