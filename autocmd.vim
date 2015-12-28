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
  if &previewwindow || name =~# '^fugitive'
    nnoremap <buffer> q :<C-U>bdelete<CR>
    nnoremap <buffer> <esc> :<C-U>bdelete<CR>
  endif
  if &filetype ==# 'help'
    nnoremap <buffer> q :helpc<cr>
  endif
  if name =~# '/tmp/'
    setl bufhidden=delete
  endif
  unlet name
endfunction
" }}

" auto cloase preview{{
  autocmd CompleteDone * call AutoClosePreviewWindow()

  function! AutoClosePreviewWindow()
    if !&l:previewwindow
      pclose
    endif
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
  " autocmd FileType html let b:vcm_tab_complete = "omni"
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
    noremap  <script> <buffer> <silent> [] :call <SID>GotoSection(0)<cr>
    noremap  <script> <buffer> <silent> ]] :call <SID>GotoSection(1)<cr>
    noremap  <script> <buffer> <silent> [[ :call <SID>GotoSection(0)<cr>
    noremap  <script> <buffer> <silent> ][ :call <SID>GotoSection(1)<cr>
    onoremap <script> <buffer> <silent> [[ :<c-u>call <SID>SelectSection(0, 0)<cr>
    onoremap <script> <buffer> <silent> ][ :<c-u>call <SID>SelectSection(1, 0)<cr>
    vnoremap <script> <buffer> <silent> [[ :<c-u>call <SID>SelectSection(0, 1)<cr>
    vnoremap <script> <buffer> <silent> ][ :<c-u>call <SID>SelectSection(1, 1)<cr>
    onoremap <script> <buffer> <silent> if :<c-u>call <SID>SelectInsideFunction()<cr>
    onoremap <script> <buffer> <silent> af :<c-u>call <SID>SelectAllFunction()<cr>
    vnoremap <script> <buffer> <silent> if :<c-u>call <SID>SelectInsideFunction()<cr>
    vnoremap <script> <buffer> <silent> af :<c-u>call <SID>SelectAllFunction()<cr>
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

function! s:SelectInsideFunction()
  let sr = s:FindFunctionStart() + 1
  let er = s:FindFunctionEnd() - 1
  if sr == -1 || er == -1
    return
  endif
  execute 'normal! ' . sr . 'GV' . er . 'G'
endfunction

function! s:SelectAllFunction()
  let sr = s:FindFunctionStart()
  let er = s:FindFunctionEnd()
  if sr == -1 || er == -1
    return
  endif
  execute 'normal! ' . sr . 'GV' . er . 'G'
endfunction

function! s:SelectSection(close, visual)
  let cr = line('.')
  let tail = a:close ? 'End' : 'Start'
  let nr = cr
  execute "let nr = s:FindFunction" . tail . "()"
  if nr == -1 | return | endif
  let n = a:close ? nr - cr - 1 : cr - nr -1
  if n < 0
    return
  elseif n == 0
    execute 'normal! V'
  else
    execute 'normal! V' . n . (a:close ? 'j' : 'k')
  endif
endfunction

function! s:FindFunctionStart()
  let nr = line('.')
  let pi = indent(nr)
  while nr != 1
    let line = getline(nr - 1)
    let ci = indent(nr - 1)
    if line =~# '\v<function>' && ci < pi
      return nr - 1
    endif
    if line !~# '^\s*$' && ci < pi
      let pi = ci
    endif
    let nr = nr - 1
  endwhile
  return -1
endfunction

function! s:FindFunctionEnd()
  let start = s:FindFunctionStart()
  if start == -1 | return -1 | endif
  let ind = indent(start)
  let last = line('$')
  let nr = line('.')
  while nr != last
    if indent(nr + 1) == ind && getline(nr) !~# '^\s*$'
      return nr + 1
    endif
    let nr = nr + 1
  endwhile
  return -1
endfunction

function! s:GotoSection(close)
  let nr = -1
  let tail = a:close ? 'End' : 'Start'
  execute "let nr = s:FindFunction" . tail . "()"
  if nr == -1 | return | endif
  execute "normal! " . nr . "G" . (a:close ? '^' : '$')
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

" fish {{
  augroup fish
    autocmd!
    autocmd FileType fish setl noexpandtab
  augroup end
" }}

" json handlebar {{
" }}
