" -------------------------------------
" Snippet:

let g:neosnippet#snippets_directory = '~/.vim/snippets'

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>"

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

augroup MyAutoCmd
    autocmd BufEnter,BufRead,BufNew app/views/*          NeoSnippetSource ~/.vim/snippets/ruby.rails.view.snip
    autocmd BufEnter,BufRead,BufNew app/controllers/*.rb NeoSnippetSource ~/.vim/snippets/ruby.rails.controller.snip
    autocmd BufEnter,BufRead,BufNew app/models/*.rb      NeoSnippetSource ~/.vim/snippets/ruby.rails.model.snip
    autocmd BufEnter,BufRead,BufNew app/db/migrate/*     NeoSnippetSource ~/.vim/snippets/ruby.rails.migrate.snip
    autocmd BufEnter,BufRead,BufNew app/config/routes.rb NeoSnippetSource ~/.vim/snippets/ruby.rails.route.snip
    autocmd BufEnter,BufRead,BufNew spec/**/*.rb         NeoSnippetSource ~/.vim/snippets/ruby.rails.rspec.snip
augroup END

