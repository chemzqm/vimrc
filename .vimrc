" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=99:

" Environment {{
  set nocompatible
  filetype off
  if &shell =~# 'fish$'
    set shell=bash
  endif
  source ~/.vim/vimrc/bundles.vim
  syntax enable
  set rtp+=~/lib/powerline/powerline/bindings/vim
" }}

source ~/.vim/vimrc/general.vim
source ~/.vim/vimrc/remap.vim
source ~/.vim/vimrc/leadermap.vim
source ~/.vim/vimrc/autocmd.vim
source ~/.vim/vimrc/html.vim
source ~/.vim/vimrc/css.vim
source ~/.vim/vimrc/markdown.vim
source ~/.vim/vimrc/javascript.vim
source ~/.vim/vimrc/python.vim
source ~/.vim/vimrc/plugin.vim
source ~/.vim/vimrc/unite.vim
source ~/.vim/vimrc/command.vim

iabbrev @G chemzqm@gmail.com
iabbrev @C Copyright 2015 Qiming Zhao, all rights reserved
iabbrev mocah mocha
