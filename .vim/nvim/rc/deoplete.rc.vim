set completeopt+=noselect

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1

let g:deoplete#sources#omni#input_patterns = {}
let g:deoplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:deoplete#sources = {}
let g:deoplete#sources.gitcommit = ['github']

" go
let g:deoplete#sources#go#gocode_binary = expand('$GOPATH/bin/gocode')
let g:deoplete#sources#go#align_class = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#json_directory = expand('$GOPATH/data/json/1.7.4/linux_amd64')

" ternjs
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 1
let g:tern#filetypes = [
      \ 'javascript',
      \ 'javascript.jsx',
      \ 'jsx',
      \ 'vue'
      \ ]

" github
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.gitcommit = '.+'
call deoplete#util#set_pattern(
  \ g:deoplete#omni#input_patterns,
  \ 'gitcommit', [g:deoplete#keyword_patterns.gitcommit]
  \ )

inoremap <expr><TAB> pumvisible() ? "\<C-j>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-k>" : "\<S-TAB>"
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

