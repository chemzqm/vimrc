" markdown {{
  augroup markdown
    autocmd!
    autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^#\\+\r:nohlsearch\rwvg_"<cr>
  augroup end
" }}

let g:vim_markdown_folding_disabled=1
