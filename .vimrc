set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'justinmk/vim-sneak'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/unite-outline'
Plugin 'Shougo/vimproc'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/vim-go'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'janko-m/vim-test'
Plugin 'junegunn/vim-easy-align'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'othree/xml.vim'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-surround'
Plugin 'Konfekt/FastFold'
"Plugin 'kopischke/vim-stay'
Plugin 'elzr/vim-json'
Plugin 'ap/vim-css-color'
Plugin 'dag/vim-fish'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'rizzatti/dash.vim'
Plugin 'othree/html5.vim'
Plugin 'SirVer/ultisnips'
Plugin 'Shougo/unite.vim'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'marijnh/tern_for_vim'
call vundle#end()

" developing plugins
for s:path in split(glob('~/vim-dev/*'), '\n')
  exe "set rtp+=" . s:path
endfor
filetype plugin indent on
syntax on

let s:names = ["general", "remap", "autocmd", "leadermap"
  \, "command", "plugin", "statusline", "unite"]
let s:base = expand('~') . '/.vim/vimrc/'
for s:name in s:names
  exe 'source ' . s:base . s:name . '.vim'
endfor

iabbrev @G chemzqm@gmail.com
iabbrev @C Copyright 2016 Qiming Zhao, all rights reserved
iabbrev mocah mocha
iabbrev fi if

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAbbrs('C', 'Glcd')
call SetupCommandAbbrs('Gd', 'Gdiff')
call SetupCommandAbbrs('Gt', 'GdiffThis')
call SetupCommandAbbrs('Gs', 'Gstatus')
call SetupCommandAbbrs('Gc', 'GcommitCurrent')
call SetupCommandAbbrs('Gci', 'Gcommit -v')
call SetupCommandAbbrs('Gca', 'Gcommit -a -v')
call SetupCommandAbbrs('Gcaa', 'Gcommit --amend -a -v')
call SetupCommandAbbrs('Gco', 'Gcheckout')
call SetupCommandAbbrs('Grm', 'Gremove')
call SetupCommandAbbrs('Gmv', 'Gmove')
call SetupCommandAbbrs('Gp', 'Gpush')
call SetupCommandAbbrs('L', 'Gitlog')
call SetupCommandAbbrs('U', 'Update')
call SetupCommandAbbrs('P', 'Publish')
call SetupCommandAbbrs('N', 'Note')
call SetupCommandAbbrs('Ns', 'NoteSearch')
call SetupCommandAbbrs('T', 'tabe')
call SetupCommandAbbrs('D', 'Dash')
call SetupCommandAbbrs('R', 'Reset')
call SetupCommandAbbrs('M', 'Mdir')
call SetupCommandAbbrs('H', 'ModuleHelp')
call SetupCommandAbbrs('E', 'EditVimrc')
call SetupCommandAbbrs('S', 'SourceTest')

" vim: set sw=2 ts=2 sts=2 et tw=78;
