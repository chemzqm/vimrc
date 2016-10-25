nnoremap <silent> <D-[> :call macos#keycodes('option', 'command', 'left')<cr>
nnoremap <silent> <D-]> :call macos#keycodes('option', 'command', 'right')<cr>
nnoremap <silent> <D-i> :call macos#keycodes('option', 'command', 'space')<cr>
nnoremap <D-d> :bdelete!<cr>
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
nnoremap <D-s> :<C-u>wa!<cr>
inoremap <D-s> <C-o>:wa!<cr>
nnoremap <D-q> :<C-u>qa!<cr>
nnoremap <D-t> :tabe<cr>

nnoremap <D-c> "+y
inoremap <D-v> <C-o>"+p
