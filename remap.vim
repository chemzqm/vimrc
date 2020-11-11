" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker:

" basic {{
  xnoremap J :m '>+1<CR>gv=gv
  xnoremap K :m '<-2<CR>gv=gv
  nnoremap Q <Nop>
  xnoremap < <gv
  xnoremap > >gv
  inoremap <C-v> <C-o>"+]p
  xnoremap <C-c> "+y
  nnoremap <expr> n  'Nn'[v:searchforward]
  nnoremap <expr> N  'nN'[v:searchforward]
  nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
  nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
  nnoremap <space>rl :source ~/.vimrc<CR>
  nnoremap Y y$
  " no overwrite paste
  xnoremap p "_dP
  " clear highlight update diff
  nnoremap <silent> <C-l> :let @/=''<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>
  " some shortcut for git
  nnoremap gci :Gcommit -v<CR>
  nnoremap gca :Gcommit -a -v<CR>
  nnoremap gcc :Gcommit -v -- <C-R>=expand('%')<CR><CR>
  nnoremap gp :CocCommand git.push<CR>
" }}

" insert keymap like emacs {{
  inoremap <C-w> <C-[>diwa
  inoremap <C-h> <BS>
  inoremap <C-d> <Del>
  inoremap <C-u> <C-G>u<C-U>
  inoremap <C-a> <Home>
  inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"

" command line alias {{
  cnoremap w!! w !sudo tee % >/dev/null
  cnoremap <C-p> <Up>
  cnoremap <C-n> <Down>
  cnoremap <C-j> <Left>
  cnoremap <C-k> <Right>
  cnoremap <C-b> <S-Left>
  cnoremap <C-f> <S-Right>
  cnoremap <C-a> <Home>
  cnoremap <C-e> <End>
  cnoremap <C-d> <Del>
  cnoremap <C-h> <BS>
  cnoremap <C-t> <C-R>=expand("%:p:h") . "/" <CR>
" }}

" meta keys {{
  vnoremap <M-c> "+y
  inoremap <M-v> <C-o>"+]p
  nnoremap <M-q> :qa!<cr>
  nnoremap <M-s> :silent! wa<cr>
  inoremap <M-s> <C-o>:w<cr>
  nnoremap <M-1> 1gt
  nnoremap <M-2> 2gt
  nnoremap <M-3> 3gt
  nnoremap <M-4> 4gt
  nnoremap <M-5> 5gt
  inoremap <M-1> <C-o>1gt
  inoremap <M-2> <C-o>2gt
  inoremap <M-3> <C-o>3gt
  inoremap <M-4> <C-o>4gt
  inoremap <M-5> <C-o>5gt
" }}

" plugins {{
  " buftabline
  nnoremap <leader>1 1gt
  nnoremap <leader>2 2gt
  nnoremap <leader>3 3gt
  nnoremap <leader>4 4gt
  nnoremap <leader>5 5gt
  nnoremap <leader>6 6gt
  nnoremap <leader>7 7gt
  nnoremap <leader>8 8gt

  " vim-exchange
  xmap x <Plug>(Exchange)

  " coc.nvim
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

  nmap <silent> <C-a> :call CocAction('runCommand', 'document.renameCurrentWord')<CR>
  nmap <silent> <C-c> <Plug>(coc-cursors-position)
  nmap <silent> <C-d> <Plug>(coc-cursors-word)
  xmap <silent> <C-d> <Plug>(coc-cursors-range)
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
  xmap <silent> <TAB> <Plug>(coc-repl-sendtext)
  nmap s <Plug>(coc-smartf-forward)
  nmap S <Plug>(coc-smartf-backward)
  nmap [g <Plug>(coc-git-prevchunk)
  nmap ]g <Plug>(coc-git-nextchunk)
  nmap gs <Plug>(coc-git-chunkinfo)
  nmap gm <Plug>(coc-git-commit)
  imap <C-l> <Plug>(coc-snippets-expand)
  xmap <C-l> <Plug>(coc-snippets-select)
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)
  nmap <silent> gt :call CocActionAsync('jumpDefinition', 'tabe')<CR>
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy :call CocActionAsync('jumpTypeDefinition', v:false)<CR>
  nmap <silent> gi :call CocActionAsync('jumpImplementation', v:false)<CR>
  nmap <silent> gr :call CocActionAsync('jumpUsed', v:false)<CR>
  nnoremap <silent> K :call CocActionAsync('doHover')<CR>
  " remap for complete to use tab and <cr>
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <silent><expr> <c-space> coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)
  omap ig <Plug>(coc-git-chunk-inner)
  xmap ig <Plug>(coc-git-chunk-inner)
  omap ag <Plug>(coc-git-chunk-outer)
  xmap ag <Plug>(coc-git-chunk-outer)
" }}

" visual search {{
  "  In visual mode when you press * or # to search for the current selection
  xnoremap    <silent> * :call <SID>visualSearch('f')<CR>
  xnoremap    <silent> # :call <SID>visualSearch('b')<CR>
" }}

" functions {{
function! s:visualSearch(direction)
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

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" }}

" list {{
  nnoremap <silent> \r  :<C-u>CocList -N mru -A<cr>
  nnoremap <silent><nowait> <space>h  :<C-u>CocList helptags<cr>
  nnoremap <silent><nowait> <space>g  :<C-u>CocList gstatus<CR>
  nnoremap <silent><nowait> <space>t  :<C-u>CocList buffers<cr>
  nnoremap <silent><nowait> <space>y  :<C-u>CocList yank<cr>
  nnoremap <silent><nowait> <space>u  :<C-u>CocList snippets<cr>
  nnoremap <silent><nowait> <space>w  :exe 'CocList -A -I --normal --input='.expand('<cword>').' words -w'<CR>
  nnoremap <silent><nowait> <space>l  :<C-u>CocList -I --ignore-case lines<CR>
  nnoremap <silent><nowait> <space>q  :<C-u>CocList quickfix<CR>
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  nnoremap <silent><nowait> <space>s  :<C-u>CocList symbols<cr>
  nnoremap <silent><nowait> <space>r  :<C-u>CocList mru<cr>
  nnoremap <silent><nowait> <space>f  :<C-u>CocList files<cr>
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}
