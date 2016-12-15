" -------------------------------------
" Snippet:
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#snippets_directory = [
      \ '~/.vim/snippets',
      \ '~/.vim/dein/repos/github.com/hfm/itamae-snippets/',
      \ '~/.vim/dein/repos/github.con/Shougo/neosnippet-snippets/neosnippets'
      \ ]

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)



augroup MyAutoCmd
  autocmd BufEnter,BufRead,BufNew app/views/*             NeoSnippetSource ~/.vim/snippets/ruby.rails.view.snip
  autocmd BufEnter,BufRead,BufNew app/controllers/**/*.rb NeoSnippetSource ~/.vim/snippets/ruby.rails.controller.snip
  autocmd BufEnter,BufRead,BufNew app/models/**/*.rb      NeoSnippetSource ~/.vim/snippets/ruby.rails.model.snip
  autocmd BufEnter,BufRead,BufNew app/db/migrate/*        NeoSnippetSource ~/.vim/snippets/ruby.rails.migrate.snip
  autocmd BufEnter,BufRead,BufNew app/config/routes.rb    NeoSnippetSource ~/.vim/snippets/ruby.rails.route.snip
  autocmd BufEnter,BufRead,BufNew spec/**/*.rb            NeoSnippetSource ~/.vim/snippets/ruby.rails.rspec.snip
  autocmd BufEnter,BufRead,BufNew lib/task/*.task         NeoSnippetSource ~/.vim/snippets/ruby.rails.rake.snip
augroup END
