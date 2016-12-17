if !has('nvim') | finish | endif
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let g:python_host_skip_check=1
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_skip_check=1
let g:python3_host_prog = '/usr/local/bin/python3'
let g:loaded_ruby_provider = 1
set termguicolors

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
  if &buftype ==# 'terminal'
    nnoremap <buffer> q :<C-U>bd!<CR>
  endif
endfunction

function! s:OnTermClose(buf)

  function! Callback(nr, id)
    let lines = filter(getbufline(a:nr, 1, '$'), '!empty(v:val)')
    if empty(lines) || lines[-1] ==# '[Process exited 0]'
      if bufexists(a:nr)
        execute 'silent! bd! ' . a:nr
      endif
    endif
  endfunction

  if getbufvar(a:buf, '&buftype') ==# 'terminal'
    call timer_start(100, function('Callback', [a:buf]))
  endif
endfunction

augroup neovim
  autocmd!
  autocmd TermOpen  *  setlocal nolist
  autocmd TermClose *  :call s:OnTermClose(+expand('<abuf>'))
  autocmd TermOpen  *  :call s:OnTermOpen(+expand('<abuf>'))
  autocmd WinEnter term://*
        \ if getbufvar(expand('<abuf>'), 'is_autorun') != 1 |
        \   startinsert |
        \ endif
augroup end
