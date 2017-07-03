set completeopt+=noselect
set completeopt-=preview

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1

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

inoremap <expr><TAB> pumvisible() ? "\<C-j>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-k>" : "\<S-TAB>"

