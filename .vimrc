set nocompatible

filetype off
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let g:loaded_python_provider = 1
  let g:python_host_skip_check=1
  let g:python_host_prog = '/usr/local/bin/python'
  let g:python3_host_skip_check=1
  let g:python3_host_prog = '/usr/local/bin/python3'
endif
let g:gruvbox_italic=1
let g:jscheck_loaded = 1
let g:did_v2ex_plugin_loaded = 1
" developing plugins
let s:path = join(split(glob('~/vim-dev/*'), '\n'), ',')
exe 'set rtp^='.fnameescape(s:path)
set runtimepath^=~/.vim/bundle/plug.vim
call plug#begin()
if has('nvim')
  Plug 'neco-vim'
  Plug 'deoplete-ruby'
  Plug 'deoplete.nvim'
endif
Plug 'ultisnips', 1
"Plug 'yajs.vim'
Plug 'FastFold'
Plug 'dash.vim'
Plug 'emmet-vim'
Plug 'gist-vim'
Plug 'gundo.vim'
Plug 'html5.vim'
Plug 'janko-vim-test'
Plug 'neomake'
Plug 'tern_for_vim', 1
Plug 'unite.vim'
Plug 'unite-outline'
"Plug 'unite-tag'
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
Plug 'vim-stay'
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

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAbbrs('Co', 'Copy')
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
call SetupCommandAbbrs('U', 'Ultisnips')
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
