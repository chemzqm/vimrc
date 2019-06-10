" General options {{
set termguicolors
set hidden " allow buffer switch without saving
set history=2000
set pumheight=15
set wildmenu
set signcolumn=yes
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set backspace=2
set autowrite
set autoread
set hlsearch
set incsearch
set regexpengine=2
set fileencodings=utf-8,gbk,ucs-bom,cp936
set mousehide
set mousemodel=popup
set mouse=a
set novisualbell
set nobackup
set nowritebackup
set noimdisable
set noswapfile
set undofile
set undodir=~/.undodir
set fileformats=unix,dos
set display+=lastline
set formatoptions+=j
set formatoptions+=o
set diffopt=vertical
set path+=**
set tags+=gems.tags,stdlib.tags
set showbreak=↪ 
set shortmess=aFc
set cmdheight=2
set sessionoptions+=winsize
set sessionoptions+=resize
set sessionoptions-=blank
set sessionoptions+=localoptions
set sessionoptions+=globals
set viewoptions=cursor,folds,slash,unix
set ttimeout
set ttimeoutlen=100
set tabpagemax=10
set scrolloff=3
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set wildignore+=*.so,*~,*/.git/*,*/.svn/*,*/.DS_Store,*/tmp/*
set keywordprg=
set showtabline=2
set laststatus=2
set noshowmode
set updatetime=300
set synmaxcol=300
" Formatting
set smarttab
set smartcase
set shiftwidth=2
set expandtab
set shiftround
set autoindent
set wrap
set guioptions-=r
set number
set relativenumber
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
set title
set wildignorecase
set noruler
" }}

" Special options for macvim {{
if has('gui_running')
  colorscheme solarized
  set guifont=Source\ Code\ Pro:h14
  set background=light
  set transparency=10
  set macmeta
  " better font render on Retina screen
  set antialias
else
  set background=dark
  let g:gruvbox_bold=0
  let g:gruvbox_invert_selection=0
  colorscheme gruvbox
endif
" }}

" Complete config {{
set complete+=k
set complete-=t
"set completeopt=noinsert,noselect,menuone
set completeopt=menu,preview

if !has('nvim')
  set balloonevalterm
  set ballooneval
  " cursor shape of vim
  "let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  "let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  "let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  " make <M-s> for saving
  execute "set <M-s>=\es"
  execute "set <M-c>=\ec"
else
  set fillchars+=msgsep:-
endif
" }}
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
