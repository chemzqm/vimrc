set nocompatible

let g:gruvbox_italic=1
set runtimepath^=~/.vim/bundle/plug.vim
call plug#begin()
"Plug 'FastFold'
"Plug 'vim-bundler'
"Plug 'yajs.vim'
"Plug 'neosnips', 1
"Plug 'vim-stay'
Plug 'vim-jsx-improve', 1
Plug 'comment.vim', 1
Plug 'easygit', 1
Plug 'macdown.vim', 1
Plug 'macnote.vim', 1
Plug 'redismru.vim', 1
Plug 'smartim', 1
Plug 'snippets', 1
Plug 'tern-neovim', 1
Plug 'todoapp.vim', 1
Plug 'ultisnips', 1
Plug 'unite-extra', 1
Plug 'unite-git-log', 1
Plug 'unite-js-func', 1
Plug 'unite-location', 1
Plug 'unite-session', 1
Plug 'vim-macos', 1
Plug 'vim-run', 1
Plug 'wxapp.vim', 1
Plug 'nvim-api-viewer'
Plug 'ale'
Plug 'vim-operator-user'
Plug 'vim-operator-flashy'
Plug 'vim-rails'
Plug 'gundo.vim'
Plug 'dash.vim'
Plug 'emmet-vim'
Plug 'gist-vim'
Plug 'html5.vim'
Plug 'unite.vim'
Plug 'unite-outline'
Plug 'unite-tag'
Plug 'vim-css-color'
Plug 'vim-easy-align'
Plug 'vim-exchange'
Plug 'vim-fish'
Plug 'vim-gitgutter'
Plug 'vim-go'
Plug 'vim-jsdoc'
Plug 'vim-json'
Plug 'vim-surround'
Plug 'vimproc'
Plug 'xml.vim'
Plug 'vim-sneak'
Plug 'denite.nvim'
Plug 'cpsm'
call plug#end()

filetype plugin indent on
syntax on

" vimrc files
for s:path in split(glob('~/.vim/vimrc/*.vim'), "\n")
  exe 'source ' . s:path
endfor

iabbrev mocah mocha
iabbrev Licence License
iabbrev accross across
iabbrev cosnt const

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAbbrs('Co', 'Copy')
call SetupCommandAbbrs('G', 'GundoToggle')
call SetupCommandAbbrs('Gd', 'Gdiff')
call SetupCommandAbbrs('Gt', 'GdiffThis')
call SetupCommandAbbrs('Gs', 'Gstatus')
call SetupCommandAbbrs('Gc', 'GcommitCurrent')
call SetupCommandAbbrs('Gp', 'Gpush')
call SetupCommandAbbrs('Gci', 'Gcommit -v')
call SetupCommandAbbrs('Gca', 'Gcommit -a -v')
call SetupCommandAbbrs('Gcaa', 'Gcommit --amend -a -v')
call SetupCommandAbbrs('Gco', 'Gcheckout')
call SetupCommandAbbrs('Grm', 'Gremove')
call SetupCommandAbbrs('Grh', 'Greset HEAD')
call SetupCommandAbbrs('Gmv', 'Gmove')
call SetupCommandAbbrs('L', 'Gitlog')
call SetupCommandAbbrs('U', 'UltiSnipsEdit')
call SetupCommandAbbrs('P', 'Publish')
call SetupCommandAbbrs('N', 'Note')
call SetupCommandAbbrs('T', 'tabe')
call SetupCommandAbbrs('D', 'Dict')
call SetupCommandAbbrs('R', 'Reset')
call SetupCommandAbbrs('M', 'Mdir')
call SetupCommandAbbrs('E', 'EditVimrc')
call SetupCommandAbbrs('S', 'SourceTest')
call SetupCommandAbbrs('A', 'TodoAdd')
call SetupCommandAbbrs('Ex', 'Execute')
call SetupCommandAbbrs('Ns', 'NoteSearch')
call SetupCommandAbbrs('Done', 'Unite todo:done')

" vim: set sw=2 ts=2 sts=2 et tw=78;
