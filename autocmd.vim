augroup fileRead
  autocmd!
  autocmd BufReadPost *.log normal G
  autocmd BufWinEnter * call OnBufEnter()
augroup end

function! OnBufEnter()
  let name = bufname('%')
  " quickly leave those temporary buffers
  if &previewwindow || name =~# '^fugitive'
    \ || &filetype ==# 'help' || &buftype ==# 'nofile'
    nnoremap <buffer> q :<C-U>bdelete<CR>
    nnoremap <buffer> <esc> :<C-U>bdelete<CR>
  endif
  if name =~# '/tmp/'
    setl bufhidden=delete
  endif
  unlet name
endfunction
