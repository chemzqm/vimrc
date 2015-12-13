" python {{
  let python_highlight_all = 1
  augroup python
    autocmd!
    autocmd BufNewFile,BufRead *.jinja set syntax=htmljinja
    autocmd BufNewFile,BufRead *.mako set ft=mako
    autocmd FileType python set omnifunc=pythoncomplete#Complete
  augroup end
" }}

