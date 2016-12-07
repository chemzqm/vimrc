if !has('nvim') | finish | endif
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let g:python_host_skip_check=1
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_skip_check=1
let g:python3_host_prog = '/usr/local/bin/python3'
let g:loaded_ruby_provider = 1
set termguicolors
if !exists('g:nyaovim_version')
  hi normal guibg=NONE
endif

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

" need this hack to reset statusline
function! EasygitCommitCallback()
  call jobstart('sleep 0.1', {
    \ 'on_exit': function('s:CommitCallback')
    \})
endfunction

function! s:CommitCallback(job_id, status) dict
  if a:status == 0
    call SetStatusLine()
  endif
endfunction

function! s:OnTermOpen(buf)
  if &buftype ==# 'terminal'
    nnoremap <buffer> q :<C-U>bd!<CR>
  endif
endfunction

function! s:OnTermClose(buf)
  if getbufvar(a:buf, '&buftype') ==# 'terminal'
    call jobstart('sleep 0.1', {
      \ 'buffer_nr': a:buf,
      \ 'on_exit': function('s:TerminalCallback'),
      \})
  endif
endfunction

function! s:TerminalCallback() dict
  let nr = self.buffer_nr
  let lines = filter(getbufline(nr, 1, '$'), '!empty(v:val)')
  if empty(lines) | return | endif
  if lines[-1] ==# '[Process exited 0]'
    execute 'bd! ' . nr
  endif
endfunction

augroup neovim
  autocmd!
  autocmd TermClose * :call s:OnTermClose(+expand('<abuf>'))
  autocmd TermOpen *  :call s:OnTermOpen(+expand('<abuf>'))
  autocmd WinEnter term://*
        \ if getbufvar(expand('<abuf>'), 'is_autorun') != 1 |
        \   startinsert |
        \ endif
augroup end
