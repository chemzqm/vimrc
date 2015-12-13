" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker:

" word {{
  inoremap <C-u> <esc>BveUei
  nnoremap <C-u> BveUe
" }}

" line {{
  " Visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv
  " yank to end
  nnoremap Y y$
" }}

" window {{
  nnoremap <c-l> <c-w>l
  nnoremap <c-h> <c-w>h
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
" }}

" tab {{
  noremap <D-1> 1gt
  noremap <D-2> 2gt
  noremap <D-3> 3gt
  noremap <D-4> 4gt
  noremap <D-5> 5gt
  inoremap <D-1> <C-o>1gt
  inoremap <D-2> <C-o>2gt
  inoremap <D-3> <C-o>3gt
  inoremap <D-4> <C-o>4gt
  inoremap <D-5> <C-o>5gt
" }}

" file & buffer {{
  nnoremap <D-d> :bdelete<cr>
" }}

" command line alias {{
  " Change Working Directory to that of the current file
  " For when you forget to sudo.. Really Write the file.
  cnoremap w!! w !sudo tee % >/dev/null
  cnoremap $v ~/.vimrc
  cnoremap $q <C-\>eDeleteTillSlash()<cr>
  cnoremap $n NeoCompleteDisable
  cnoremap %% <C-R>=expand('%:p:h').'/'<cr>
" }}

" mac command line alias {{
  vnoremap <D-x> :!pbcopy<cr>
  vnoremap <D-c> :w !pbcopy<cr><cr>
  inoremap <D-v> <C-o>:r !pbpaste<cr>
" }}

" search {{
  "  In visual mode when you press * or # to search for the current selection
  vnoremap <silent> * :call <SID>visualSearch('f')<CR>
  vnoremap <silent> # :call <SID>visualSearch('b')<CR>

  function! s:visualSearch(direction)
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
      execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'f'
      execute "normal /" . l:pattern . "^M"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
  endfunction
" }}
