function! s:escape(path)
  return substitute(a:path, ' ', '\\ ', 'g')
endfunction

function! HwHandler(line)
  let parts = split(a:line, ':')
  let [fn, lno] = parts[0 : 1]
  execute 'e '. s:escape(fn)
  execute lno
  normal! zz
endfunction

command! -nargs=+ Fpt call fzf#run({
  \ 'source': 'hw --no-group --no-color "<args>"',
  \ 'sink': function('HwHandler'),
  \ 'options': '+m',
  \ 'tmux_height': '50%'
  \ })

