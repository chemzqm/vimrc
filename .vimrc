filetype off

function! RebaseToMe(info)
  if a:info.status ==# 'updated' || a:info.force
    !git checkout me
    !git rebase origin/master
  endif
endfunction

call plug#begin('~/.vim/bundle')
Plug 'mjbrownie/browser.vim'
Plug 'tomasr/molokai'
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/vimproc', {'do': 'yes \| make'}
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'ap/vim-css-color'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'heavenshell/vim-jsdoc'
Plug 'janko-m/vim-test'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'othree/xml.vim'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-surround'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-session'
Plug 'xolox/vim-shell'
Plug 'Konfekt/FastFold'
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'dag/vim-fish', {'do': function('RebaseToMe')}
Plug 'rizzatti/dash.vim', {'do': function('RebaseToMe')}
Plug 'othree/html5.vim', {'do': function('RebaseToMe')}
Plug 'SirVer/ultisnips', {'do': function('RebaseToMe')}
Plug 'Shougo/unite.vim', {'do': function('RebaseToMe')}
Plug 'scrooloose/syntastic', {'do': function('RebaseToMe')}
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}
Plug 'marijnh/tern_for_vim', {
      \'do': 'yes \| npm update --upgradeAll',
      \'for': 'javascript'
      \}
" developing plugins
let s:dev_plugins = ['comment.vim', 'snippets', 'unite-js-func',
      \'vim-run', 'easygit', 'unite-extra', 'unite-location',
      \'vim-v2ex', 'jscheck', 'unite-git-log', 'vim-iterm2-start',
      \]
for s:name in s:dev_plugins
  exe "Plug '" . expand('~') . "/vim-dev/" . s:name . "'"
endfor
call plug#end()

filetype plugin indent on
syntax enable

for file in split(glob('~/.vim/vimrc/*.vim'), '\n')
  exe 'source' file
endfor

iabbrev @G chemzqm@gmail.com
iabbrev @C Copyright 2015 Qiming Zhao, all rights reserved
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
call SetupCommandAbbrs('Gs', 'Gedit')
call SetupCommandAbbrs('Gc', 'GcommitCurrent')
call SetupCommandAbbrs('Gci', 'Gcommit -v')
call SetupCommandAbbrs('Gst', 'Gstatus')
call SetupCommandAbbrs('Gca', 'Gcommit -a -v')
call SetupCommandAbbrs('Gco', 'Gcheckout')
call SetupCommandAbbrs('Grm', 'Gremove')
call SetupCommandAbbrs('Gmv', 'Gmove')
call SetupCommandAbbrs('Gp', 'Gpush')
call SetupCommandAbbrs('U', 'Update')
call SetupCommandAbbrs('P', 'Publish')
call SetupCommandAbbrs('N', 'Note')
call SetupCommandAbbrs('T', 'tabe')
call SetupCommandAbbrs('R', 'Reset')
call SetupCommandAbbrs('H', 'ModuleHelp')

" vim: set sw=2 ts=2 sts=2 et tw=78;
