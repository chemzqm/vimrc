" html & xml {{
  let g:html_indent_inctags = "html,body,head,tbody"
  let g:html_indent_script1 = "inc"
  let g:html_indent_style1 = "inc"
  augroup html
    autocmd!
    autocmd FileType html setlocal nowrap
    autocmd FileType htm setlocal foldmethod=manual
    autocmd FileType html setlocal foldnestmax=1
    autocmd FileType html noremap <D-r> : g/\(<!--\)\\|\(-->\)/d<cr>
    autocmd FileType xml noremap <D-r> : g/\(<!--\)\\|\(-->\)/d<cr>
    let pandoc_pipeline  = "pandoc --from=html --to=markdown"
    let pandoc_pipeline .= " | pandoc --from=markdown --to=html"
    autocmd FileType html let &formatprg=pandoc_pipeline
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup end
" }}

" xml.vim {{
  let g:xml_use_xmtml = 0
" }}

" emmet {{
  " https://raw.github.com/mattn/emmet-vim/master/TUTORIAL
  " html:5
  " <c-c> Wrap with Abbreviation
  " <c-y>a Make anchor from URL
  " <c-y>A Make quoted text from URL
  let g:user_emmet_expandabbr_key = '<C-y>'
  let g:user_emmet_next_key = '<C-y>n'
  let g:user_emmet_prev_key = '<C-y>N'
  "注释
  let g:user_emmet_togglecomment_key = '<C-y>/'
  "内部全选
  let g:user_emmet_balancetaginward_key = '<C-y>i'
  let g:user_emmet_balancetagoutward_key = '<C-y>o'
  let g:user_emmet_mode='a'
  let g:user_emmet_settings = webapi#json#decode(
  \  join(readfile(expand('~/.vim/emmit.json')), "\n"))
" }}

