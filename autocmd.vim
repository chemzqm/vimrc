" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:

augroup rubycomplete
  autocmd!
  "autocmd FileType ruby,eruby call rubycomplete#Init()
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
augroup end

" common file autocmd {{
augroup common
  autocmd!
  autocmd BufReadPost *.log normal! G
  autocmd BufEnter * call OnBufEnter()
  autocmd CompleteDone * pclose
  autocmd BufWritePost * if get(b:, 'auto_execute', 0) == 1|execute 'Execute'|endif
  autocmd BufWritePost * Neomake
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  autocmd BufEnter term://* startinsert
  autocmd BufEnter ~/wechat-dev/* call s:SetWxapp()
  autocmd BufWritePost *.wxml call macos#keycodes('command', 'shift', 'r')
  autocmd BufWritePost *.wxss call macos#keycodes('command', 'shift', 'r')
augroup end

augroup stay_no_lcd
  autocmd!
  autocmd User BufStaySavePre  if haslocaldir() | let w:lcd = getcwd() | cd - | cd - | endif
  autocmd User BufStaySavePost if exists('w:lcd') | execute 'lcd' fnameescape(w:lcd) | unlet w:lcd | endif
augroup END

function! s:SetWxapp()
  command! -nargs=0 Start :call wxapp#start()
  if &ft ==# 'javascript'
    setl dictionary+=~/vim-dev/wxapp.vim/dict/js.dict
  elseif &ft ==# 'wxml'
    setl dictionary+=~/vim-dev/wxapp.vim/dict/wxml.dict
  elseif &ft ==# 'wxss'
    setl dictionary+=~/vim-dev/wxapp.vim/dict/wxss.dict
  endif
endfunction

function! OnBufEnter()
  let name = bufname(+expand('<abuf>'))
  " quickly leave those temporary buffers
  if name =~# 'icons.scss$'
    syntax clear
  endif
  if &previewwindow || name =~# '^term://'
    if !mapcheck('q', 'n')
      nnoremap <buffer> q :<C-U>bd!<CR>
    endif
  elseif &buftype ==# 'terminal'
    nnoremap <buffer> q :<C-U>bd!<CR>
  elseif &buftype ==# 'help'
    nnoremap <buffer> q :helpc<cr>
  elseif name =~# '/tmp/'
    setl bufhidden=delete
  endif
  unlet name
endfunction
" }}

" javascript {{
augroup javascript
  autocmd!
  au FileType javascript :call s:SetLoadFunctions()
augroup end

function! s:SetLoadFunctions()
  command! -nargs=? -bar -buffer F  call <SID>LoadFunctions("c", <f-args>)
  command! -nargs=? -bar -buffer Ft call <SID>LoadFunctions("t", <f-args>)
  command! -nargs=? -bar -buffer Fr call <SID>LoadFunctions("r", <f-args>)
  command! -nargs=? -bar -buffer Fa call <SID>LoadFunctions("a", <f-args>)
  command! -nargs=? -bar -buffer Fe call <SID>LoadFunctions("e", <f-args>)
  command! -nargs=+ -bar -buffer -complete=custom,s:ListModules Fm call <SID>LoadFunctions("m", <f-args>)
endfunction

function! s:LoadFunctions(type, ...)
  let type = a:type ==# 'a' ? 'm' : a:type
  if a:type ==# 'm'
    let input = a:0 > 1 ? a:2 : ''
    execute 'Unite func -buffer-name=func -custom-func-type=' . type
            \. ' -custom-func-name=' . a:1 . ' -input=' . input
  else
    let input = a:0 ? a:1 : ''
    execute 'Unite func -buffer-name=func -custom-func-type=' . type
            \. ' -input=' . input
  endif
endfunction
" }}

function! s:GetPackageDir()
  let file = findfile('package.json', '.;')
  if empty(file)
    echohl Error | echon 'project root not found' | echohl None
    return
  endif
  return fnamemodify(file, ':h')
endfunction

function! s:ListModules(A, L, P) abort
  let dir = s:GetPackageDir()
  if empty(dir) | return | endif
  let obj = webapi#json#decode(join(readfile(dir . '/package.json'), ''))
  let browser = exists('obj.browser')
  let list = []
  let deps = browser ? keys(obj.browser) : []
  let vals = browser ? values(obj.browser) : []
  for key in keys(obj.dependencies)
    let i = index(vals, key)
    if i == -1
      call add(list, key)
    else
      call add(list, deps[i])
    endif
  endfor
  return join(list, "\n")
endfunction
