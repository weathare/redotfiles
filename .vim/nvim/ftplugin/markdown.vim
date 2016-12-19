" .md .mkd .markdown
" -------------------------------------
" ref: http://rcmdnk.github.io/blog/2013/11/17/computer-vim/
setlocal wrap
setlocal formatoptions+=m
setlocal autoindent

" ref:  http://qiita.com/naoty_k/items/56eddc9b76fe630f9be7
abbreviate tl - [ ]

" todoリストのon/offを切り替える
nnoremap <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>
vnoremap <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>

" 入れ子のリストを折りたたむ
setlocal foldmethod=expr foldexpr=MkdCheckboxFold(v:lnum) foldtext=MkdCheckboxFoldText()
function! MkdCheckboxFold(lnum)
  let line = getline(a:lnum)
  let next = getline(a:lnum + 1)
  if MkdIsNoIndentCheckboxLine(line) && MkdHasIndentLine(next)
    return 1
  elseif (MkdIsNoIndentCheckboxLine(next) || next =~ '^$') && !MkdHasIndentLine(next)
    return '<1'
  endif
  return '='
endfunction

function! MkdIsNoIndentCheckboxLine(line)
  return a:line =~ '^- \[[ x]\] '
endfunction

function! MkdHasIndentLine(line)
  return a:line =~ '^[[:blank:]]\+'
endfunction

function! MkdCheckboxFoldText()
  return getline(v:foldstart) . ' (' . (v:foldend - v:foldstart) . ' lines) '
endfunction

" 選択行のチェックボックスを切り替える
function! ToggleCheckbox()
  let l:line = getline('.')
  if l:line =~ '\-\s\[\s\]'
    " 完了時刻を挿入する
    let l:result = substitute(l:line, '-\s\[\s\]', '- [x]', '') . ' [' . strftime("%Y/%m/%d %H:%M") . ']'
    call setline('.', l:result)
  elseif l:line =~ '\-\s\[x\]'
    let l:result = substitute(substitute(l:line, '-\s\[x\]', '- [ ]', ''), '\s\[\d\{4}.\+]$', '', '')
    call setline('.', l:result)
  end
endfunction

syntax match MkdCheckboxMark /-\s\[x\]\s.\+/ display containedin=ALL
highlight MkdCheckboxMark ctermfg=green
syntax match MkdCheckboxUnmark /-\s\[\s\]\s.\+/ display containedin=ALL
highlight MkdCheckboxUnmark ctermfg=red
