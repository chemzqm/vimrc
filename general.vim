set hidden " allow buffer switch without saving
set history=99
set wildmenu
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set backspace=2
set autowrite
set hlsearch
set incsearch
set smartcase
set autoread
let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936
set mousehide
set nowb
set noswapfile
set nobackup
set undodir=~/.undodir
set undofile
set fileformats=unix,dos
set diffopt=vertical
set sessionoptions+=winpos
set sessionoptions-=help
set sessionoptions-=blank
set complete+=k
set ttimeoutlen=100
set tabpagemax=5
set scrolloff=3
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set wildignore+=*.so,*~,*/.git/*,*/.svn/*,*/.DS_Store
set showtabline=1
set omnifunc=syntaxcomplete#Complete

if has('statusline')
  set laststatus=2
  "as we use powerline
  set noshowmode
endif

if has('gui_running')
  "set noimd
  set background=light
  set guifont=Source\ Code\ Pro:h13
  set transparency=10
  set macmeta
  set antialias
  set number
  colorscheme solarized
  set relativenumber
else
  let g:solarized_termcolors=256
  set background=dark
  colorscheme solarized
endif

" Formatting
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround
set autoindent "Auto indent
set smartindent
set wrap "Wrap lines
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
  let g:grep_using_git = 0
elseif executable('grepprg')
  set grepprg=grepprg\ $*
  set grepformat=%f:%l:%c:%m
  let g:grep_using_git = 1
endif

if has('autocmd') && exists('+omnifunc')
  autocmd Filetype *
    \if &omnifunc == "" |
    \setlocal omnifunc=syntaxcomplete#Complete |
    \endif
endif
set completeopt=menu,preview
" improve performance
syntax sync minlines=200

hi Pmenu  guifg=#333333 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" change default search highlight
hi Search guibg=#333333 guifg=#C5B569

set completefunc=SnipComplete
function! SnipComplete(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~# '\a'
      let start -= 1
    endwhile
    return start
  else
    let suggestions = []
    for item in UltiSnips#SnippetsInCurrentScope()
      let trigger = item[0]
      if trigger =~ '^' . a:base
        let menu = fnamemodify(item[2], ':t:r')
        let entry = {'word': trigger, 'menu': menu, 'info': item[1]}
        call add(suggestions, entry)
      endif
    endfor
    return suggestions
  endif
endfunction
