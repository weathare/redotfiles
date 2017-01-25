let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_data_directory       = expand('$XDG_CONFIG_HOME/vimfiler')

if !isdirectory(g:vimfiler_data_directory)
  call mkdir(g:vimfiler_data_directory, 'p')
endif

nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -split -simple -winwidth=40 -no-quit<CR>
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -quit<CR>
autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)

au FileType vimfiler nmap <buffer> eq <Plug>(vimfiler_exit)

