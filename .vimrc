set nocompatible
filetype off
if &shell =~# 'fish$'
  set shell=sh
endif

" developing plugins
let s:path = join(split(glob('~/vim-dev/*'), '\n'), ',')
exe "set rtp^=".fnameescape(s:path)
set rtp^=~/.vim/bundle/plug.vim
call plug#begin()
Plug 'FastFold'
Plug 'dash.vim'
Plug 'emmet-vim'
Plug 'gist-vim'
Plug 'gundo.vim'
Plug 'html5.vim'
Plug 'janko-vim-test'
Plug 'neomru.vim'
Plug 'syntastic'
Plug 'tern_for_vim', 1
Plug 'unite-outline'
Plug 'unite.vim'
Plug 'vim-colors-solarized'
Plug 'vim-css-color', 1
Plug 'vim-easy-align'
Plug 'vim-exchange'
Plug 'vim-fish'
Plug 'vim-gitgutter'
Plug 'vim-go'
Plug 'vim-jsdoc'
Plug 'vim-json'
Plug 'vim-surround'
Plug 'vimproc'
Plug 'webapi-vim'
Plug 'xml.vim'
Plug 'vim-sneak'
Plug 'ultisnips', 1
"Plugin 'kopischke/vim-stay'
call plug#end()

filetype plugin indent on
syntax on

" vimrc files
for path in split(glob('~/.vim/vimrc/*.vim'), "\n")
  exe 'source ' . path
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
call SetupCommandAbbrs('Co', 'Copy')
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
