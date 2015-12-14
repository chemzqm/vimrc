" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=99:

" jsdoc settings {{
  let g:jsdoc_allow_input_prompt = 0
  let g:jsdoc_enable_es6 = 1
  let g:jsdoc_access_descriptions = 2
  let g:jsdoc_custom_args_hook = {
  \ 'callback\|cb': {
  \   'type': ' {Function} ',
  \   'description': 'Callback function'
  \ },
  \ 'n': {
  \   'type': ' {Number} '
  \ },
  \ 'arr': {
  \   'type': ' {Array} '
  \ },
  \ 'str': {
  \   'type': ' {String} '
  \ },
  \ 'el$': {
  \   'type': ' {Element} '
  \ },
  \ 'e': {
  \   'type': ' {Event} '
  \ },
  \ 'node': {
  \   'type': ' {Element} '
  \ },
  \ 'obj': {
  \   'type': ' {Object} '
  \ },
  \ 'fn': {
  \   'type': ' {Function} '
  \ },
  \ 'cb': {
  \   'type': ' {Function} '
  \ }
  \}
" }}

" {{
  function! SetJavaScript()
      nnoremap <buffer> <leader>/ :JsDoc<cr>
      nnoremap <buffer> <leader>ff :call JsBeautify()<cr>
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

  augroup javascript
    autocmd!
    au FileType javascript :call SetJavaScript()
    au FileType javascript :call SetLoadFunctions()
  augroup end
" }}

" functions {{
  function! SetLoadFunctions()
    command! -nargs=? -bar -buffer F  call LoadFunctions("c", <f-args>)
    command! -nargs=? -bar -buffer Ft call LoadFunctions("t", <f-args>)
    command! -nargs=? -bar -buffer Fr call LoadFunctions("r", <f-args>)
    command! -nargs=? -bar -buffer Fa call LoadFunctions("a", <f-args>)
    command! -nargs=? -bar -buffer Fe call LoadFunctions("e", <f-args>)
    command! -nargs=+ -bar -buffer -complete=custom,ListModules Fm call LoadFunctions("m", <f-args>)
  endfunction

  function! LoadFunctions(type, ...)
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
