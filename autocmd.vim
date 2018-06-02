" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
" common file autocmd {{
augroup common
  autocmd!
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufReadPost *.log normal! G
  autocmd BufWinEnter * call OnBufEnter()
  autocmd BufWritePost * if get(b:, 'auto_execute', 0) == 1|execute 'Execute'|endif
  autocmd BufEnter ~/wechat-dev/* call s:SetWxapp()
  autocmd BufEnter * let &titlestring = s:ShortPath(getcwd())
  " quickfix window will open when something adds to it
  autocmd QuickFixCmdPost * botright copen 8
  " set up default omnifunc
  autocmd Filetype *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup end

function! s:SignatureHelp()
  if &filetype ==# 'typescript'
    call LanguageClient#textDocument_signatureHelp()
  endif
endfunction

function! s:OnDeniteEnter()
  call feedkeys('<enter>')
endfunction

function! s:ShortPath(p)
  return pathshorten(substitute(a:p, $HOME, '~', ''))
endfunction

function! s:SetWxapp()
  if &filetype ==# 'wxss'
    setl dictionary+=~/vim-dev/wxapp.vim/dict/wxss.dict
  elseif &filetype ==# 'json'
    setl dictionary+=~/vim-dev/wxapp.vim/dict/json.dict
  elseif &filetype ==# 'json5'
    execute 'Vison wx-page.json'
  endif
endfunction

function! OnBufEnter()
  let name = bufname(+expand('<abuf>'))
  " quickly leave those temporary buffers
  if &previewwindow || name =~# '^term://'
    if !mapcheck('q', 'n')
      nnoremap <buffer> q :<C-U>bd!<CR>
    endif
  elseif &buftype ==# 'quickfix'
    nnoremap <buffer> q :<C-U>bd!<CR>
  elseif &buftype ==# 'terminal'
    nnoremap <buffer> q :<C-U>bd!<CR>
  elseif &buftype ==# 'help'
    nnoremap <buffer> q :<C-U>helpc<cr>
  elseif name =~# '/tmp/'
    setl bufhidden=delete
  endif
  unlet name
endfunction
" }}
