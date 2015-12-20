" vim: set sw=2 ts=2 sts=2 et tw=78;

filetype off
if &shell =~# 'fish$'
  set shell=bash
endif
set runtimepath+=/Users/chemzqm/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('/Users/chemzqm/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', {'build': { 'mac' : 'make' }}
NeoBundle 'Shougo/unite-outline'
NeoBundle 'chemzqm/jscheck'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'dag/vim-fish', '825853f'
NeoBundle 'dyng/ctrlsf.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'ajh17/VimCompletesMe'
NeoBundle 'empanda/vim-varnish'
NeoBundle 'fatih/vim-go'
NeoBundle 'godlygeek/tabular'
NeoBundle 'heavenshell/vim-jsdoc'
NeoBundle 'honza/vim-snippets'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'janko-m/vim-test'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'junegunn/vim-emoji'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'othree/xml.vim'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'rizzatti/funcoo.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'tommcdo/vim-exchange'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'ap/vim-css-color'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-notes'
NeoBundle 'xolox/vim-session'
NeoBundle 'xolox/vim-shell'
NeoBundle 'moll/vim-bbye'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'junegunn/fzf'
NeoBundle 'henrik/vim-qargs'
"NeoBundle 'scrooloose/nerdcommenter'
"NeoBundle 'Shougo/vimfiler.vim'
"NeoBundle 'majutsushi/tagbar'
"NeoBundle 'tsukkee/unite-tag'
"NeoBundle 'cakebaker/scss-syntax.vim'
"NeoBundle 'pangloss/vim-javascript'
"NeoBundle 'xhr/vim-io'
call neobundle#end()
set rtp+=~/vim-dev/unite-location
filetype plugin indent on
syntax enable
set rtp+=~/lib/powerline/powerline/bindings/vim

set wildignore+=*/tmp/*,*.so,*~,*.zip,*/.git/*,*/.svn/*,node_modules,*/.DS_Store,coverage,*/*bundle.js,*.map
" Source all of the .vim files in ~/.vim/vimrc.d directory.
for file in split(glob('~/.vim/vimrc/*.vim'), '\n')
   exe 'source' file
endfor

iabbrev @G chemzqm@gmail.com
iabbrev @C Copyright 2015 Qiming Zhao, all rights reserved
iabbrev mocah mocha
iabbrev fi if
