" 保存時に実行
autocmd! BufWritePost * Neomake
let g:neomake_css_enabled_makers = ['stylelint']
let g:neomake_go_enabled_makers = ['go', 'golint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_json_enabled_makers = ['jsonlint']
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_sass_enabled_makers = ['stylelint']
let g:neomake_scss_enabled_makers = ['stylelint']

let g:neomake_error_sign = { 'text': "✘", 'texthl': 'icebergLLError' }
let g:neomake_warning_sign = { 'text': "»", 'texthl': 'icebergLLError' }
let g:neomake_message_sign = { 'text': "»", 'texthl': 'icebergLLWarning' }
let g:neomake_info_sign = { 'text': "*", 'texthl': 'Todo' }
