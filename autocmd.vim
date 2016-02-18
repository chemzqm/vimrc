" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:

" common file autocmd {{
augroup common
  autocmd!
  autocmd BufReadPost *.log normal! G
  autocmd BufEnter * call OnBufEnter()
  autocmd CompleteDone * pclose
  autocmd WinEnter * set imd|set noimd
  autocmd TabEnter * set imd|set noimd
  autocmd BufWritePost * if get(b:, 'auto_execute', 0) == 1|execute 'Execute'|endif
augroup end

function! OnBufEnter()
  let name = bufname(+expand('<abuf>'))
  " quickly leave those temporary buffers
  if &previewwindow || name =~# '^__run' || name =~# '^term://'
    if !mapcheck('q', 'n')
      nnoremap <buffer> q :<C-U>bd!<CR>
    endif
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
  command! -nargs=+ -bar -buffer -complete=custom,ListModules Fm call <SID>LoadFunctions("m", <f-args>)
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
