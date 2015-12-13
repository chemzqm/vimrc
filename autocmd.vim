" TODO move fish related to fish.vim
augroup fileRead
  autocmd!
  autocmd FileType fish setl noexpandtab
  autocmd FileType fish setl softtabstop=0
  autocmd BufNewFile,BufRead /tmp/fish_* set filetype=fish
  autocmd BufNewFile,BufRead /tmp/mutt-* set filetype=markdown
  autocmd BufReadPost *.log normal G
  autocmd BufRead,BufNewFile /usr/local/etc/nginx/* setfiletype nginx
  autocmd BufRead,BufNewFile /etc/nginx/*,/usr/local/etc/nginx/* setfiletype nginx
  autocmd BufEnter * call OnBufEnter()
augroup end

function! OnBufEnter()
  let name = bufname('%')
  " quickly leave those template buffers
  if &previewwindow || name =~# '^fugitive' || &filetype ==# 'help'
    nnoremap <buffer> q :<C-U>bdelete<CR>
    nnoremap <buffer> <esc> :<C-U>bdelete<CR>
  endif
  if !did_filetype()
    if getline(1) =~# '^#!.*bin/fish\>'
      setfiletype fish
    endif
  endif
  if bufname('%') =~# '/tmp/'
    setl bufhidden=delete
  endif
endfunction
