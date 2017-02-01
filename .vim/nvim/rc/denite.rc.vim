call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
  \ [ '.git/', '.svn/', '.ropeproject/', '__pycache__/',
  \   'venv/', 'images/', 'img/', 'fonts/', 'doc/'])

if executable('hw')
  call denite#custom#var('file_rec', 'command',
        \ ['hw', '--all-files', '--follow-link', '--no-group', '--no-color', ''])
  call denite#custom#var('grep', 'command', ['hw'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'separator', [])
  call denite#custom#var('grep', 'default_opts', ['--no-group', '--no-color', '-e'])
endif
call denite#custom#source('file_rec', 'matchers', ['matcher_ignore_globs'])

highlight link deniteMatched Function
highlight link deniteMatchedChar Function
highlight link deniteMatchedRange Function

call denite#custom#option('default,grep', 'highlight_mode_insert', 'SpecialChar')
call denite#custom#option('default,grep', 'highlight_mode_normal', 'SpecialChar')

call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', 'jj',    '<denite:enter_mode:normal>')
call denite#custom#map('insert', '<C-y>', '<denite:do_action:yank>')
call denite#custom#map('normal', 'y',     '<denite:do_action:yank>')

nnoremap  [denite]  <Nop>
nmap      <Leader>d [denite]
nnoremap  [denite]a :<C-u>Denite buffer file_mru directory_rec<CR>
nnoremap  [denite]f :<C-u>Denite file_rec<CR>
nnoremap  [denite]h :<C-u>Denite register unite:register neoyank<CR>
nnoremap  [denite]o :<C-u>Denite unite:outline<CR>
nnoremap  [denite]t :<C-u>Denite filetype<CR>
