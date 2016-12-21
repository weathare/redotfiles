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

nnoremap  [denite]  <Nop>
nmap      <Leader>n [denite]
nnoremap  [denite]a :<C-u>Denite buffer file_mru directory_rec<CR>
nnoremap  [denite]f :<C-u>DeniteProjectDir file_mru directory_rec<CR>
nnoremap  [denite]h :<C-u>Denite -buffer-name=yank register unite:register neoyank<CR>
nnoremap  [denite]o :<C-u>Denite -buffer-name=outline unite:outline<CR>
nnoremap  [denite]t :<C-u>Denite filetype<CR>
