function! MyStatusSyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

function! MyStatusLine()
   "%2*%3.3{MyStatusModeMap()}%*"
  return s:GetPaste()
        \. "%4*%{MyStatusGit()}%*"
        \. " %f %{MyStatusModifySymbol()}"
        \. "%1*%{MyStatusReadonly()}%*"
        \. "%3* %{MyStatusSyntasticError()} %*"
        \. "%=%-{&ft} %{MyStatusBufnr()}"
"%{&fenc}
endfunction

function! MyStatusBufnr()
  if s:IsTempFile() | return '' | endif
  return bufnr('%') . ' '
endfunction

function! MyStatusModeMap()
  if s:IsTempFile() | return '' | endif
  return s:mode_map[mode()] . " "
endfunction

function! s:IsTempFile()
  if &buftype =~# '\v(help|nofile)' | return 1 | endif
  if &filetype ==# 'gitcommit' | return 1 | endif
  if expand('%:p') =~# '^/tmp' | return 1 | endif
endfunction

function! s:GetPaste()
  if !&paste | return '' |endif
  return "%#MyStatusPaste# paste %*"
endfunction

function! MyStatusReadonly()
  if !&readonly | return '' |endif
  return "   "
endfunction

function! MyStatusModifySymbol()
  return &mod ? '✨' : ''
endfunction

function! MyStatusGit() abort
  if s:IsTempFile() | return '' | endif
  if exists('b:git_branch') | return b:git_branch | endif
  let root = easygit#smartRoot(1)
  if empty(root) | return '' | endif
  let cwd = getcwd()
  exe 'lcd ' . root
  let cmd = 'git rev-parse --abbrev-ref HEAD'
  let output = system(cmd)
  if v:shell_error |
    call s:PrintError(output)
    exe 'lcd ' . cwd
    return ''
  else
    let more = ' ' . system('git-status')
    let b:git_branch = '   ' . substitute(output, '\v\n', '', '')
        \. more . ' '
    exe 'lcd ' . cwd
    return b:git_branch
  endif
endfunction

function! s:SetStatusLine()
  if &previewwindow | return | endif
  if &buftype ==# 'nofile' | return | endif
  if exists('b:git_branch') | unlet b:git_branch | endif
  setl statusline=%!MyStatusLine()
  call s:highlight()
endfunction

function! s:PrintError(msg)
  echohl Error | echon a:msg | echohl None
endfunction

function! s:highlight()
  hi User1         guifg=#66d9ef guibg=#333333 gui=none
  hi User1         ctermfg=81    ctermbg=67    cterm=none
  hi User2         guifg=#111111 guibg=#e6db74 gui=none
  hi User2         ctermfg=253   ctermbg=144   cterm=none
  hi User3         guifg=#FF001E guibg=#333333 gui=none
  hi User3         ctermfg=160   ctermbg=16    cterm=none
  if &bg ==# 'light'
    hi User4         guifg=#111111 guibg=#fdf6e3 gui=none
  else
    hi User4         guifg=#eee8d5 guibg=#222222 gui=none
  endif
  hi User4         ctermbg=16    cterm=none
  hi MyStatusPaste guifg=#F8F8F0 guibg=#FF5F00 gui=none
  hi MyStatusPaste ctermfg=202   ctermbg=16    cterm=none
endfunction

function! MyStatusSyntasticError()
   let errors = g:SyntasticLoclist.current().errors()
   if empty(errors) | return '' | endif
   let error = errors[0]
   return error.lnum . ' ' . error.text
endfunction

let s:mode_map = {
\ '__' : '-',
\ 'n'  : 'N',
\ 'i'  : 'I',
\ 'r'  : 'R',
\ 'R'  : 'R',
\ 'c'  : 'C',
\ 'v'  : 'V',
\ 'V'  : 'V',
\ '' : 'V',
\ 's'  : 'S',
\ 'S'  : 'S',
\ '' : 'S',
\ }

augroup statusline
  autocmd!
  autocmd BufWinEnter,ShellCmdPost,BufWritePost * call s:SetStatusLine()
  autocmd FileChangedShellPost,ColorScheme * call s:SetStatusLine()
  autocmd ShellCmdPost,FileWritePost * unlet! b:git_branch
augroup end

call s:SetStatusLine()

" vim:set et sw=2 ts=2 tw=78:
