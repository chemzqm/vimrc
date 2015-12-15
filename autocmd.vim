augroup fileRead
  autocmd!
  autocmd BufNewFile,BufRead /private/tmp/fish_* set filetype=fish
  autocmd BufNewFile,BufRead /tmp/mutt-* set filetype=markdown
  autocmd BufReadPost *.log normal G
  autocmd BufRead,BufNewFile /usr/local/etc/nginx/* setfiletype nginx
  autocmd BufRead,BufNewFile /etc/nginx/*,/usr/local/etc/nginx/* setfiletype nginx
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
