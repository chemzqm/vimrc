function! RebaseToMe(info)
  if a:info.status ==# 'updated' || a:info.force
    !git checkout me
    !git rebase origin/master
  endif
endfunction

call plug#begin('~/.vim/bundle')
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/vimproc', {'do': 'yes \| make'}
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
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
Plug 'xolox/vim-shell'
Plug 'Konfekt/FastFold'
Plug 'kopischke/vim-stay'
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'ap/vim-css-color', {'do': function('RebaseToMe')}
Plug 'dag/vim-fish', {'do': function('RebaseToMe')}
Plug 'xolox/vim-notes', {'do': function('RebaseToMe')}
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
  \'vim-macos', 'unite-session']

for s:name in s:dev_plugins
  exe "Plug '" . expand('~') . "/vim-dev/" . s:name . "'"
endfor
call plug#end()

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
call SetupCommandAbbrs('R', 'Reset')
call SetupCommandAbbrs('H', 'ModuleHelp')
call SetupCommandAbbrs('E', 'EditVimrc')
call SetupCommandAbbrs('S', 'UniteSessionSave')
call SetupCommandAbbrs('St', 'SourceTest')

" vim: set sw=2 ts=2 sts=2 et tw=78;
