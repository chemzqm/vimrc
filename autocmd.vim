" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:

" file read {{
augroup fileRead
  autocmd!
  autocmd BufReadPost *.log normal! G
  autocmd BufWinEnter * call OnBufEnter()
augroup end

function! OnBufEnter()
  let name = bufname('%')
  " quickly leave those temporary buffers
  if &previewwindow || name =~# '^__run' || name =~# 'COMMIT_EDITMSG$'
    nnoremap <buffer> q :<C-U>bdelete<CR>
    "nnoremap <buffer> <esc> :<C-U>bdelete<CR>
  elseif &buftype ==# 'help'
    nnoremap <buffer> q :helpc<cr>
  elseif name =~# '/tmp/'
    setl bufhidden=delete
  endif
  unlet name
endfunction
" }}

" auto cloase preview{{
augroup complete
  autocmd!
  autocmd CompleteDone * call AutoClosePreviewWindow()
augroup end

function! AutoClosePreviewWindow()
  if !&l:previewwindow
    pclose
  endif
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

" html {{
augroup html
  autocmd!
  autocmd FileType html : csll s:SetHtml()
augroup end

function! s:SetHtml()
  setl nowrap
  setl foldmethod=manual
  setl formatprg=tidy\ -i\ -q\ -w\ 160
  exec 'UltiSnipsAddFiletypes html.css'
endfunction
" }}
