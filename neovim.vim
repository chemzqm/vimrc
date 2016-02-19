if !has('nvim') | finish | endif
tnoremap <Esc> <C-\><C-n>
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
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
  if lines[-1] ==# '[Process exited 0]'
    execute 'silent！ bd! ' . nr
  endif
endfunction

augroup neovim
  autocmd!
  autocmd TermClose * :call s:OnTermClose(+expand('<abuf>'))
augroup end
