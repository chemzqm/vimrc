" vim: set sw=2 ts=2 sts=2 et tw=78;

filetype off
if &shell =~# 'fish$'
  set shell=bash
endif

" plugin from github
for path in split(glob('~/.vim/bundle/*'), '\n')
  exe 'set rtp+=' . path
endfor

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
