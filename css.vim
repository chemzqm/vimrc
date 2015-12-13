augroup css
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType css inoremap <buffer> { {<CR>}<C-o>O
augroup end
