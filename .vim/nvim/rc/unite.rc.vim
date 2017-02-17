let g:unite_enable_start_insert         = 1
let g:unite_source_history_yank_enable  = 1
let g:unite_source_grep_max_candidates  = 200

" call unite#set_profile('default', 'context', {'ignorecase':1})
" call unite#custom#source( 'buffer', 'converters', ['converter_file_directory'])

nnoremap  [unite]   <Nop>
nmap      <Space>u  [unite]
" カレントディレクトリを表示
nnoremap  <silent>  [unite]a  :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" バッファと最近開いたファイル一覧を表示
nnoremap  <silent>  [unite]f  :<C-u>Unite<Space>buffer file_mru directory_mru<CR>
" レジストリを表示
nnoremap  <silent>  [unite]r  :<C-u>Unite -buffer-name=register register<CR>
" ヒストリ/ヤンクを表示
nnoremap  <silent>  [unite]h  :<C-u>Unite<Space>history/yank<CR>
" ブックマーク
" nnoremap  <silent>  [unite]b  :<C-u>Unite<Space>bookmark<CR>
" call unite#custom_default_action(expand('$CACHE/unite/bookmark'), 'vimfiler')
" ブックマーク追加
nnoremap  <F11> :UniteBookmarkAdd

" Outline ------------------------------ {{{
nnoremap  <silent>  [unite]o  :<C-u>Unite<Space>outline<CR>

let g:unite_source_outline_filetype_options = {
      \ '*': {
      \   'auto_update': 1,
      \   'auto_update_event': 'write',
      \ },
      \ 'javascript': {
      \   'ignore_types': ['comment'],
      \ },
      \ 'markdown': {
      \   'auto_update_event': 'hold',
      \ },
      \ 'ruby': {
      \   'heading': '^\s*\(module\|class\|def\)\>',
      \   'skip': {
      \     'header': '^#',
      \     'block' : ['^=begin', '^=end'],
      \   },
      \ },
      \}
" }}}

" Grep --------------------------------- {{{
" 単語検索
nnoremap <silent>   <Leader>g  :<C-u>Unite grep -buffer-name=search-buffer<CR>

" カーソル上の単語検索
nnoremap <silent>   <Leader>gw :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>

" grep にhighwayを使う
if executable('hw')
  let g:unite_source_grep_command = 'hw'
  let g:unite_source_grep_default_opts = '--no-group --no-color'
  let g:unite_source_grep_recursive_opt = ''
endif

function! GetProjectDir() abort
  if exists('b:vimfiler.current_dir')
    let l:buffer_dir = b:vimfiler.current_dir
  else
    let l:buffer_dir = expand('%:p:h')
  endif

  return l:buffer_dir
endfunction
" }}}

" Go ---------------------------------- {{{
nnoremap  <silent>  <Leader>ug  :<C-u>Unite ghq<CR>
" }}}

" Rails ------------------------------- {{{
" model
nnoremap  <silent>  <Leader>rm  :<C-u>Unite rails/model<CR>
" view
nnoremap  <silent>  <Leader>rv  :<C-u>Unite rails/view<CR>
" helper
nnoremap  <silent>  <Leader>rh  :<C-u>Unite rails/helper<CR>
" controller
nnoremap  <silent>  <Leader>rc  :<C-u>Unite rails/controller<CR>
" lib
nnoremap  <silent>  <Leader>rl  :<C-u>Unite rails/lib<CR>
" db
nnoremap  <silent>  <Leader>rd  :<C-u>Unite rails/db<CR>
" config
nnoremap  <silent>  <Leader>rf  :<C-u>Unite rails/config<CR>
" log
nnoremap  <silent>  <Leader>rg  :<C-u>Unite rails/logs<CR>
" spec
nnoremap  <silent>  <Leader>rs  :<C-u>Unite rails/spec<CR>
" }}}

" au FileType unite nmap <silent> <buffer> <expr> es unite#do_action('split')
" au FileType unite imap <silent> <buffer> <expr> es unite#do_action('split')
" au FileType unite nmap <silent> <buffer> <expr> ev unite#do_action('vsplit')
" au FileType unite imap <silent> <buffer> <expr> ev unite#do_action('vsplit')
au FileType unite nmap <silent> <buffer> <ESC><ESC> q
au FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q

au FileType unite imap <silent> <buffer> <expr> <Leader>fi unite#smart_map('fi', unite#do_action('vimfiler'))
au FileType unite nmap <silent> <buffer> <expr> <Leader>fi unite#smart_map('fi', unite#do_action('vimfiler'))

" watson
nnoremap  <silent>  ,w  :<C-u>Unite watson<CR>
nnoremap  <silent>  ,wd :<C-u>Unite watson/dirty<CR>
nnoremap  <silent>  ,wc :<C-u>Unite watson/current_file<CR>
