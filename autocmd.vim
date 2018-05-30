" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
" common file autocmd {{
augroup common
  autocmd!
  autocmd BufReadPost *.log normal! G
  autocmd BufWinEnter * call OnBufEnter()
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufWritePost * if get(b:, 'auto_execute', 0) == 1|execute 'Execute'|endif
  autocmd BufEnter ~/wechat-dev/* call s:SetWxapp()
  autocmd BufEnter * let &titlestring = s:ShortPath(getcwd())
  autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
  " quickfix window will open when something adds to it
  autocmd QuickFixCmdPost * botright copen 8
  autocmd Filetype *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup end

augroup stay_no_lcd
  autocmd!
  autocmd User BufStaySavePre  if haslocaldir() | let w:lcd = getcwd() | cd - | cd - | endif
  autocmd User BufStaySavePost if exists('w:lcd') | execute 'lcd' fnameescape(w:lcd) | unlet w:lcd | endif
augroup END

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
  nmap <leader>sw <Plug>(WxOpenRelated)
  nmap <leader>da <Plug>(WxOpenDash)
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
  if name =~# 'icons.scss$'
    syntax clear
  endif
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

" javascript {{
augroup javascript
  autocmd!
  au FileType javascript :call s:SetLoadFunctions()
augroup end

function! s:SetLoadFunctions()
  command! -nargs=? -bar -buffer -complete=custom,s:LocalFunctions F call <SID>LoadFunctions("c", <f-args>)
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
    execute 'Denite func:m:'.a:1.' -input='.input
  else
    let input = a:0 ? a:1 : ''
    execute 'Denite func:'.type.' -input='.input
  endif
endfunction

function! s:LocalFunctions(A, ...)
  let lines = getline(1, '$')
  let res = system("parsefunc", lines)
  return join(map(split(res, '\n'), 'split(v:val, ":")[-1]'), "\n")
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
  let obj = json_decode(join(readfile(dir . '/package.json'), ''))
  let browser = exists('obj.browser') && type(obj.browser) == 4
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
