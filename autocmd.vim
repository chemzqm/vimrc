" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
" common file autocmd {{
augroup common
  autocmd!
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufReadPost *.log normal! G
  autocmd BufWinEnter * call s:OnBufEnter()
  autocmd BufWritePost * if get(b:, 'auto_execute', 0) == 1|execute 'Execute'|endif
  autocmd BufEnter ~/wechat-dev/* call s:SetWxapp()
  autocmd DirChanged,VimEnter * let &titlestring = s:ShortPath(getcwd())
  autocmd CursorHoldI,CursorMovedI * silent! call CocAction('showSignatureHelp')
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocQuickfixChange :Denite -mode=normal quickfix
  autocmd BufNewFile,BufReadPost *.json setf jsonc

  "autocmd BufLeave *.css,*.scss normal! mC
  "autocmd BufLeave *.html       normal! mH
  "autocmd BufLeave *.js         normal! mJ
  "autocmd BufLeave *.ts         normal! mJ
  " set up default omnifunc
  autocmd FileType *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endi
augroup end

function! s:ShortPath(p)
  return pathshorten(substitute(a:p, $HOME, '~', ''))
endfunction

function! s:SetWxapp()
  if &filetype ==# 'wxss'
    setl dictionary+=~/vim-dev/wxapp.vim/dict/wxss.dict
  elseif &filetype ==# 'json'
    setl dictionary+=~/vim-dev/wxapp.vim/dict/json.dict
  endif
endfunction

function! s:OnBufEnter()
  let name = bufname(+expand('<abuf>'))
  " quickly leave those temporary buffers
  if &previewwindow || name =~# '^term://'
    if !mapcheck('q', 'n')
      nnoremap <buffer> q :<C-U>bd!<CR>
    endif
  elseif name =~# '/tmp/'
    setl bufhidden=delete
  endif
  unlet name
endfunction
" }}
