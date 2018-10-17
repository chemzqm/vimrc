" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
" common file autocmd {{
augroup common
  autocmd!
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufReadPost *.log normal! G
  autocmd BufWinEnter * call s:OnBufEnter()
  autocmd DirChanged,VimEnter * let &titlestring = pathshorten(substitute(getcwd(), $HOME, '~', ''))
  autocmd CursorHold,CursorHoldI,CursorMovedI * silent! call CocAction('showSignatureHelp')
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd BufNewFile,BufReadPost *.json setf jsonc
  autocmd BufNewFile,BufReadPost *.ejs setf html
  autocmd BufLeave *.css,*.scss normal! mC
  autocmd BufLeave *.html       normal! mH
  autocmd BufLeave *.js         normal! mJ
  autocmd BufEnter,FocusGained * checktime
  autocmd User CocQuickfixChange :Denite -mode=normal quickfix
  autocmd BufReadCmd,FileReadCmd,SourceCmd jdt://* call s:LoadJavaContent(expand("<amatch>"))
  "autocmd User CocQuickfixChange :call fzf_quickfix#run()

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

function! s:OnBufEnter()
  let name = bufname(+expand('<abuf>'))
  " quickly leave those temporary buffers
  if &previewwindow || name =~# '^term://' || &buftype ==# 'nofile' || &buftype ==# 'help'
    if !mapcheck('q', 'n')
      nnoremap <buffer> q :<C-U>bd!<CR>
    endif
  elseif name =~# '/tmp/'
    setl bufhidden=delete
  endif
  unlet name
endfunction

function! s:LoadJavaContent(uri)
  setfiletype java
  let content = CocRequest('java', 'java/classFileContents', {'uri': a:uri})
  call setline(1, split(content, "\n"))
  setl nomodified
  setl readonly
endfunction
" }}
