if !has('nvim') | finish | endif
set inccommand=nosplit

" speed up
let g:python_host_skip_check=1
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_skip_check=1
let g:python3_host_prog = '/usr/local/bin/python3'
let g:ruby_host_prog = exepath('neovim-ruby-host')
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <M-1> <C-\><C-n>1gt
tnoremap <M-2> <C-\><C-n>2gt
tnoremap <M-3> <C-\><C-n>3gt
tnoremap <M-4> <C-\><C-n>4gt
tnoremap <M-5> <C-\><C-n>5gt

" Neovim :terminal colors.
let g:terminal_color_0  = '#1b1d1e'
let g:terminal_color_1  = '#f92672'
let g:terminal_color_2  = '#a6e22e'
let g:terminal_color_3  = '#fd971f'
let g:terminal_color_4  = '#66d9ef'
let g:terminal_color_5  = '#9e6ffe'
let g:terminal_color_6  = '#5e7175'
let g:terminal_color_7  = '#ccccc6'
let g:terminal_color_8  = '#505354'
let g:terminal_color_9  = '#ff669d'
let g:terminal_color_10 = '#beed5f'
let g:terminal_color_11 = '#e6db74'
let g:terminal_color_12 = '#66d9ef'
let g:terminal_color_13 = '#9e6ffe'
let g:terminal_color_14 = '#a3babf'
let g:terminal_color_15 = '#f8f8f2'

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
