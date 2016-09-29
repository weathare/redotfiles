function! s:escape(path)
  return substitute(a:path, ' ', '\\ ', 'g')
endfunction

function! PtHandler(line)
  let parts = split(a:line, ':')
  let [fn, lno] = parts[0 : 1]
  execute 'e '. s:escape(fn)
  execute lno
  normal! zz
endfunction

command! -nargs=+ Fpt call fzf#run({
  \ 'source': 'pt --color --nogroup --column "<args>"',
  \ 'sink': function('PtHandler'),
  \ 'options': '+m',
  \ 'tmux_height': '50%'
  \ })

