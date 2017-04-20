" send
nnoremap  <silent>  ,tl :TREPLSendLine<CR>
vnoremap  <silent>  ,tl :TREPLSendSelection<CR>
" close
nnoremap  <silent>  ,th :call neoterm#close()<CR>
" kill
nnoremap  <silent>  ,tc :call neoterm#kill()<CR>
" toggle
nnoremap  <silent>  ,tg :Ttoggle<CR>

" rails
command! -nargs=+ Troute :T rails routes | grep <args>
command! Troutes   :T rails routes
command! Tdbsreset :T rails db:reset
command! Tdbmreset :T rails db:migrate:reset
command! Trailss   :T rails s -b 0.0.0.0
command! Trbcop    :T rubocop -a %:p
