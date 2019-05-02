set nocompatible
" specified to speed up neovim
let $NVIM_RPLUGIN_MANIFEST = '~/.local/share/nvim/rplugin.vim'
let g:local = expand('~/vim-dev')
set runtimepath^=~/vim-dev/plug.nvim
call plug#begin()
if has('nvim')
  Plug 'neoclide/rename.nvim', {'dir': g:local, 'frozen': 1}
endif
Plug 'neoclide/coc.nvim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/coc-neco', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/coc-git', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/coc-imselect', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/mycomment.vim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/vim-easygit', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/vim-jsx-improve', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/macdown.vim', {'dir': g:local, 'frozen': 1}
Plug 'neoclide/macnote.vim', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/vim-macos', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/vim-run', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/wxapp.vim', {'dir': g:local, 'frozen': 1}
Plug 'chemzqm/jsonc.vim', {'dir': g:local, 'frozen': 1}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown'
Plug 'dhruvasagar/vim-zoom'
Plug 'tpope/vim-rhubarb'
Plug 'romainl/vim-cool' " search improve
Plug 'mbbill/undotree'
Plug 'rizzatti/dash.vim'
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale', {'branch': 'me'}
Plug 'whiteinge/diffconflicts'
Plug 'tommcdo/vim-exchange'
Plug 'dag/vim-fish'
Plug 'fatih/vim-go'
Plug 'heavenshell/vim-jsdoc'
Plug 'elzr/vim-json'
Plug 'othree/xml.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'kana/vim-textobj-user'
Plug 'tommcdo/vim-lion'
Plug 'keith/swift.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'
Plug 'Shougo/neco-vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'posva/vim-vue'
Plug 'dart-lang/dart-vim-plugin'
Plug 'tweekmonster/helpful.vim'
Plug 'lervag/vimtex'
Plug 'derekwyatt/vim-scala'
Plug 'voldikss/vim-translate-me'
"Plug 'airblade/vim-gitgutter'
"Plug 'honza/vim-snippets'
"Plug 'scrooloose/nerdtree'
"Plug 'jparise/vim-graphql'
"Plug 'neoclide/todoapp.vim', {'dir': g:local, 'frozen': 1}
"Plug 'liuchengxu/vista.vim'
"Plug 'easymotion/vim-easymotion'
"Plug 'SirVer/ultisnips'
"Plug 'tpope/vim-rails'
"Plug 'tpope/vim-projectionist'
"Plug 'itchyny/lightline.vim'
"Plug 'machakann/vim-highlightedyank'
"Plug 'neoclide/denite-git', {'dir': g:local, 'frozen': 1}
"Plug 'Shougo/denite.nvim', {'branch': 'me'}
"Plug 'neoclide/denite-extra', {'dir': g:local, 'frozen': 1}
"Plug 'Shougo/echodoc'
"Plug 'easymotion/vim-easymotion'
"Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'mitsuse/autocomplete-swift'
call plug#end()
syntax on
" vimrc files
for s:path in split(glob('~/.vim/vimrc/*.vim'), "\n")
  exe 'source ' . s:path
endfor
