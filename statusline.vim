function! MyStatusSyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

function! MyStatusLine()
  return "%2*%3.3{MyStatusModeMap()}%*"
        \. s:GetPaste()
        \. "%4*%0{MyStatusBranch()}%*"
        \. " %f %{MyStatusModifySymbol()}"
        \. "%1*%0{MyStatusReadonly()}%*"
        \. "%3* %{MyStatusSyntasticError()} %*"
        \. "%=%-5.10{&ft} "
"%{&fenc}
endfunction

function! MyStatusModeMap()
  if &buftype =~# '\v(help|nofile)' | return '' | endif
  if &filetype ==# 'gitcommit' | return '' | endif
  return s:mode_map[mode()] . " "
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

function! MyStatusBranch()
  if &buftype =~# '\v(help|nofile)' | return '' | endif
  if &filetype ==# 'gitcommit' | return '' | endif
  if exists('b:git_branch') | return b:git_branch | endif
  let b:git_dir = exists('b:git_dir') ? b:git_dir : finddir('.git', '.;')
  " no git dir found
  if empty(b:git_dir) | return '' | endif
  let cmd = 'git --git-dir=' . b:git_dir . ' rev-parse --abbrev-ref HEAD'
  let output = system(cmd)
  if v:shell_error && output !=# ""
    let b:git_branch = ''
    return b:git_branch
  endif
  let b:git_branch = '   ' . substitute(output, '\v\n', '', '') . ' '
  return b:git_branch
endfunction

function! s:SetStatusLine()
  if &previewwindow | return | endif
  if &buftype ==# 'nofile' | return | endif
  setl statusline=%!MyStatusLine()
  call s:highlight()
endfunction

function! s:highlight()
  hi User1         guifg=#66d9ef guibg=#333333 gui=none
  hi User1         ctermfg=81    ctermbg=67    cterm=none
  hi User2         guifg=#111111 guibg=#e6db74 gui=none
  hi User2         ctermfg=253   ctermbg=144   cterm=none
  hi User3         guifg=#FF001E guibg=#333333 gui=none
  hi User3         ctermfg=160   ctermbg=16    cterm=none
  hi User4         guibg=#111111 gui=none
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
  autocmd BufWinEnter * call s:SetStatusLine()
  autocmd BufReadPost * unlet! b:git_dir
  autocmd CursorHold,ShellCmdPost,CmdwinLeave * unlet! b:git_branch
augroup end

call s:SetStatusLine()
