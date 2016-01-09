" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker:

" Visual shifting (does not exit Visual mode)
nnoremap Q <Nop>
vnoremap < <gv
vnoremap > >gv
nnoremap Y y$
nnoremap <M-l> <c-w>l
nnoremap <M-h> <c-w>h
nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k
" clear highhigh reset diff
nnoremap <silent> <c-l> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>
nnoremap <D-d> :bdelete!<cr>
nnoremap gca :Gcommit -a -v<CR>
nnoremap gcc :Gcommit -v -- <C-R>=expand('%')<CR><CR>
nnoremap gp  :Gpush<CR>

"inoremap <C-u> <esc>:Unite -buffer-name=ultisnips ultisnips<cr>
inoremap <D-u> <esc>mzgUiw`za
" like emacs
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-U> <C-G>u<C-U>
" yank to end
" easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" fix section movemont {{
noremap <silent> [[ ?{<CR>w99[{
noremap <silent> ][ /}<CR>b99]}
noremap <silent> ]] j0[[%/{<CR>
noremap <silent> [] k$][%?}<CR>
" }}
" tabs {{
  noremap  <D-1>      1gt
  noremap  <D-2>      2gt
  noremap  <D-3>      3gt
  noremap  <D-4>      4gt
  noremap  <D-5>      5gt
  inoremap <D-1> <C-o>1gt
  inoremap <D-2> <C-o>2gt
  inoremap <D-3> <C-o>3gt
  inoremap <D-4> <C-o>4gt
  inoremap <D-5> <C-o>5gt
" }}

" command line alias {{
  cnoremap w!! w !sudo tee % >/dev/null
  cnoremap $v ~/.vimrc
  cnoremap $h <C-R>=expand('%:p:h').'/'<cr>
" }}

" command line emacs shortcut, same as shell {{
  cmap <C-k> <Up>
  cmap <C-j> <Down>
  cmap <C-b> <Left>
  cmap <C-f> <Right>
  cmap <C-a> <Home>
  cmap <C-e> <End>
  cmap <C-d> <Del>
  cmap <C-h> <BS>
" }}

" visual search {{
  "  In visual mode when you press * or # to search for the current selection
  vnoremap    <silent> * :call <SID>visualSearch('f')<CR>
  vnoremap    <silent> # :call <SID>visualSearch('b')<CR>

  function!   s:visualSearch(direction)
    let       l:saved_reg = @"
    execute   'normal! vgvy'
    let       l:pattern = escape(@", '\\/.*$^~[]')
    let       l:pattern = substitute(l:pattern, "\n$", '', '')
    if        a:direction ==# 'b'
      execute 'normal! ?' . l:pattern . "\<cr>"
    elseif    a:direction ==# 'f'
      execute 'normal! /' . l:pattern . '^M'
    endif
    let       @/ = l:pattern
    let       @" = l:saved_reg
  endfunction
" }}
