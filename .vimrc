" vim: set sw=2 ts=2 sts=2 et tw=78;

filetype off
if &shell =~# 'fish$'
  set shell=bash
endif
set runtimepath+=/Users/chemzqm/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('/Users/chemzqm/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', {'build': { 'mac' : 'make' }}
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'ap/vim-css-color'
NeoBundle 'dag/vim-fish', '825853f'
NeoBundle 'elzr/vim-json'
NeoBundle 'fatih/vim-go'
NeoBundle 'heavenshell/vim-jsdoc'
NeoBundle 'janko-m/vim-test'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'moll/vim-bbye'
NeoBundle 'bling/vim-airline'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'tommcdo/vim-exchange'
NeoBundle 'tpope/vim-surround'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-notes'
NeoBundle 'xolox/vim-session'
NeoBundle 'xolox/vim-shell'
call neobundle#end()
" developed plugins
for path in split(glob('~/vim-dev/*'), '\n')
  if path !~# 'fugitive'
    exe 'set rtp+=' . path
  endif
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
