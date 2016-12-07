function! MyStatusSyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

function! MyStatusLine()
  let errorMsg = has('nvim') ? "%= %3*%{MyStatusLocError()}%* %=" : ""
  return s:GetPaste()
        \. "%4*%{MyStatusGit()}%*"
        \. " %f %{MyStatusModifySymbol()}"
        \. " %{MyStatusReadonly()}"
        \. errorMsg
        \. "%=%-{&ft} %l, %c "
"%{&fenc}
endfunction

function! MyStatusBuf()
  if s:IsTempFile() | return '' | endif
  return bufnr('%') . ' '
endfunction

function! s:IsTempFile()
  if &buftype =~# '\v(help|nofile|terminal)' | return 1 | endif
  if &filetype ==# 'gitcommit' | return 1 | endif
  if expand('%:p') =~# '^/tmp' | return 1 | endif
endfunction

function! s:GetPaste()
  if !&paste | return '' |endif
  return "%#MyStatusPaste# paste %*"
endfunction

function! MyStatusReadonly()
  if !&readonly | return '' |endif
  return "  "
endfunction

function! MyStatusModifySymbol()
  return &modified ? '⚡' : ''
endfunction

function! MyStatusGit() abort
  if s:IsTempFile() | return '' | endif
  if exists('b:git_branch') | return b:git_branch | endif
  if !exists('*easygit#smartRoot') | return | endif
  let root = easygit#smartRoot(1)
  if empty(root) | return '' | endif
  let cwd = getcwd()
  exe 'lcd ' . root
  let cmd = 'git rev-parse --abbrev-ref HEAD'
  let output = system(cmd)
  if v:shell_error |
    exe 'lcd ' . cwd
    let b:git_branch = '?'
    return '?'
  else
    let more = ' ' . system('git-status')
    let b:git_branch = '   ' . substitute(output, '\v\n', '', '')
        \. more . ' '
    exe 'lcd ' . cwd
    return b:git_branch
  endif
endfunction

function! SetStatusLine()
  if &previewwindow | return | endif
  if &buftype =~# '\v(nofile|terminal)' | return | endif
  if exists('b:git_branch') | unlet b:git_branch | endif

  setl statusline=%!MyStatusLine()
  call s:highlight()
endfunction

function! s:PrintError(msg)
  echohl Error | echon a:msg | echohl None
endfunction

function! s:highlight()
  hi User3         guifg=#FF001E guibg=#111111    gui=none
  hi MyStatusPaste guifg=#F8F8F0 guibg=#FF5F00 gui=none
  hi MyStatusPaste ctermfg=202   ctermbg=16    cterm=none
  hi user4 guifg=#f8f8ff guibg=#000000
endfunction

function! MyStatusLocError()
  if s:IsTempFile() | return ''| endif
  let list = filter(getloclist('%'), 'v:val["type"] ==# "E"')
  if len(list)
    return ' ' . string(list[0].lnum) . ' ' . list[0].text
  else
    return ''
  endif
endfunction

augroup statusline
  autocmd!
  autocmd BufWinEnter,ShellCmdPost,BufWritePost * call SetStatusLine()
  autocmd FileChangedShellPost,ColorScheme * call SetStatusLine()
  autocmd FileReadPre,ShellCmdPost,FileWritePost * unlet! b:git_branch
  autocmd VimEnter * call SetStatusLine()
augroup end
