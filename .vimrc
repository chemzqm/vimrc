" vim: set sw=2 ts=2 sts=2 et tw=78;

set nocompatible
filetype off
if &shell =~# 'fish$'
  set shell=bash
endif
source ~/.vim/vimrc/bundles.vim
syntax enable
set rtp+=~/lib/powerline/powerline/bindings/vim

" Source all of the .vim files in ~/.vim/vimrc.d directory.
for file in split(glob('~/.vim/vimrc/*.vim'), '\n')
    exe 'source' file
endfor

iabbrev @G chemzqm@gmail.com
iabbrev @C Copyright 2015 Qiming Zhao, all rights reserved
iabbrev mocah mocha
