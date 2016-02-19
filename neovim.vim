if !has('nvim') | finish | endif
tnoremap <Esc> <C-\><C-n>
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
hi normal guibg=NONE

function! EasygitCommitCallback()
  call jobstart('sleep 0.1', {
    \ 'on_exit': function('s:CommitCallback')
    \})
endfunction

function! s:CommitCallback(job_id, status)
  if a:status == 0
    let g:c = 1
    call SetStatusLine()
  endif
endfunction