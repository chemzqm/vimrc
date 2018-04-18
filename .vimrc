set nocompatible

" specified to speed up neovim
let $NVIM_RPLUGIN_MANIFEST = '~/.local/share/nvim/rplugin.vim'
let g:loaded_vimballPlugin = 1
let g:local = expand('~/vim-dev')
set runtimepath^=~/vim-dev/plug.nvim
call plug#begin()
"Plug 'lifepillar/vim-mucomplete'
Plug 'neoclide/npm.nvim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/keep.nvim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/vim-jsx-improve', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/tern-neovim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/redismru.vim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/mycomment.vim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/macdown.vim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/macnote.vim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/todoapp.vim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/ultisnips', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/denite-git', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/vim-easygit', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/denite-extra', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/smartim', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/snippets', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/vim-macos', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/vim-run', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/wxapp.vim', {'dir': g:local, 'frozen': 1}
Plug 'romainl/vim-cool' " search improve
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
Plug 'Shougo/denite.nvim', {'branch': 'me'}
Plug 'nixprime/cpsm'
Plug 'w0rp/ale'
Plug 'kana/vim-textobj-user'
Plug 'haya14busa/incsearch.vim'
"Plug 'posva/vim-vue'
Plug 'skywind3000/asyncrun.vim'
Plug 'keith/swift.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'prettier/vim-prettier', {'do': 'yarn install'}
Plug 'kopischke/vim-stay'
call plug#end()

filetype plugin indent on
syntax on

" vimrc files
for s:path in split(glob('~/.vim/vimrc/*.vim'), "\n")
  exe 'source ' . s:path
endfor
