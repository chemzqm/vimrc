set nocompatible

" specified to speed up neovim
let $NVIM_RPLUGIN_MANIFEST = '~/.local/share/nvim/rplugin.vim'
let g:loaded_vimballPlugin = 1
let g:local = expand('~/vim-dev')
set runtimepath^=~/vim-dev/plug.nvim
call plug#begin()
"Plug 'FastFold'
"Plug 'vim-bundler'
"Plug 'yajs.vim'
"Plug 'neosnips', 1
"Plug 'vim-stay'
"Plug 'vim-javascript'
"Plug 'vim-jsx'
"Plug 'vim-jsx-pretty'
"Plug 'scrooloose/nerdtree'
"Plug 'chemzqm/unite-location', {'dir': g:local, 'frozen': 1}
"Plug 'tpope/vim-fugitive'
"Plug 'Shougo/unite.vim'
Plug 'chemzqm/keep.nvim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/vim-jsx-improve', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/tern-neovim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/redismru.vim', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/mycomment.vim', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/macdown.vim', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/macnote.vim', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/smartim', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/snippets', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/todoapp.vim', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/ultisnips', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/vim-macos', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/vim-run', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/wxapp.vim', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/denite-git', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/vim-easygit', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/denite-extra', {'dir': g:local, 'frozen': 1}
Plug 'Shougo/deoplete.nvim'
Plug 'mitsuse/autocomplete-swift'
Plug 'davidhalter/jedi-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'Shougo/echodoc.vim'
Plug 'tweekmonster/nvim-api-viewer'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-rails'
Plug 'sjl/gundo.vim'
Plug 'othree/csscomplete.vim'
Plug 'rizzatti/dash.vim'
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
Plug 'ap/vim-css-color'
Plug 'junegunn/vim-easy-align'
Plug 'tommcdo/vim-exchange'
Plug 'dag/vim-fish'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'
Plug 'heavenshell/vim-jsdoc'
Plug 'elzr/vim-json'
Plug 'tpope/vim-surround'
Plug 'othree/xml.vim'
Plug 'justinmk/vim-sneak'
Plug 'Shougo/denite.nvim'
Plug 'nixprime/cpsm'
Plug 'w0rp/ale'
Plug 'kana/vim-textobj-user'
Plug 'haya14busa/incsearch.vim'
Plug 'posva/vim-vue'
Plug 'keith/swift.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'prettier/vim-prettier'
Plug 'cohama/lexima.vim'
call plug#end()

filetype plugin indent on
syntax on

" vimrc files
for s:path in split(glob('~/.vim/vimrc/*.vim'), "\n")
  exe 'source ' . s:path
endfor
