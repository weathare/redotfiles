let g:deoplete#enable_at_startup          = 1
let g:deoplete#enable_ignore_case         = 1
let g:deoplete#enable_smart_case          = 1
let g:deoplete#auto_complete_start_length = 2

let g:deoplete#file#enable_buffer_path = 1

let g:deoplete#sources#omni#input_patterns = {}
let g:deoplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" inoremap <silent> <expr><CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr><C-h> deolete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"
