if executable('hw')
  call denite#custom#var('file_rec', 'command', ['hw', '--no-group', '--no-color'])
  call denite#custom#var('grep', 'command', ['hw'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'default_opts', ['--follow-link', '--no-group', '--no-color'])
endif

call denite#custom#map('insert', '<C-j>',   '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-k>',   '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<TAB>',   '<denite:move_to_next_line>')
call denite#custom#map('insert', '<S-TAB>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', 'jj',      '<denite:enter_mode:normal>')

highlight link deniteMatched Underline
highlight link deniteMatchedChar DiffText

