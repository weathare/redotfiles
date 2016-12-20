" call denite#custom#source('file_mru', 'matchers', ['matcher_cpsm', 'matcher_project_files'])
" call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])
" call denite#custom#source('directory_rec', 'matchers', ['matcher_cpsm'])

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
  \ [ '.git/', '.svn/', '.ropeproject/', '__pycache__/',
  \   'venv/', 'images/', 'img/', 'fonts/'])

if executable('hw')
  call denite#custom#var('file_rec', 'command', ['hw', '--no-group', '--no-color', '-e', ''])
  call denite#custom#var('grep', 'command', ['hw'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'default_opts', ['--no-group', '--no-color'])
endif

highlight link deniteMatched Function
highlight link deniteMatchedChar Function

call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', 'jj',    '<denite:enter_mode:normal>')
call denite#custom#map('insert', '<C-y>', '<denite:do_action:yank>')
call denite#custom#map('normal', 'y',     '<denite:do_action:yank>')
