if !has('nvim') | finish | endif
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
hi normal guibg=NONE

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
  autocmd InsertEnter *
       \ if get(b:, 'imd', 0)|
       \   call macos#keycodes('shift')|
       \ endif
  autocmd InsertLeave *
       \ if get(b:, 'imd', 0)|
       \   call macos#keycodes('shift')|
       \ endif
  autocmd TermClose * :call s:OnTermClose(+expand('<abuf>'))
  autocmd TermOpen *  :call s:OnTermOpen(+expand('<abuf>'))
  autocmd WinEnter term://*
        \ if getbufvar(expand('<abuf>'), 'is_autorun') != 1 |
        \   startinsert |
        \ endif
augroup end
