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
let g:terminal_color_0  = '#080200'
let g:terminal_color_1  = '#e44329'
let g:terminal_color_2  = '#00ad64'
let g:terminal_color_3  = '#fded00'
let g:terminal_color_4  = '#00b0e9'
let g:terminal_color_5  = '#b180a4'
let g:terminal_color_6  = '#c0e9f6'
let g:terminal_color_7  = '#b4b1b1'
let g:terminal_color_8  = '#6f6b67'
let g:terminal_color_9  = '#edc8d8'
let g:terminal_color_10 = '#4a4341'
let g:terminal_color_11 = '#5c5654'
let g:terminal_color_12 = '#928f8e'
let g:terminal_color_13 = '#dddddc'
let g:terminal_color_14 = '#d6b765'
let g:terminal_color_15 = '#f8f8f8'

function! s:OnTermOpen(buf)
  setlocal nolist
  if &buftype ==# 'terminal'
    nnoremap <buffer> q :<C-U>bd!<CR>
  endif
endfunction

augroup neovim
  autocmd!
  autocmd TermOpen  *  :call s:OnTermOpen(+expand('<abuf>'))
augroup end
