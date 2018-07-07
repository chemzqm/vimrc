if !has('nvim') | finish | endif
set inccommand=nosplit

" speed up
let g:python_host_skip_check=1
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_skip_check=1
let g:python3_host_prog = '/usr/local/bin/python3'
let g:ruby_host_prog = exepath('neovim-ruby-host')
let g:node_host_prog = '/usr/local/lib/node_modules/neovim/bin/cli.js'

"tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <M-1> <C-\><C-n>1gt
tnoremap <M-2> <C-\><C-n>2gt
tnoremap <M-3> <C-\><C-n>3gt
tnoremap <M-4> <C-\><C-n>4gt
tnoremap <M-5> <C-\><C-n>5gt

" Neovim :terminal colors.
let g:terminal_color_0  = '#282828'
let g:terminal_color_8  = '#928374'
let g:terminal_color_1  = '#cc241d'
let g:terminal_color_9  = '#fb4934'
let g:terminal_color_2  = '#98971a'
let g:terminal_color_10 = '#b8bb26'
let g:terminal_color_3  = '#d79921'
let g:terminal_color_11 = '#fabd2f'
let g:terminal_color_4  = '#458588'
let g:terminal_color_12 = '#83a598'
let g:terminal_color_5  = '#b16286'
let g:terminal_color_13 = '#d3869b'
let g:terminal_color_6  = '#689d6a'
let g:terminal_color_14 = '#8ec07c'
let g:terminal_color_7  = '#a89984'
let g:terminal_color_15 = '#ebdbb2'

function! s:OnTermOpen(buf)
  setl nolist norelativenumber nonumber
  if &buftype ==# 'terminal'
    nnoremap <buffer> q :<C-U>bd!<CR>
  endif
endfunction

augroup neovim
  autocmd!
  autocmd TermOpen  *  :call s:OnTermOpen(+expand('<abuf>'))
augroup end
