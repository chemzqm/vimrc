" vim: set sw=2 ts=2 sts=2 et tw=78;

filetype off
if &shell =~# 'fish$'
  set shell=bash
endif

" Do nothing plugin manager
command! -nargs=1 Plugin call s:bundle(<args>)

function! s:bundle(name)
  exe 'set rtp+=~/.vim/bundle/' . a:name
endfunction

if !exists('g:bundles_loaded')
  Plugin 'dash.vim'
  Plugin 'xml.vim'
  Plugin 'emmet-vim'
  Plugin 'gist-vim'
  Plugin 'gundo.vim'
  Plugin 'neomru.vim'
  Plugin 'neoyank.vim'
  Plugin 'syntastic'
  Plugin 'ultisnips'
  Plugin 'unite-outline'
  Plugin 'unite.vim'
  Plugin 'vim-easy-align'
  Plugin 'vim-easymotion'
  Plugin 'vim-colors-solarized'
  Plugin 'vim-exchange'
  Plugin 'vim-fish'
  Plugin 'vim-gitgutter'
  Plugin 'vim-go'
  Plugin 'vim-jsdoc'
  Plugin 'vim-json'
  Plugin 'vim-notes'
  Plugin 'vim-misc'
  Plugin 'vim-session'
  Plugin 'vim-shell'
  Plugin 'vim-surround'
  Plugin 'vim-test'
  Plugin 'vimproc'
  Plugin 'webapi-vim'
  Plugin 'tern_for_vim'
  Plugin 'vim-css-color'
endif
let g:bundles_loaded = 1

" developing plugins
for path in split(glob('~/vim-dev/*'), '\n')
  exe 'set rtp+=' . path
endfor
filetype plugin indent on
syntax enable
" config files
for file in split(glob('~/.vim/vimrc/*.vim'), '\n')
  exe 'source' file
endfor

iabbrev @G chemzqm@gmail.com
iabbrev @C Copyright 2015 Qiming Zhao, all rights reserved
iabbrev mocah mocha
iabbrev fi if

function! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAlias('C', 'Glcd')
call SetupCommandAlias('Gd', 'Gdiff')
call SetupCommandAlias('Gt', 'GdiffThis')
call SetupCommandAlias('Gs', 'Gedit')
call SetupCommandAlias('Gc', 'GcommitCurrent')
call SetupCommandAlias('Gca', 'GcommitAll')
call SetupCommandAlias('Gco', 'Gcheckout')
call SetupCommandAlias('Gp', 'Gpush')
call SetupCommandAlias('U', 'Update')
call SetupCommandAlias('P', 'Publish')
call SetupCommandAlias('N', 'Note')

cnoreabbrev -a --amend
