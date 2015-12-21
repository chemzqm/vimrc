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
  if &previewwindow || name =~# '^fugitive' || &filetype ==# 'help'
    nnoremap <buffer> q :<C-U>bdelete<CR>
    nnoremap <buffer> <esc> :<C-U>bdelete<CR>
  endif
  if name =~# '/tmp/'
    setl bufhidden=delete
  endif
  unlet name
endfunction
" }}

" css {{
augroup css
  autocmd!
  autocmd FileType css inoremap <buffer> { {<CR>}<C-o>O
augroup end
" }}

" javascript {{

augroup javascript
  autocmd!
  au FileType javascript :call s:SetJavaScript()
  au FileType javascript :call s:SetLoadFunctions()
  " use omnicomplete as I'm using tern
  autocmd FileType html let b:vcm_tab_complete = "omni"
augroup end

function! s:SetJavaScript()
    nnoremap <buffer> <leader>d :JsDoc<cr>
    setl foldnestmax=2
    setl foldmethod=syntax
    syn region foldbraces start=/{/ end=/}/ transparent fold keepend extend
    function! Foldtext()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    " use neocomplete
    setl dictionary+=~/.vim/dict/js.dict
    setl foldtext=Foldtext()
    setl si
    setl nofen
    setl textwidth=80
endfunction

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

" python {{
  augroup python
    autocmd!
    autocmd BufNewFile,BufRead *.jinja set syntax=htmljinja
    autocmd BufNewFile,BufRead *.mako set ft=mako
    autocmd FileType python set omnifunc=pythoncomplete#Complete
  augroup end
" }}

" html & xml {{
  augroup html
    autocmd!
    autocmd FileType html setlocal nowrap
    autocmd FileType htm setlocal foldmethod=manual
    autocmd FileType html setlocal foldnestmax=1
    let pandoc_pipeline  = 'pandoc --from=html --to=markdown'
    let pandoc_pipeline .= ' | pandoc --from=markdown --to=html'
    autocmd FileType html let &formatprg=pandoc_pipeline
  augroup end
" }}

" json handlebar {{
" }}
