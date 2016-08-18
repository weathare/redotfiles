if &compatible
  set nocompatible
endif

let s:dein_dir      = expand('$XDG_CONFIG_HOME/dein')
let s:dein_repo_dir = expand(s:dein_dir . '/repos/github.com/Shougo/dein.vim')
let s:rc_dir        = expand('$XDG_CONFIG_HOME/nvim/rc')
let $CACHE          = expand('$XDG_CONFIG_HOME/cache')

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if !isdirectory($CACHE)
  call mkdir(expand($CACHE), 'p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml      = s:rc_dir . '/dein.toml'
  let s:toml_lazy = s:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,       {'lazy': 0})
  call dein#load_toml(s:toml_lazy,  {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" 未インストールがあればインストール
if dein#check_install()
  call dein#install()
endif

augroup MyAutoCmd
  autocmd!
augroup END


if has('vim_starting')
  let g:pymode_python = 'python3'

  call dein#call_hook('source')
  call dein#call_hook('post_source')

  syntax on
  filetype plugin indent on

  colorscheme iceberg
endif


execute 'source $XDG_CONFIG_HOME/nvim/rc/unset.rc.vim'
execute 'source $XDG_CONFIG_HOME/nvim/rc/encoding.rc.vim'
execute 'source $XDG_CONFIG_HOME/nvim/rc/edit.rc.vim'
execute 'source $XDG_CONFIG_HOME/nvim/rc/view.rc.vim'
execute 'source $XDG_CONFIG_HOME/nvim/rc/keymap.rc.vim'

